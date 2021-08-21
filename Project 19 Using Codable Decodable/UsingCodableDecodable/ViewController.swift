
import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

//		setupJsonData()
        
        testDecodePropertyWithTypeOfJsonDictionary()
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
                print(hoge)
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
                print(hoge)
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
                print(hoge)
			} catch {
				print(error)
			}
		}
	}
    
    func testDecodePropertyWithTypeOfJsonDictionary() {
        let jsonData = """
        {
          "id": 12345,
          "name": "Giuseppe",
          "last_name": "Lanza",
          "age": 31,
          "happy": true,
          "rate": 1.5,
          "classes": ["maths", "phisics"],
          "dogs": [
            {
              "name": "Gala",
              "age": 1
            }, {
              "name": "Aria",
              "age": 3
            }
          ]
        }
        """.data(using: .utf8)!
        
        let stud = try! JSONDecoder().decode(AnyDecodable.self, from: jsonData).value as! [String: Any]
        print(stud)
        
        let decoder = JSONDecoder()

        let userDataJson = """
            {
            "id": "4yq6txdpfadhbaqnwp3",
            "email": "john.doe@example.com",
            "name":"John Doe",
            "metadata": {
              "link_id": "linked-id",
              "buy_count": 4
            }
          }
        """.data(using: .utf8)!

        let user = try! decoder.decode(User.self, from: userDataJson)
        print(user)

        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let plist = try! encoder.encode(user)
        
        print(String(data: plist, encoding: .utf8)!)
        
        let metadata = try! decoder.decode([String: AnyJSONType].self, from: userDataJson)
        
        print(metadata)
    }
}

