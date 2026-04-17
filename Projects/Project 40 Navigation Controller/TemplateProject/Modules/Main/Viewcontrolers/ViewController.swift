
import UIKit

typealias Subject = (title: String, description: String?)

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Subject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items = [
            Subject(title: "NavigationBar Gradient Color",
                    description: "Set navigationBar background gradient color")
            
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }

    func handleDidTapTableViewAt(indexpath: IndexPath) {
        if let navigationbarGradientColorVC = NavigationBarGradientColorController.fromStoryboard(Storyboards.NavigationBarGradientColor.name) as? NavigationBarGradientColorController {
            let naviVC = UINavigationController(rootViewController: navigationbarGradientColorVC)
            naviVC.modalPresentationStyle = .overFullScreen
            
            self.present(naviVC, animated: true, completion: nil)
        }
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
        guard let cell = tableView.dequeueCell(MainViewCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let subject = items[indexPath.row]
        
        cell.configWith(title: subject.title, description: subject.description)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handleDidTapTableViewAt(indexpath: indexPath)
    }
}


