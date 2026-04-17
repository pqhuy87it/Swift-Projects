//
//  ViewController.swift
//  SlideMenuStoryboard
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var slideMenuView: UIView?
	var backgroundView: UIView?
	var leftMenuVC: LeftMenuViewController?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func settingBtnDidTap(_ sender: Any) {
		self.showLeftMenu()
	}

	func showLeftMenu(){
		let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
		guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else {
			return
		}

		let bounds = UIScreen.main.bounds
		let v = UIView(frame: CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height))
		let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
		backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
		self.view.addSubview(backgroundView)
		v.backgroundColor = .clear

		vc.delegate = self
		v.addSubview(vc.view)

		self.slideMenuView = v
		self.leftMenuVC = vc
		self.backgroundView = backgroundView

		UIApplication.shared.keyWindow?.addSubview(v)

		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
			v.frame = CGRect(x: 0, y: 0, width: self.view!.frame.width, height: self.view!.frame.height)
		}, completion: {completed in

		})
	}

	func hideLeftMenu(){
		if let backgroundView = self.backgroundView {
			backgroundView.isHidden = true
			backgroundView.removeFromSuperview()
		}

		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
			if let view = self.slideMenuView {
				view.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
			}
		}, completion: {completed in
		})
	}
}

extension ViewController: SidebarDelegate{
	func sidebarDidClose() {
		self.hideLeftMenu()
	}

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

		self.hideLeftMenu()
	}
}
