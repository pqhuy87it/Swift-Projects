
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items = [
            Subject(title: "Json Data", description: "Test with json data"),
            Subject(title: "Pattern 1", description: "Test with pattern 1"),
            Subject(title: "Pattern 2", description: "Test with pattern 2"),
            Subject(title: "Pattern 3", description: "Test with pattern 3"),
            Subject(title: "Dictionary", description: "Test with dictionary type")
            
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(BasicCell.self)
        
        // hidden last cell separator
        self.tableView.tableFooterView = UIView()
    }
    
    func handleDidTapTableViewAt(indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            setupJsonData()
        case 1:
            testPattern1()
        case 2:
            testPattern2()
        case 3:
            testPattern3()
        case 4:
            testDecodePropertyWithTypeOfJsonDictionary()
        default:
            break
        }
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
        
        do {
            let hoge = try JSONDecoder().decode(CodableTest.self, from: json)
            print(hoge)
        } catch {
            print(error)
        }
    }
    
    func testPattern2() {
        let json = """
        {
           "items":[
              {
                 "id":1,
                 "title":"タイトル1",
                 "message":"メッセージ1"
              },
              {
                 "id":2,
                 "title":"タイトル2",
                 "message":"メッセージ2"
              }
           ],
           "total_count":2
        }
        """.data(using: .utf8)!
        
        do {
            let hoge = try JSONDecoder().decode(CodableTest2.self, from: json)
            print(hoge)
        } catch {
            print(error)
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
        
        do {
            let hoge = try JSONDecoder().decode(CodableTest3.self, from: json)
            print(hoge)
        } catch {
            print(error)
        }
    }
    
    func testDecodePropertyWithTypeOfJsonDictionary() {
        let jsonData = """
        {
           "id":12345,
           "name":"Giuseppe",
           "last_name":"Lanza",
           "age":31,
           "happy":true,
           "rate":1.5,
           "classes":[
              "maths",
              "phisics"
           ],
           "dogs":[
              {
                 "name":"Gala",
                 "age":1
              },
              {
                 "name":"Aria",
                 "age":3
              }
           ]
        }
        """.data(using: .utf8)!
        
        let stud = try! JSONDecoder().decode(AnyDecodable.self, from: jsonData).value as! [String: Any]
        print(stud)
        
        let decoder = JSONDecoder()
        
        let userDataJson = """
        {
           "id":"4yq6txdpfadhbaqnwp3",
           "email":"john.doe@example.com",
           "name":"John Doe",
           "metadata":{
              "link_id":"linked-id",
              "buy_count":4
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

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(BasicCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let subject = items[indexPath.row]
        
        cell.configWith(indexPath, subject: subject)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handleDidTapTableViewAt(indexpath: indexPath)
    }
}

