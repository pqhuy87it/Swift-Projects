//
//  ViewController.swift
//  SettingScreen
//
//  Created by Pham Quang Huy on 2020/12/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [DemoCellType] = [.custom, .apple, .gmail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = self.items[indexPath.row]
        
        cell.textLabel?.text = item.description
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: "customIdentifier", sender: self)
            case 1:
                self.performSegue(withIdentifier: "appleIdentifier", sender: self)
            case 2:
                self.performSegue(withIdentifier: "gmailIdentifier", sender: self)
            default:
                break
        }
    }
}
