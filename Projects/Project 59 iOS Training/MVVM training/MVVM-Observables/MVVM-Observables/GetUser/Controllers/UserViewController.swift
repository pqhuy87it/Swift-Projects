//
//  ViewController.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLb: UILabel!
    
    lazy var viewModel: UserViewModel = {
        return UserViewModel()
    }()

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel.isLoading.bind { isLoading in
            DispatchQueue.main.async(execute: { () -> Void in
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            })
        }
        
        self.viewModel.users.bind { _ in
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        }
        
        self.viewModel.error.bind { error in
            DispatchQueue.main.async(execute: { () -> Void in
                if let error = error {
                    self.errorLb.isHidden = false
                    self.errorLb.text = error.localizedDescription
                }
            })
        }
        
        self.viewModel.loadData()
    }

    
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getUserNumber()
    }
}

// MARK: - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.viewModel.getUserNameAt(indexPath)
        cell.detailTextLabel?.text = self.viewModel.getUserEmailAt(indexPath)
        return cell
    }
}

