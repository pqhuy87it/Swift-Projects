
import Foundation
import RealmSwift

class UserDAO: DAO {
    typealias T = RUserModel
    
    // MARK: - READ
    
    func queryAll() -> [UserModel]? {
        if let rModels = self.readDB() {
            return rModels.compactMap{ UserModel($0) }
        }
        
        return nil
    }
    
    func queryBy(_ stringKey: String) -> UserModel? {
        if let rUser = self.readDBBy(stringKey) {
            return UserModel(rUser)
        }
        
        return nil
    }
    
    func queryBy(_ intKey: Int) -> UserModel? {
        if let rUser = self.readDBBy(intKey) {
            return UserModel(rUser)
        }
        
        return nil
    }
    
    // MARK: - CREATE
    
    func create(_ model: UserModel) {
        if let rModel = RUserModel.factoryMethod(model) {
            self.createDB(rModel)
        }
    }
    
    // MARK: - UPDATE
    
    func update(_ model: UserModel) {
        if let rModel = RUserModel.factoryMethod(model) {
            self.updateDB(rModel)
        }
    }
    
    // MARK: - DELETE
    
    func delete(_ user: UserModel) {
        if let rAccount = RUserModel.factoryMethod(user) {
            self.deleteDB(rAccount)
        }
    }
    
    func deleteBy(_ intKey: Int) {
        self.deleteDBBy(intKey)
    }
    
    func deleteAll() {
        self.deleteAllObjects()
    }
    
    // MARK: - GET INCREMENT ID
    
    func getIncrementId() -> Int? {
        if let object = self.getLastObjectBy("id") {
            return object.id
        }
        
        return nil
    }
}
