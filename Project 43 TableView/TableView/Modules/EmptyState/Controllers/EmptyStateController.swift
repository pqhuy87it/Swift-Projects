//
//  EmptyStateController.swift
//  TableView
//
//  Created by Pham Quang Huy on 2022/01/15.
//

import UIKit

class EmptyStateController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: - UITableViewDataSource

extension EmptyStateController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.items.count == 0 {
            self.tableView.setEmptyMessage("My Message")
        } else {
            self.tableView.restore()
        }
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
