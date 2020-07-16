//
//  LeftMenuViewController.swift
//  SlideMenuStoryboard
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

	@IBOutlet weak var bgView: UIView!
	@IBOutlet weak var tableView: UITableView!
	
	var items: [NavigationModel] = []
	var delegate: SidebarDelegate?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

		self.setupUI()
		self.setupData()
    }
    
	func setupUI() {
		tableView.register(UINib(nibName: "LeftMenuCell", bundle: nil), forCellReuseIdentifier: "LeftMenuCell")

		// gesture
		setupTapGesture()
	}

	func setupData() {
		items.append(NavigationModel(name: "Home", type: .home))
		items.append(NavigationModel(name: "Star", type: .star))
		items.append(NavigationModel(name: "About", type: .about))
		items.append(NavigationModel(name: "Facebook", type: .facebook))
		items.append(NavigationModel(name: "Instagram", type: .instagram))
	}

	func setupTapGesture() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
		tapGestureRecognizer.numberOfTouchesRequired = 1
		self.bgView.addGestureRecognizer(tapGestureRecognizer)
	}

	@objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
		// do something
		self.delegate?.sidebarDidClose()
	}
}

//MARK: - UITableViewDataSource

extension LeftMenuViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for: indexPath) as? LeftMenuCell else {
			return UITableViewCell()
		}

		let model = self.items[indexPath.row]
		cell.configWith(model)

		return cell
	}
}

//MARK: - UITableViewDelegate

extension LeftMenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = self.items[indexPath.row]
		self.delegate?.sidebarDidClose(with: model)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60.0
	}
}
