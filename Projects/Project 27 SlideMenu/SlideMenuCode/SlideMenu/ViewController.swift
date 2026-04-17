//
//  ViewController.swift
//  SlideMenu
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	public let button: UIButton = {
		let v = UIButton()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.setTitle("Open Menu", for: .normal)
		v.setTitleColor(.blue, for: .normal)
		v.setTitleColor(UIColor.blue.withAlphaComponent(0.5), for: .highlighted)
		return v
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(button)
		let constrains = [
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		]

		NSLayoutConstraint.activate(constrains)
		button.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
	}

	@objc func didSelect(_ sender: UIButton){
		SidebarLauncher.init(delegate: self).show()
	}

}

extension ViewController: SidebarDelegate{
	func sidbarDidOpen() {

	}

	func sidebarDidClose(with item: NavigationModel?) {
		guard let item = item else {return}
		switch item.type {
		case .home:
			print("called home")
		case .star:
			print("called star")
		case .about:
			print("called about")
		case .facebook:
			print("called facebook")
		case .instagram:
			print("instagram")
		}
	}
}

