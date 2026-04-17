
import Foundation

public typealias JSONDictionary = [String: Any]

// A delay function
public func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

enum Constants {
    
    // Realm config key
    public static let realmConfigKey = "realmConfigKey"
    
    // AES key config
    public static let aesKey = "AESKey"
    public static let keyForRealm = "KeyForRealm"
    
    public static let downloadInterval = 180
}
