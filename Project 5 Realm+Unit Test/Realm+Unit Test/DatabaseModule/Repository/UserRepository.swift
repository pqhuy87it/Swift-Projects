
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
    
    func create(_ model: UserModel) {
        dao.create(model)
    }
    
    // MARK: - UPDATE
    
    func updateUser(_ model: UserModel) {
        dao.update(model)
    }
    
    // MARK: - DELETE
    
    func deleteAll() {
        dao.deleteAll()
    }
    
    func delete(_ model: UserModel) {
        dao.delete(model)
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
