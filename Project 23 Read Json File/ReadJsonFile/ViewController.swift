//
//  ViewController.swift
//  ReadJsonFile
//
//  Created by mybkhn on 2020/05/27.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		if let persons = self.loadJson(filename: "Person") {
			for person in persons {
				print("name: \(person.name) age: \(person.age) employed: \(person.employed)")
			}
		}
	}

	func loadJson(filename fileName: String) -> [Person]? {
		if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				let jsonData = try decoder.decode(ResponseData.self, from: data)
				return jsonData.person
			} catch {
				print("error:\(error)")
			}
		}

		return nil
	}
}

