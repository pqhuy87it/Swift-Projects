
import Foundation

struct ResponseData: Decodable {
	var person: [Person]
}

struct Person : Decodable {
	var name: String
	var age: String
	var employed: String
}
