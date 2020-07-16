//
//  ViewController.swift
//  RecordingButton
//
//  Created by mybkhn on 2020/07/10.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var recordButton: RecordButton!

	var progressTimer : Timer!
	var progress : CGFloat! = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func recordButtonTapped(_ button: RecordButton) {
		print("Recording: ", button.buttonState == .recording)
		switch button.buttonState {
		case .recording:
			record()
		case .idle:
			stop()
		case .hidden:
			stop()
		}
	}

	func record() {
		self.progressTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
	}

	@objc func updateProgress() {

		let maxDuration = CGFloat(5) // Max duration of the recordButton

		progress = progress + (CGFloat(0.05) / maxDuration)
		recordButton.setProgress(progress)
		if progress >= 1 {
			progressTimer.invalidate()
			stop()
		}

	}

	func stop() {
		self.progressTimer.invalidate()
	}
}

