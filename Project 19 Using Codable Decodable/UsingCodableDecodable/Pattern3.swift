
import Foundation

struct CodableTest3 {

	struct Content {
		var id: Int?
		var title: String?
		var message: String?
	}

	private enum RootKeys: String, CodingKey {
		case items
		case totalCount = "total_count"
	}

	private enum ItemsKeys: String, CodingKey {
		case id
		case title
		case message
	}

	var contents: [Content]?
	var totalCount: Int = 0
}

extension CodableTest3: Decodable {

	init(from decoder: Decoder) throws {
		self.contents = []
		let root = try decoder.container(keyedBy: RootKeys.self)
		var items = try root.nestedUnkeyedContainer(forKey: .items)

		while !items.isAtEnd {
			let container = try items.nestedContainer(keyedBy: ItemsKeys.self)
			var content = Content()

			content.id = try container.decode(Int.self, forKey: .id)

			do {
				content.title = try container.decode(String.self, forKey: .title)
			} catch {
				print(error)
			}
			do {
				content.message = try container.decode(String.self, forKey: .message)
			} catch {
				print(error)
			}

			self.contents?.append(content)
		}

		totalCount = try root.decode(Int.self, forKey: .totalCount)
	}
}
