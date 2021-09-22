//
//  MainViewController.swift
//  UsingCodableDecodable
//
//  Created by HuyPQ22 on 2021/09/22.
//  Copyright © 2021 exlinct. All rights reserved.
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
            Subject(title: "Basic", description: ""),
            Subject(title: "Dictionary", description: "")
            
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }
    
    func handleDidTapTableViewAt(indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            baseTest()
            break
        default:
            break
        }
    }
    
    func baseTest() {
        if let basicVC = ViewController.fromStoryboard(Storyboards.Main.name) as? ViewController {
            self.navigationController?.pushViewController(basicVC, animated: true)
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
        self.handleDidTapTableViewAt(indexpath: indexPath)
    }
}
