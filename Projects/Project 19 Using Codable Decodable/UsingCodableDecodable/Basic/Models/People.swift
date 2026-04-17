//
//  People.swift
//  UsingCoable
//
//  Created by mybkhn on 2020/05/22.
//  Copyright © 2020 exlinct. All rights reserved.
//

import Foundation
import UIKit

struct People: Decodable {
	var firstName: String?
	var lastName: String?

	private enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
	}
}
