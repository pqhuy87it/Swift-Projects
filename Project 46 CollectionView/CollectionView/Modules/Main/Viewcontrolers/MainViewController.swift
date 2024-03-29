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
            Subject(title: "Tag", description: "https://github.com/rubygarage/collection-view-layouts"),
            Subject(title: "Pagination", description: "https://github.com/fahidattique55/FAPaginationLayout"),
            Subject(title: "Dynamic content automatic size", description: "Center align"),
            Subject(title: "Dynamic content flow layout", description: "Using flow layout"),
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }

    func handleDidTapTableViewAt(_ indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            self.displayTag()
            break
        case 1:
            self.displayPagination()
            break
        case 2:
            self.displayDynamicContent()
            break
        case 3:
            self.displayDynamicContentFlowLayout()
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
    
    func displayTag() {
        if let tagVC = TagViewController.fromStoryboard(Storyboards.Tag.name) as? TagViewController {
            self.navigationController?.pushViewController(tagVC, animated: true)
        }
    }
    
    func displayPagination() {
        if let paginationVC = LayoutSelectionVC.fromStoryboard(Storyboards.Pagination.name) as? LayoutSelectionVC {
            self.navigationController?.pushViewController(paginationVC, animated: true)
        }
    }
    
    func displayDynamicContent() {
        if let dynamicContentVC = DynamicContentController.fromStoryboard(Storyboards.DynamicContent.name) as? DynamicContentController {
            self.navigationController?.pushViewController(dynamicContentVC, animated: true)
        }
    }
    
    func displayDynamicContentFlowLayout() {
        if let dynamicContentVC = DynamicContentUsingFlowLayoutController.fromStoryboard(Storyboards.DynamicContentFlowLayout.name) as? DynamicContentUsingFlowLayoutController {
            self.navigationController?.pushViewController(dynamicContentVC, animated: true)
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


