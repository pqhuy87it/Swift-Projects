//
//  ListUserViewModel.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

class ListUserViewModel {
    weak var delegate: ListUserViewDelegate?
    
    private var users: [User] = []
    private var getUserRepository: UserRepository
    
    init(delegate: ListUserViewDelegate? = nil, getUserRepository: UserRepository) {
        self.delegate = delegate
        self.getUserRepository = getUserRepository
    }
    
    func getUserCount() -> Int {
        return users.count
    }
    
    // MARK: - API
    
    func loadData() {
        self.delegate?.prepareForGetData()
        
        self.getUserRepository.fetchUsers {[weak self] result in
            switch result{
            case .failure(let error):
                self?.handleFailureWith(error)
            case .success(let response):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let users = try decoder.decode([User].self, from: data)
                        self?.handleSuccessWith(users)
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    private func handleFailureWith(_ error: NetworkError) {
        
    }
    
    private func handleSuccessWith(_ users: [User]) {
        self.users = users
    }
}
