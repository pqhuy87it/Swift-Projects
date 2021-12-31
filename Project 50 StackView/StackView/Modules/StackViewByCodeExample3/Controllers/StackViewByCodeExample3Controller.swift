
import UIKit

final class StackViewByCodeExample3Controller: UIViewController {
    private enum ViewMetrics {
        static let codeFontSize: CGFloat = 40
        static let codeSpacing: CGFloat = 16
        static let codeBackgroundColor: UIColor = .yellow
        static let codeColor: UIColor = .black
        static let verticalSpacing: CGFloat = 16
        static let margin: CGFloat = 16
        static let backgroundColor: UIColor = .purple
        static let coverColor: UIColor = .yellow
        static let animationDuration: TimeInterval = 0.25
    }

    private let code1 = UILabel.makeLabel("1A", fontSize: ViewMetrics.codeFontSize, textColor: ViewMetrics.codeColor, backgroundColor: ViewMetrics.codeBackgroundColor)
    private let code2 = UILabel.makeLabel("2BX", fontSize: ViewMetrics.codeFontSize, textColor: ViewMetrics.codeColor, backgroundColor: ViewMetrics.codeBackgroundColor)
    private let code3 = UILabel.makeLabel("3Z", fontSize: ViewMetrics.codeFontSize, textColor: ViewMetrics.codeColor, backgroundColor: ViewMetrics.codeBackgroundColor)

    private lazy var codeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [code1, code2, code3])
        stackView.distribution = .fillEqually
        stackView.spacing = ViewMetrics.codeSpacing
        return stackView
    }()

    private lazy var codeSwitch: UISwitch = {
        let codeSwitch = UISwitch()
        codeSwitch.addTarget(self, action: #selector(showCode(_:)), for: .valueChanged)
        return codeSwitch
    }()

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [codeSwitch, codeStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = ViewMetrics.verticalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.margin, leading: ViewMetrics.margin, bottom: ViewMetrics.margin, trailing: ViewMetrics.margin)
        return stackView
    }()

    private var coverView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCover()
    }

    private func setupView() {
        view.addSubview(rootStackView)
        title = NSLocalizedString("Show Code", comment: "Show Code")
        rootStackView.addBackground(color: ViewMetrics.backgroundColor)
        coverView = codeStackView.addForeground(color: ViewMetrics.coverColor)
        codeSwitch.isOn = false

        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func showCode(_ sender: UISwitch) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: ViewMetrics.animationDuration, delay: 0, options: [], animations: {
            self.configureCover()
        }, completion: nil)
    }

    private func configureCover() {
        coverView?.alpha = codeSwitch.isOn ? 0 : 1.0
    }
}

