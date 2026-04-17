//
//  ViewController.swift
//  TemplateProject
//
//  Created by HuyPQ22 on 2021/08/22.
//

import UIKit

typealias Subject = (title: String, description: String?)

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Subject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items = [
            Subject(title: "Custom Search Bar",
                    description: "Custom background color, text color"),
            Subject(title: "Display Search Controller",
                    description: "Display search view controller"),
            Subject(title: "Scope Bar",
                    description: "")
            
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }
    
    func customSearchBar() {
        if let customSearchBarVC = CustomSearchBarViewController.fromStoryboard(Storyboards.CustomSearchBar.name) as? CustomSearchBarViewController {
            self.navigationController?.pushViewController(customSearchBarVC, animated: true)
        }
    }
    
    func displaySearchViewController() {
        if let displaySearchVC = DisplaySearchViewController.fromStoryboard(Storyboards.DisplaySearchController.name) as? DisplaySearchViewController {
            self.navigationController?.pushViewController(displaySearchVC, animated: true)
        }
    }

    func handleDidTapTableViewAt(indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            self.customSearchBar()
        case 1:
            self.displaySearchViewController()
        case 2:
            self.showScopeBar()
            break
        default:
            break
        }
    }
    
    func showScopeBar() {
        if let vc = ScopeBarController.fromStoryboard(Storyboards.ScopeBar.name) as? ScopeBarController {
            self.navigationController?.pushViewController(vc, animated: true)
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


