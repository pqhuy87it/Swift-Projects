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
            Subject(title: "StackView by code example 1", description: ""),
            Subject(title: "StackView by code example 2", description: ""),
            Subject(title: "StackView by code example 3", description: "")
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }

    func handleDidTapTableViewAt(_ indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            self.showStackViewByCodeExample1()
            break
        case 1:
            self.showStackViewByCodeExample2()
            break
        case 2:
            self.showStackViewByCodeExample3()
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
    
    func showStackViewByCodeExample1() {
        if let vc = StackViewByCodeExample1Controller.fromStoryboard(Storyboards.StackViewByCodeExample1.name) as? StackViewByCodeExample1Controller {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showStackViewByCodeExample2() {
        if let vc = StackViewByCodeExample2Controller.fromStoryboard(Storyboards.StackViewByCodeExample2.name) as? StackViewByCodeExample2Controller {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showStackViewByCodeExample3() {
        if let vc = StackViewByCodeExample3Controller.fromStoryboard(Storyboards.StackViewByCodeExample3.name) as? StackViewByCodeExample3Controller {
            self.navigationController?.pushViewController(vc, animated: true)
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


