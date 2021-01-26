//
//  ViewController.swift
//  Devices
//
//  Created by mybkhn on 2021/01/26.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let deviceName = Device.getDeviceName()
		print(deviceName)

		let deviceModel = Device.getModel()
		print(deviceModel.rawValue)
	}


}

