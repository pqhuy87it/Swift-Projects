import UIKit

class NativeSheetController: UIViewController, UIGestureRecognizerDelegate {
    
    // 3 Trạng thái của Panel
    enum SheetState {
        case full
        case half
        case tip
    }
    
    // UI Elements
    private let containerView = UIView()
    private let grabberView = UIView()
    private var contentViewController: UIViewController?
    
    // Constraints
    private var topConstraint: NSLayoutConstraint!
    
    // Cấu hình chiều cao (Tính toán Y position cho từng nấc)
    private var stateYPositions: [SheetState: CGFloat] = [:]
    
    // Logic kéo thả
    private var currentState: SheetState = .half
    private var runningAnimator: UIViewPropertyAnimator?
    private weak var trackedScrollView: UIScrollView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculateStatePositions()
        
        // Nếu không đang kéo thì luôn neo vào trạng thái hiện tại
        if runningAnimator == nil {
            animateToState(currentState, duration: 0)
        }
    }
    
    // MARK: - Setup & Configuration
    func setContent(vc: UIViewController) {
        self.contentViewController = vc
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30), // Chừa chỗ cho grabber
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        vc.didMove(toParent: self)
    }
    
    func trackScrollView(_ scrollView: UIScrollView) {
        self.trackedScrollView = scrollView
        scrollView.panGestureRecognizer.require(toFail: view.gestureRecognizers!.first!)
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        // Container View
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Shadow (Giống Apple Maps)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 0, height: -4)
        containerView.layer.shadowRadius = 10
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Grabber
        grabberView.backgroundColor = .systemGray4
        grabberView.layer.cornerRadius = 3
        grabberView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(grabberView)
        
        // Setup Constraints ban đầu
        topConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // Neo đáy
            topConstraint, // Điều khiển chiều cao bằng topConstraint
            
            grabberView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            grabberView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 40),
            grabberView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    // Tính toán tọa độ Y cho 3 nấc dựa trên kích thước màn hình hiện tại
    private func calculateStatePositions() {
        let safeAreaTop = view.safeAreaInsets.top
        let safeAreaBottom = view.safeAreaInsets.bottom
        let height = view.bounds.height
        
        // 1. Full: Cách đỉnh Safe Area một chút (ví dụ 16pt)
        let fullY = safeAreaTop + 16
        
        // 2. Half: Gần giữa màn hình
        let halfY = height * 0.55
        
        // 3. Tip: Chỉ hiện một phần dưới đáy (ví dụ 80pt + safe area)
        let tipY = height - (80 + safeAreaBottom)
        
        stateYPositions = [
            .full: fullY,
            .half: halfY,
            .tip: tipY
        ]
    }
    
    // MARK: - Logic Kéo Thả (Physics-based)
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        
        switch recognizer.state {
        case .began:
            stopAnimation()
        case .changed:
            let currentY = stateYPositions[currentState]!
            var newY = currentY + translation.y
            
            // Hiệu ứng kháng lực (Rubber banding) khi kéo quá Full
            let fullY = stateYPositions[.full]!
            if newY < fullY {
                let diff = fullY - newY
                newY = fullY - (diff * 0.5) // Kháng lực 50%
            }
            
            topConstraint.constant = newY
            
        case .ended:
            // Logic quan trọng: Tính điểm rơi dự kiến (Projection)
            let currentY = topConstraint.constant
            let projectedY = currentY + project(initialVelocity: velocity.y)
            
            // Tìm trạng thái gần điểm rơi nhất
            let targetState = nearestState(to: projectedY)
            
            animateToState(targetState)
            
        default:
            break
        }
    }
    
    // Công thức vật lý để tính quãng đường trôi theo quán tính
    // Tham khảo từ FloatingPanel/Sources/Core.swift
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
    
    // MARK: - Gesture Delegate (Scroll Conflict)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = trackedScrollView else { return false }
        
        // Cho phép kéo Panel khi ScrollView đang ở đỉnh
        if otherGestureRecognizer.view == scrollView {
            if scrollView.contentOffset.y <= 0 {
                return true
            }
        }
        return false
    }
}
