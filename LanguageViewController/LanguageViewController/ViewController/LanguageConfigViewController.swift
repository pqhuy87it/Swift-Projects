//
//  LanguageConfigViewController.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class LanguageConfigViewController: ConfigContentBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let kCellHeight: CGFloat = 56
    let kLanguageCellIdentifier: String = "LanguageCell"
    
    fileprivate let languageList: [Language] = [.english,
                                                .japanese,
                                                .thai,
                                                .vietnamese]
    
    fileprivate var language: Language = appConfig.language
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = languageList.firstIndex(of: language) {
            let indexPath = IndexPath(row: index, section:0)
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition:.top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initTableView()
    }

    fileprivate func initTableView() {
        let cellNib = UINib(nibName: kLanguageCellIdentifier, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: kLanguageCellIdentifier)
    }

    @IBAction func btnClosePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LanguageConfigViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kLanguageCellIdentifier,
                                                       for: indexPath)
            as? LanguageCell else {
                fatalError()
        }
        if language == languageList[indexPath.row] {
            cell.setSelected(true, animated: false)
        }
        cell.selectionStyle = .none
        cell.titleLabel.text = languageList[indexPath.row].toString().localize()
        return cell
    }
}

extension LanguageConfigViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        language = languageList[indexPath.row]
        appConfig.language = language
        languageChangeReceiverManager.publish(language)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
}
