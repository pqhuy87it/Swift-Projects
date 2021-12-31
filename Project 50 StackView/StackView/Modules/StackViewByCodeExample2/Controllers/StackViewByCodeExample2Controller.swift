
import UIKit

final class StackViewByCodeExample2Controller: UIViewController {
    private enum ViewMetrics {
        static let fontSize: CGFloat = 24.0
        static let spacing: CGFloat = 8.0
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Sun"))
        imageView.backgroundColor = .orange
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Share", comment: "Share"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: ViewMetrics.fontSize)
        button.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, button])
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
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    @objc private func shareAction(_ sender: UIButton) {
        print("share")
    }
}
