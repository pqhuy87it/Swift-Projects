//
//  UserViewModel.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import Foundation

class UserViewModel {
    weak var delegate: ViewModelDelegate?
    
    private var users: [User] = []
    private var userRepository: UserRepository
    
    // MARK: - Init
    
    init(_ delegate: ViewModelDelegate? = nil, userRepository: UserRepository) {
        self.delegate = delegate
        self.userRepository = userRepository
    }
    
    // MARK: - Model property
    
    func getUserNumber() -> Int {
        return self.users.count
    }
    
    func getUserNameAt(_ indexPath: IndexPath) -> String {
        return self.users[indexPath.row].name
    }
    
    func getUserEmailAt(_ indexPath: IndexPath) -> String {
        return self.users[indexPath.row].email
    }
    
    // MARK: - API
    
    func loadData() {
        self.delegate?.willLoadData()
        
        self.userRepository.fetchUsers(completion: { result in
            switch result {
            case .failure(let error):
                self.delegate?.didLoadDataFailedWith(error)
            case .success(let users):
                self.users = users
                
                self.delegate?.didLoadData()
            }
        })
    }
}
