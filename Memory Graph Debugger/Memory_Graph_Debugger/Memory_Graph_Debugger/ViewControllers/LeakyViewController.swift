import Foundation

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
