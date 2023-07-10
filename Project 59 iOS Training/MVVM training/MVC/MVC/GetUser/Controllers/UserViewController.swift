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
    
    private var users: [User] = []
    private var userRepository = UserRepository()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loadData()
    }

    // MARK: - API
    
    func loadData() {
        self.willLoadData()
        
        self.userRepository.fetchUsers(completion: {[weak self] result in
            switch result {
            case .failure(let error):
                self?.didLoadDataFailedWith(error)
            case .success(let users):
                self?.users = users
                self?.didLoadData()
            }
        })
    }
    
    func willLoadData() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.startAnimating()
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
    
    func didLoadData() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        })
    }
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
}

// MARK: - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].name
        cell.detailTextLabel?.text = self.users[indexPath.row].email
        return cell
    }
}
