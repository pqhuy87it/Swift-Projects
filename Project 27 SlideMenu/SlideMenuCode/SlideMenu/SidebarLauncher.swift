//
//  SidebarLauncher.swift
//  SlideMenu
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import Foundation
import UIKit

protocol SidebarDelegate {
	func sidbarDidOpen()
	func sidebarDidClose(with item: NavigationModel?)
}

class SidebarLauncher: NSObject{

	var view: UIView?
	var delegate: SidebarDelegate?
	var vc: NavigationViewController?
	
	init(delegate: SidebarDelegate) {
		super.init()
		self.delegate = delegate
	}

	public let closeButton: UIButton = {
		let v = UIButton()
		v.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()

	func show(){
		let bounds = UIScreen.main.bounds
		let v = UIView(frame: CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height))
		v.backgroundColor = .clear
		let vc = NavigationViewController()
		vc.delegate = self
		v.addSubview(vc.view)
		v.addSubview(closeButton)
		vc.view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([

			closeButton.topAnchor.constraint(equalTo: v.topAnchor),
			closeButton.leadingAnchor.constraint(equalTo: v.leadingAnchor),
			closeButton.bottomAnchor.constraint(equalTo: v.bottomAnchor),
			closeButton.widthAnchor.constraint(equalToConstant: 60),

			vc.view.topAnchor.constraint(equalTo: v.topAnchor),
			vc.view.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor),
			vc.view.bottomAnchor.constraint(equalTo: v.bottomAnchor),
			vc.view.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0)
		])

		closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
		self.view = v
		self.vc = vc
		UIApplication.shared.keyWindow?.addSubview(v)

		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
			self.view?.frame = CGRect(x: 0, y: 0, width: self.view!.frame.width, height: self.view!.frame.height)
			self.view?.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
		}, completion: {completed in
			self.delegate?.sidbarDidOpen()
		})

	}

	@objc func close(_ sender: UIButton){
		closeSidebar(option: nil)
	}
	func closeSidebar(option: NavigationModel?){
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
			if let view = self.view{
				view.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
				self.view?.backgroundColor = .clear

			}
		}, completion: {completed in
			self.view?.removeFromSuperview()
			self.view = nil
			self.vc = nil
			self.delegate?.sidebarDidClose(with: option)
		})
	}

}
extension SidebarLauncher: NavigationDelegate{
	func navigation(didSelect: NavigationModel?) {
		closeSidebar(option: didSelect)
	}
}
