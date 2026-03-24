// MARK: - 6️⃣ Entry Point - Push & Pop để trigger leak
// File: ViewControllers/HomeViewController.swift

import Foundation
import UIKit

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
