
import Foundation
import RealmSwift

class RUserModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    @objc dynamic var birthday: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init?(_ user: UserModel?) {
        self.init()
        parse(user)
    }
    
    static func factoryMethod(_ model: UserModel?) -> RUserModel? {
        let this = RUserModel(model)
        return this
    }
    
    fileprivate func parse(_ user: UserModel?) {
        guard let user = user else { return }
        
        self.id = user.id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthday = user.birthday
    }
}
