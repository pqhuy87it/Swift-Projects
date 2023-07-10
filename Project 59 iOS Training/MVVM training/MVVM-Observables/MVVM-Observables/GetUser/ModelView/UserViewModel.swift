//
//  UserViewModel.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import Foundation

class UserViewModel {
    
    var users: Observable<[User]> = Observable([])
    var error: Observable<Error?> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    var cardNumber: Observable<Int> = Observable(0)
    private var userRepository = UserRepository()
    
    // MARK: - Model property
    
    func getUserNumber() -> Int {
        return self.users.value.count
    }
    
    func getUserNameAt(_ indexPath: IndexPath) -> String {
        return self.users.value[indexPath.row].name
    }
    
    func getUserEmailAt(_ indexPath: IndexPath) -> String {
        return self.users.value[indexPath.row].email
    }
    
    // MARK: - API
    
    func loadData() {
        self.isLoading.value = true
        
        self.userRepository.fetchUsers(completion: {[weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .failure(let error):
                self?.error.value = error
            case .success(let users):
                self?.users.value = users
            }
        })
    }
}
