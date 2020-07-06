
import Foundation
import UIKit

class UserRepository {
    
    let dao = UserDAO()
    
    // MARK: - READ
    
    func queryFirst() -> UserModel? {
        return dao.queryAll()?.first
    }
    
    func queryBy(_ intKey: Int?) -> UserModel? {
        if let intKey = intKey {
            return dao.queryBy(intKey)
        }
        
        return nil
    }
    
    
    // MARK: - CREATE
    
    func create(_ user: UserModel) {
        dao.create(user)
    }
    
    // MARK: - UPDATE
    
    func updateUser(_ user: UserModel) {
        dao.update(user)
    }
    
    // MARK: - DELETE
    
    func deleteAll() {
        dao.deleteAll()
    }
    
    func delete(_ user: UserModel) {
        dao.delete(user)
    }
    
    func deleteBy(_ intKey: Int) {
        dao.deleteBy(intKey)
    }
    
    // MARK: - GET INCREMENT ID
    
    func getIncrementId() -> Int {
        if let id = dao.getIncrementId() {
            return (id + 1)
        } else {
            return 0
        }
    }
    
    // MARK: - OTHERS
    
}
