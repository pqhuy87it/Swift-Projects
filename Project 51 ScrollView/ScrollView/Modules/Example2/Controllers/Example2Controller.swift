
import UIKit

final class Example2Controller: UIViewController {

    private enum ViewMetrics {
        static let labelFontSize: CGFloat = 56.0
        static let buttonFontSize: CGFloat = 32.0
        static let buttonInset: CGFloat = 10.0
        static let contentMargin: CGFloat = 8.0
    }

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: ViewMetrics.labelFontSize)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("Get Ready!", comment: "")
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Skater"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        let title = NSLocalizedString("Start", comment: "")
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: ViewMetrics.buttonFontSize)
        button.contentEdgeInsets = UIEdgeInsets(top: ViewMetrics.buttonInset, left: 0.0, bottom: ViewMetrics.buttonInset, right: 0.0)
        return button
    }()

    private lazy var activityView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, imageView, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.contentMargin, leading: ViewMetrics.contentMargin, bottom: ViewMetrics.contentMargin, trailing: ViewMetrics.contentMargin)
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(activityView)
        return scrollView
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showInfo(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.tintColor = .black
        title = NSLocalizedString("Activity", comment: "")
        setupView()
    }

    private func setupView() {
        view.addSubview(scrollView)

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentGuide.leadingAnchor.constraint(equalTo: activityView.leadingAnchor),
            contentGuide.topAnchor.constraint(equalTo: activityView.topAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: activityView.trailingAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: activityView.bottomAnchor),

            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor)
            ])
        
        // setup info button
        scrollView.addSubview(infoButton)
        let margin = scrollView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            infoButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            infoButton.topAnchor.constraint(equalTo: margin.topAnchor)
        ])
    }
    
    @objc private func showInfo(_ sender: UIButton) {
        print("Show Info")
    }
}
