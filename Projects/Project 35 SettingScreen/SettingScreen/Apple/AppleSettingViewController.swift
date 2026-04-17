//
//  AppleSettingViewController.swift
//  SettingScreen
//
//  Created by Pham Quang Huy on 2020/12/20.
//

import UIKit

class AppleSettingViewController: UIViewController {
    
    // MARK: - IBOutlet properties

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var sections: [SettingSectionType] = [.phone, .privacy, .general, .apple]
    var items: [[SettingItemType]] = [[.airplaneMode, .wifi, .bluetooth, .celluar, .hotspot],
                                      [.notifications, .sound, .disturb, .screentime],
                                      [.control, .display, .homescreen, .accessibility],
                                      [.appStore, .walletAndPay]
                                     ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    func setupUI() {
//        self.tableView.backgroundColor = .clear
//        self.tableView.backgroundView?.backgroundColor = .clear
    }

}

//MARK: - UITableViewDataSource

extension AppleSettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.textLabel?.text = nil
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let item = self.items[indexPath.section][indexPath.row - 1]
            
            if indexPath.row == self.items[indexPath.section].count {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            cell.textLabel?.text = item.description
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
