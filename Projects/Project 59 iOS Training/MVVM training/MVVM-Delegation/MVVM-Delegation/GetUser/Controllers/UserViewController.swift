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
    
    var viewModel: UserViewModel?

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = UserViewModel(self, userRepository: UserRepository())
        self.viewModel?.loadData()
        
    }

    
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getUserNumber() ?? 0
    }
}

// MARK: - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.viewModel?.getUserNameAt(indexPath)
        cell.detailTextLabel?.text = self.viewModel?.getUserEmailAt(indexPath)
        return cell
    }
}

// MARK: - ViewModelDelegate
extension UserViewController: ViewModelDelegate {
    func willLoadData() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.startAnimating()
        })
    }
    
    func didLoadData() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        })
    }
    
    func didLoadDataFailedWith(_ error: Error?) {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                self.errorLb.isHidden = false
                self.errorLb.text = error.localizedDescription
            } else {
                self.errorLb.isHidden = false
                self.errorLb.text = "can't get user data!"
            }
        })
    }
}

