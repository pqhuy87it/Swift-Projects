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
            Subject(title: "Icon on label", description: "Insert icon in content label."),
            Subject(title: "Highlighted Text Color", description: "")
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }

    func handleDidTapTableViewAt(indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            self.iconOnLabel()
            break
        case 1:
            showHighlightedText()
        default:
            break
        }
    }
    
    func iconOnLabel() {
        if let iconOnLabelVC = IconOnLabelController.fromStoryboard(Storyboards.IconOnLabel.name) as? IconOnLabelController {
            self.navigationController?.pushViewController(iconOnLabelVC, animated: true)
        }
    }
    
    func showHighlightedText() {
        if let vc = HighlightedTextColorController.fromStoryboard(Storyboards.HighlightedTextColor.name) as? HighlightedTextColorController {
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


