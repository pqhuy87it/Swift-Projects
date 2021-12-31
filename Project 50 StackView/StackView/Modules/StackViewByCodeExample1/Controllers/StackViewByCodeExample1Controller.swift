import UIKit

class StackViewByCodeExample1Controller: UIViewController {
    private enum ViewMetrics {
        static let labelFontSize: CGFloat = 24.0
        static let buttonFontSize: CGFloat = 18.0
        static let spacing: CGFloat = 8.0
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Engine Power", comment: "Engine Power")
        label.font = UIFont.systemFont(ofSize: ViewMetrics.labelFontSize)
        label.textAlignment = .center
        return label
    }()

    let lowButton: UIButton = {
        let title = NSLocalizedString("Low", comment: "Low")
        let button = UIButton.makeButton(title: title, color: .red, fontSize: ViewMetrics.buttonFontSize)
        return button
    }()

    let mediumButton: UIButton = {
        let title = NSLocalizedString("Medium", comment: "Medium")
        let button = UIButton.makeButton(title: title, color: .yellow, fontSize: ViewMetrics.buttonFontSize)
        return button
    }()

    let highButton: UIButton = {
        let title = NSLocalizedString("High", comment: "High")
        let button = UIButton.makeButton(title: title, color: .green, fontSize: ViewMetrics.buttonFontSize)
        return button
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, lowButton, mediumButton, highButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = ViewMetrics.spacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
