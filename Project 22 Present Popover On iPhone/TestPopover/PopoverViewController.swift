//
//  PopoverViewController.swift
//  TestPopover
//
//  Created by mybkhn on 2020/01/16.
//  Copyright © 2020 mybkhn. All rights reserved.
//

import UIKit

class PopoverViewController: UITableViewController {

	private var optionSetting = [String]()
	private var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

	func setupContentOption(optionContent: [String], sizeWidthContent: CGFloat, sender: UIButton) {
		optionSetting = optionContent
		modalPresentationStyle = UIModalPresentationStyle.popover
		preferredContentSize = CGSize(width: sizeWidthContent, height: heighContentTableView())
		let popoverPresentationController = self.popoverPresentationController
		popoverPresentationController?.sourceView = sender
		popoverPresentationController?.permittedArrowDirections = .left
		popoverPresentationController?.popoverLayoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		popoverPresentationController?.sourceRect = CGRect(x: sender.frame.width, y: 10, width: 0, height: 0)
		button = sender
		tableView.reloadData()
	}

	private func heighContentTableView() -> CGFloat {
		tableView.layoutIfNeeded()
		return tableView.contentSize.height
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return optionSetting.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = optionSetting[indexPath.row]
		cell.layoutMargins = .zero
		cell.separatorInset = .zero
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		delegate?.itemOptionSelectedWithIndexPath(item: optionSetting[indexPath.row], button: button, indexPath: indexPath)
		tableView.deselectRow(at: indexPath, animated: true)
		dismiss(animated: true, completion: nil)
	}
}
