import UIKit
import MapKit

// MARK: - 1. CORE LOGIC: Bottom Sheet Controller
// Class này chịu trách nhiệm quản lý gesture, animation và logic 3 nấc
import UIKit

class NativeSheetController: UIViewController, UIGestureRecognizerDelegate {
    
    // 3 Trạng thái
    enum SheetState {
        case full
        case half
        case tip
    }
    
    // UI Elements
    private let containerView = UIView()
    private let grabberHandle = UIView()
    private let contentView = UIView()
    
    // Layout Constraints (Để thay đổi khi xoay màn hình)
    private var topConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    
    // Logic
    private var stateYPositions: [SheetState: CGFloat] = [:]
    private var currentState: SheetState = .half
    private var runningAnimator: UIViewPropertyAnimator?
    private weak var trackedScrollView: UIScrollView?
    
    // Config
    private let cornerRadius: CGFloat = 16.0
    private let landscapePanelWidth: CGFloat = 380.0 // Chiều rộng panel khi quay ngang
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Tính lại vị trí các nấc (vì chiều cao màn hình thay đổi)
        calculateYPositions()
        updateLayoutForOrientation()
        
        // Snap về vị trí hợp lý nếu không đang kéo
        if runningAnimator == nil {
            animateToState(currentState, duration: 0)
        }
    }
    
    // Khi xoay màn hình, hệ thống gọi hàm này
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateLayoutForOrientation()
    }
    
    // MARK: - Public API (Giữ nguyên)
    func setContent(viewController: UIViewController) {
        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        viewController.didMove(toParent: self)
    }
    
    func trackScrollView(_ scrollView: UIScrollView) {
        self.trackedScrollView = scrollView
        scrollView.panGestureRecognizer.require(toFail: view.gestureRecognizers!.first!)
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .clear
        
        // Container
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = cornerRadius
        // Khi xoay ngang, ta muốn bo cả 4 góc hoặc chỉ 2 góc trên tùy thiết kế
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Shadow
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Grabber
        grabberHandle.backgroundColor = .systemGray4
        grabberHandle.layer.cornerRadius = 2.5
        grabberHandle.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(grabberHandle)
        
        // Content Holder
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        
        // --- CONSTRAINTS SETUP ---
        topConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        
        // Các constraint cho Portrait/Landscape
        leadingConstraint = containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        trailingConstraint = containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        widthConstraint = containerView.widthAnchor.constraint(equalToConstant: landscapePanelWidth)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // Luôn chạm đáy
            topConstraint,
            leadingConstraint, // Luôn neo bên trái (trong Portrait trái=0, Landscape trái=safeArea)
            
            // Grabber
            grabberHandle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            grabberHandle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            grabberHandle.heightAnchor.constraint(equalToConstant: 5),
            grabberHandle.widthAnchor.constraint(equalToConstant: 36),
            
            // Content
            contentView.topAnchor.constraint(equalTo: grabberHandle.bottomAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Mặc định kích hoạt Trailing (cho Portrait)
        trailingConstraint.isActive = true
        widthConstraint.isActive = false
    }
    
    // MARK: - Adaptive Layout Logic (Xử lý Xoay)
    private func updateLayoutForOrientation() {
        // Kiểm tra Size Class để biết đang là Dọc hay Ngang
        // (Trên iPhone: Dọc = Compact Width, Ngang = Regular Width (trừ dòng mini/SE))
        // Cách đơn giản hơn là check bounds
        let isLandscape = view.bounds.width > view.bounds.height
        
        if isLandscape {
            // LANDSCAPE MODE: Neo trái, cố định chiều rộng
            trailingConstraint.isActive = false
            widthConstraint.isActive = true
            
            // Bo góc đẹp hơn khi ở chế độ card
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            // Cách đáy một chút cho đẹp (giống Floating Panel)
            // (Bạn có thể bỏ dòng dưới nếu muốn nó dính sát đáy)
             // containerView.bottomAnchor... (Logic này cần sửa constraint nếu muốn float hoàn toàn)
        } else {
            // PORTRAIT MODE: Full chiều ngang
            widthConstraint.isActive = false
            trailingConstraint.isActive = true
            
            // Chỉ bo 2 góc trên
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Logic 3 Nấc (Updated for Landscape)
    private func calculateYPositions() {
        let safeAreaTop = view.safeAreaInsets.top
        let safeAreaBottom = view.safeAreaInsets.bottom
        let totalHeight = view.bounds.height
        
        // Tính toán lại các mốc tọa độ Y
        // Khi xoay ngang, chiều cao màn hình thấp hơn, cần tinh chỉnh padding
        
        let fullY: CGFloat
        let halfY: CGFloat
        let tipY: CGFloat
        
        let isLandscape = view.bounds.width > view.bounds.height
        
        if isLandscape {
            // Landscape config
            fullY = safeAreaTop + 10 // Sát đỉnh hơn vì màn hình thấp
            halfY = totalHeight * 0.4 // Nửa thấp hơn chút
            tipY = totalHeight - (60 + safeAreaBottom) // Tip nhỏ
        } else {
            // Portrait config
            fullY = safeAreaTop + 16
            halfY = totalHeight * 0.55
            tipY = totalHeight - (80 + safeAreaBottom)
        }
        
        stateYPositions = [
            .full: fullY,
            .half: halfY,
            .tip: tipY
        ]
    }
    
    // MARK: - Physics & Pan Logic (Giữ nguyên)
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        
        switch recognizer.state {
        case .began:
            stopAnimation()
        case .changed:
            let currentTargetY = stateYPositions[currentState] ?? 0
            var newY = currentTargetY + translation.y
            
            // Rubber banding at top
            let fullY = stateYPositions[.full]!
            if newY < fullY {
                let diff = fullY - newY
                newY = fullY - (diff * 0.5)
            }
            
            topConstraint.constant = newY
            recognizer.setTranslation(.zero, in: view)
            
        case .ended:
            let currentY = topConstraint.constant
            let projectedY = currentY + project(initialVelocity: velocity.y)
            let targetState = nearestState(to: projectedY)
            animateToState(targetState)
            
        default:
            break
        }
    }
    
    private func project(initialVelocity: CGFloat, decelerationRate: CGFloat = 0.996) -> CGFloat {
        return (initialVelocity / 1000.0) * decelerationRate / (1.0 - decelerationRate)
    }
    
    private func nearestState(to projectedY: CGFloat) -> SheetState {
        var nearest: SheetState = .half
        var minDistance = CGFloat.greatestFiniteMagnitude
        
        for (state, yPos) in stateYPositions {
            let distance = abs(yPos - projectedY)
            if distance < minDistance {
                minDistance = distance
                nearest = state
            }
        }
        return nearest
    }
    
    private func animateToState(_ state: SheetState, duration: TimeInterval = 0.5) {
        self.currentState = state
        let targetY = stateYPositions[state] ?? 0
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
            self.topConstraint.constant = targetY
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
        self.runningAnimator = animator
    }
    
    private func stopAnimation() {
        runningAnimator?.stopAnimation(true)
        runningAnimator = nil
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = trackedScrollView else { return false }
        if otherGestureRecognizer.view == scrollView {
            if scrollView.contentOffset.y <= 0 {
                return true
            }
        }
        return false
    }
}
