//
//  SettingViewController.swift
//  SettingScreen
//
//  Created by Pham Quang Huy on 2020/12/19.
//

import UIKit

class CustomSettingViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var sections: [SettingSectionType] = [.phone, .privacy, .general]
    var items: [[SettingItemType]] = [[.airplaneMode, .wifi, .bluetooth, .celluar, .hotspot],
                                      [.notifications, .sound, .disturb, .screentime],
                                      [.control, .display, .homescreen, .accessibility]]

    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    // MARK: - IBAction methods
    
    @IBAction func dismissDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - @objc method
    
    // MARK: - Methods
    
    func setupUI() {
//        tableView.backgroundColor = .gray
    }
}

//MARK: - UITableViewDataSource

extension CustomSettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = self.sections[indexPath.section]
        let itemType = self.items[indexPath.section][indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch sectionType {
            case .phone:
                break
            case .privacy:
                break
            case .general:
                break
            case .apple:
                break
        }
        
        cell.textLabel?.text = itemType.description
        cell.imageView?.image = UIImage(systemName: "archivebox.fill")
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CustomSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].description
    }
}
