//
//  ViewController.swift
//  TemplateProject
//
//  Created by HuyPQ22 on 2021/08/22.
//

import UIKit

typealias Subject = (title: String, description: String?)

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Subject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items = [
            Subject(title: "Activity View", description: "Activity view example")
            
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }

    func handleDidTapTableViewAt(_ indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            showActivityView()
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        case 9:
            break
        case 10:
            break
        default:
            break
        }
    }
    
    func showActivityView() {
        if let activityVC = ActivityViewController.fromStoryboard(Storyboards.ActivityView.name) as? ActivityViewController {
            self.navigationController?.pushViewController(activityVC, animated: true)
        }
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handleDidTapTableViewAt(indexPath)
    }
}


