
import Foundation

private let kSecClassKey = NSString(format: kSecClass)
private let kSecAttrAccountKey = NSString(format: kSecAttrAccount)
private let kSecValueDataKey = NSString(format: kSecValueData)
private let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
private let kSecAttrServiceKey = NSString(format: kSecAttrService)
private let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
private let kSecReturnDataKey = NSString(format: kSecReturnData)
private let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
private let kSecAttrAccessibleKey = NSString(format:kSecAttrAccessible)
private let kSecAttrAccessibleValue = NSString(format: kSecAttrAccessibleWhenUnlockedThisDeviceOnly)

public class KeyChainUtils {
    
    private static let service = "App-Services"
    
    // update value to keychain
    @discardableResult
    class func update(key: String, data: String) -> Bool {
        if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key], forKeys: [kSecClassKey, kSecAttrServiceKey, kSecAttrAccountKey])
            
            let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataKey:dataFromString] as CFDictionary)
            
            if (status == errSecSuccess) {
                return true
            }
        }
        
        return false
    }
    
    // delete value from keychain
    @discardableResult
    class func removeValue(key: String) -> Bool {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, kCFBooleanTrue ?? false], forKeys: [kSecClassKey, kSecAttrServiceKey, kSecAttrAccountKey, kSecReturnDataKey])
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        if (status == errSecSuccess) {
            return true
        }
        
        return false
    }
    
    
    // insert value to keychain
    @discardableResult
    class func insert(key: String, value: String) -> Bool {
        if let dataFromString = value.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, dataFromString, kSecAttrAccessibleValue], forKeys: [kSecClassKey, kSecAttrServiceKey, kSecAttrAccountKey, kSecValueDataKey, kSecAttrAccessibleKey])
            
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if status == errSecSuccess {
                return true
            }
        }
        
        return false
    }
    
    // get value from keychain
    class func getData(key: String) -> String? {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, kCFBooleanTrue ?? false, kSecMatchLimitOneValue], forKeys: [kSecClassKey, kSecAttrServiceKey, kSecAttrAccountKey, kSecReturnDataKey, kSecMatchLimitValue])
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        }
        
        return contentsOfKeychain
    }
}
