
import Foundation

class UserModel: NSObject,Decodable {
    var id: Int = 0
    var firstName: String?
    var lastName: String?
    var birthday: String?
    
    internal static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    convenience init?(_ model: RUserModel?) {
        self.init()
        self.parseFromRealm(model)
    }
    
    private func parseFromRealm(_ model: RUserModel?) {
        guard  let model = model else {
            return
        }
        
        self.id = model.id
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.birthday = model.birthday
    }
}
