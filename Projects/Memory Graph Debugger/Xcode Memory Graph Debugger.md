Huy, đây là một project mẫu có chứa sẵn các lỗi memory phổ biến để thực hành Memory Graph Debugger.Project này có **5 loại memory leak phổ biến** được cài sẵn để thực hành:

```
// ============================================================
// 📁 Tạo project iOS App mới trong Xcode, paste từng phần vào
// file tương ứng. Chạy app → dùng Memory Graph Debugger để tìm leak.
// ============================================================

// MARK: - 1️⃣ BUG: Strong Reference Cycle giữa 2 objects
// File: Models/NetworkService.swift

protocol NetworkServiceDelegate: AnyObject { // ✅ AnyObject cho weak
    func didFetchData(_ data: [String])
}

class NetworkService {
    // 🐛 BUG: delegate STRONG → retain cycle với ViewController
    var delegate: NetworkServiceDelegate? // Thiếu `weak`
    
    var cachedData: [String] = []
    
    func fetchUsers() {
        // Giả lập network call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [self] in
            self.cachedData = (1...1000).map { "User \($0)" }
            DispatchQueue.main.async {
                self.delegate?.didFetchData(self.cachedData)
            }
        }
    }
    
    deinit { print("🟢 NetworkService deinit") }
}


// MARK: - 2️⃣ BUG: Closure Retain Cycle
// File: ViewModels/UserViewModel.swift

class UserViewModel {
    var users: [String] = []
    var onUpdate: (() -> Void)?
    
    // 🐛 BUG: Timer giữ strong ref tới self qua closure
    private var refreshTimer: Timer?
    
    func startAutoRefresh() {
        refreshTimer = Timer.scheduledTimer(
            withTimeInterval: 30,
            repeats: true
        ) { _ in  // 🐛 BUG: capture self mạnh
            self.refreshData()
        }
    }
    
    func refreshData() {
        users.append("New User \(Int.random(in: 1...999))")
        onUpdate?()
    }
    
    deinit {
        refreshTimer?.invalidate()
        print("🟢 UserViewModel deinit")
    }
}


// MARK: - 3️⃣ BUG: Closure capturing self trong escaping context
// File: Managers/ImageCacheManager.swift

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    // Giữ strong ref tới tất cả completion handlers
    private var pendingHandlers: [String: () -> Void] = [:]
    
    func preloadImage(
        for key: String,
        completion: @escaping () -> Void
    ) {
        // 🐛 BUG: Handler được lưu vĩnh viễn, không bao giờ remove
        pendingHandlers[key] = completion
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                completion()
                // Thiếu: self.pendingHandlers.removeValue(forKey: key)
            }
        }
    }
    
    var handlerCount: Int { pendingHandlers.count }
}


// MARK: - 4️⃣ BUG: Parent-Child Retain Cycle
// File: Models/Comment.swift

class Post {
    let title: String
    var comments: [Comment] = []
    
    init(title: String) { self.title = title }
    
    func addComment(_ text: String) {
        let comment = Comment(text: text, post: self)
        comments.append(comment)
    }
    
    deinit { print("🟢 Post deinit") }
}

class Comment {
    let text: String
    // 🐛 BUG: Strong ref ngược về parent → cycle
    var post: Post? // Thiếu `weak`
    
    init(text: String, post: Post) {
        self.text = text
        self.post = post
    }
    
    deinit { print("🟢 Comment deinit") }
}


// MARK: - 5️⃣ ViewController tổng hợp tất cả bugs
// File: ViewControllers/LeakyViewController.swift

import UIKit

class LeakyViewController: UIViewController,
                           NetworkServiceDelegate {
    
    private let networkService = NetworkService()
    private let viewModel = UserViewModel()
    private let tableView = UITableView()
    private let countLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leaky Screen"
        view.backgroundColor = .systemBackground
        setupUI()
        
        // 🐛 BUG 1: Strong delegate cycle
        networkService.delegate = self
        
        // 🐛 BUG 2: Closure cycle trong viewModel
        viewModel.onUpdate = {
            self.tableView.reloadData() // self bị capture strong
        }
        viewModel.startAutoRefresh()
        
        // 🐛 BUG 3: self bị giữ trong singleton cache
        ImageCacheManager.shared.preloadImage(for: "avatar") {
            self.countLabel.text = "Loaded"
        }
        
        // 🐛 BUG 4: Post-Comment retain cycle
        createSamplePosts()
        
        networkService.fetchUsers()
    }
    
    private var posts: [Post] = []
    
    private func createSamplePosts() {
        for i in 1...5 {
            let post = Post(title: "Post \(i)")
            post.addComment("Great post!")
            post.addComment("Thanks for sharing")
            posts.append(post)
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = "Loading..."
        countLabel.textAlignment = .center
        view.addSubview(countLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(
                equalTo: countLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - NetworkServiceDelegate
    func didFetchData(_ data: [String]) {
        viewModel.users = data
        countLabel.text = "\(data.count) users"
        tableView.reloadData()
    }
    
    deinit { print("🟢 LeakyViewController deinit") }
}

extension LeakyViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.users.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.users[indexPath.row]
        return cell
    }
}


// MARK: - 6️⃣ Entry Point - Push & Pop để trigger leak
// File: ViewControllers/HomeViewController.swift

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
        let button = UIButton(type: .system)
        button.setTitle("Open Leaky Screen", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(
            self, action: #selector(openLeaky), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func openLeaky() {
        let vc = LeakyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - 7️⃣ SceneDelegate
// File: SceneDelegate.swift
/*
 func scene(_ scene: UIScene, willConnectTo ...) {
     guard let windowScene = (scene as? UIWindowScene) else { return }
     let window = UIWindow(windowScene: windowScene)
     let nav = UINavigationController(
         rootViewController: HomeViewController()
     )
     window.rootViewController = nav
     window.makeKeyAndVisible()
     self.window = window
 }
*/


// ============================================================
// 📋 HƯỚNG DẪN THỰC HÀNH
// ============================================================
/*
 
 ┌─────────────────────────────────────────────────────┐
 │           CÁCH TÁI TẠO MEMORY LEAK                 │
 └─────────────────────────────────────────────────────┘
 
 1. Chạy app trên Simulator
 2. Tap "Open Leaky Screen" → đợi data load
 3. Tap Back để pop LeakyViewController
 4. Lặp lại bước 2-3 khoảng 3 lần
 5. ❌ Không thấy "🟢 LeakyViewController deinit" trong console
    → Chứng tỏ có memory leak!
 
 ┌─────────────────────────────────────────────────────┐
 │         SỬ DỤNG MEMORY GRAPH DEBUGGER               │
 └─────────────────────────────────────────────────────┘
 
 Sau bước 4 ở trên:
 
 1. Click nút "Debug Memory Graph" trên Debug bar
    (icon 3 hình tròn nối nhau, nằm giữa thanh debug)
    
 2. Trong Navigator bên trái:
    - Tìm "LeakyViewController" → vẫn còn tồn tại!
    - Tìm "NetworkService", "UserViewModel", "Post", "Comment"
    - Số instance sẽ tăng mỗi lần push/pop
    
 3. Click vào instance → xem Memory Graph:
    - Mũi tên = strong reference
    - Tìm các CYCLE (vòng tròn mũi tên)
    
 4. Bật "Show only leaked blocks" (icon ⚠️ bên dưới navigator)
    → Filter chỉ hiện leaked objects
 
 5. Xem Backtrace (bên phải) để biết object được tạo ở đâu
    ⚙️ Bật: Product → Scheme → Edit Scheme →
       Diagnostics → ✅ Malloc Stack Logging = "Live Allocations Only"

 ┌─────────────────────────────────────────────────────┐
 │         CÁC LEAK CẦN TÌM & FIX                     │
 └─────────────────────────────────────────────────────┘
 
 🐛 Leak 1: NetworkService ↔ LeakyViewController
    Graph: VC → networkService → delegate → VC  (cycle!)
    Fix:   weak var delegate: NetworkServiceDelegate?
 
 🐛 Leak 2: Timer → UserViewModel
    Graph: RunLoop → Timer → closure → UserViewModel
    Fix:   [weak self] trong Timer closure
 
 🐛 Leak 3: viewModel.onUpdate closure
    Graph: VC → viewModel → onUpdate → VC  (cycle!)
    Fix:   viewModel.onUpdate = { [weak self] in ... }
 
 🐛 Leak 4: ImageCacheManager singleton giữ VC
    Graph: singleton → pendingHandlers → closure → VC
    Fix:   [weak self] + removeValue(forKey:) sau khi complete
 
 🐛 Leak 5: Post ↔ Comment
    Graph: Post → comments → Comment → post → Post  (cycle!)
    Fix:   weak var post: Post?
 
 ┌─────────────────────────────────────────────────────┐
 │              BÀI TẬP NÂNG CAO                       │
 └─────────────────────────────────────────────────────┘
 
 Sau khi fix tất cả bugs:
 
 ✅ Push/Pop 3 lần → console phải in "🟢 ... deinit" mỗi lần
 ✅ Memory Graph Debugger không còn instance nào của LeakyVC
 ✅ Dùng Instruments → Leaks template để double-check
 ✅ So sánh memory footprint trước/sau khi fix
    (Debug Navigator → Memory gauge)
 
*/
```

**Các bug cần tìm bằng Memory Graph Debugger:**

1. **Strong delegate cycle** — `NetworkService.delegate` thiếu `weak`, tạo vòng tròn với ViewController
2. **Timer retain cycle** — `Timer.scheduledTimer` closure capture `self` mạnh, khiến `UserViewModel` không bao giờ dealloc
3. **Closure capture cycle** — `viewModel.onUpdate` closure giữ strong ref ngược về VC
4. **Singleton giữ closure** — `ImageCacheManager.shared` lưu completion handler chứa `self` vĩnh viễn
5. **Parent-Child cycle** — `Post ↔ Comment` strong ref lẫn nhau

**Cách thực hành:**

Tạo project mới → paste code → chạy app → push vào "Leaky Screen" → pop ra → lặp lại 3 lần. Khi không thấy `deinit` được print trong console, bấm nút **Debug Memory Graph** (icon 3 hình tròn nối nhau trên debug bar). Tại đó sẽ thấy rõ các instance bị leak và đồ thị reference cycle giữa chúng.

Nhớ bật **Malloc Stack Logging** trong Scheme → Diagnostics để có backtrace chi tiết cho mỗi allocation.