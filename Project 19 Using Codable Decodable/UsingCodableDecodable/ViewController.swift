
import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		setupJsonData()
	}

	func setupJsonData() {
		let jsonData = """
{
    "first_name": "John",
    "last_name": "Wick"
}
""".data(using: .utf8)!
		JSONParser<People>.parse(data: jsonData, onSuccess: { people in
			print("first name: \(people.firstName!) last name: \(people.lastName!)")
		}, onError: { error in

		})
	}

	func testPattern1() {
		let json = """
    {
        "id": 1,
        "title": "タイトル",
        "message": "メッセージ"
    }
    """.data(using: .utf8)!

		func decode() {
			do {
				let hoge = try JSONDecoder().decode(CodableTest.self, from: json)
			} catch {
				print(error)
			}
		}
	}

	func testPattern2() {
		let json = """
    {
    "items": [
    {
      "id": 1,
      "title": "タイトル1",
      "message": "メッセージ1"
    },
    {
      "id": 2,
      "title": "タイトル2",
      "message": "メッセージ2"
    }
    ],
    "total_count": 2
    }
    """.data(using: .utf8)!

		func decode() {
			do {
				let hoge = try JSONDecoder().decode(CodableTest2.self, from: json)
			} catch {
				print(error)
			}
		}
	}

	func testPattern3() {
		let json = """
    {
        "items": [
            {
                "id": 1,
                "title": "タイトル1",
                "message": "メッセージ1"
            },
            {
                "id": 2,
                "title": null
            },
            {
                "id": 3,
                "title": "タイトル3",
                "message": "メッセージ3"
            }
        ],
        "total_count": 2
    }
    """.data(using: .utf8)!

		func decode() {
			do {
				let hoge = try JSONDecoder().decode(CodableTest3.self, from: json)
			} catch {
				print(error)
			}
		}
	}
}

