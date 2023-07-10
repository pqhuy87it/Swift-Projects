//
//  ViewController.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LoginUserViewmodel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = LoginUserViewmodel(delegate: self)
    }

    @IBAction func loginBtnDidTap(_ sender: Any) {
        
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func prepareForLogin() {
        
    }
    
    func loginSuccessWith(_ user: LoginUser) {
        
    }
    
    func loginFailWith(_ error: Error) {
        
    }
    
    
}

