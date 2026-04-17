//
//  EncoderViewController.swift
//  UsingCodableDecodable
//
//  Created by mybkhn on 2020/06/21.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class Person: Codable {
	var name: String?
	var age: String?
	var dog: Dog?
}

class Dog: Codable {
	var name: String?
}

class Bird: Codable {
	var name: String?
	var isFly: Bool?
}

class SouthPolarSkua: Bird {
	var breedingType: String?
}

class Penguin: Bird {
	var isSwimming: Bool?
	var enemy: SouthPolarSkua?
}

class EncoderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

		testEncode2()
    }

	func testEncode1() {
		let dog = Dog()
		dog.name = "Hachiko"

		let person = Person()
		person.name = "David"
		person.age = "30"
		person.dog = dog

		do {
			let data = try JSONEncoder().encode(person)
			let json = String(data: data, encoding: String.Encoding.utf8)!
			print(json)
		} catch {
			print(error)
		}
	}

	func testEncode2() {
		// sử dụng kế thừa không thể encode đc SouthPolarSkua

		let penguin = Penguin()
		penguin.name = "South"
		penguin.isFly = false
		penguin.isSwimming = true

		let southPolarSkua = SouthPolarSkua()
		southPolarSkua.name = "SouthPolarSkua"
		southPolarSkua.isFly = true
		southPolarSkua.breedingType = "egg"

		penguin.enemy = southPolarSkua

		do {
			let data = try JSONEncoder().encode(penguin)
			let json = String(data: data, encoding: String.Encoding.utf8)!
			print(json)
		} catch {
			print(error)
		}
	}

}
