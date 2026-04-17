
import RealmSwift
import Foundation
import UIKit

class RealmService {
    
    static let shared: RealmService = RealmService()
    
    private init() {
        logD("RealmService initialized", logLevel: .info)
    }
    
    func post(_ error:Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func obseerveRealmError(in vc:UIViewController,completion: @escaping (Error?)->Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            
            completion(notification.object as? Error)
        }
    }
    
    func stopObseerveRealmError(in vc:UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
    
    static func getRealm() throws -> Realm? {
        if let _ = NSClassFromString("XCTest") { // for unit test
            return try! Realm(configuration: Realm.Configuration(fileURL: nil,
                                                                 inMemoryIdentifier: "Test",
                                                                 encryptionKey: nil,
                                                                 readOnly: false,
                                                                 schemaVersion: 0,
                                                                 migrationBlock: nil,
                                                                 deleteRealmIfMigrationNeeded: false,
                                                                 shouldCompactOnLaunch: nil,
                                                                 objectTypes: nil))
        } else {
            // get realm key
            var keyEncrypted = KeyChainUtils.getData(key: Constants.realmConfigKey) ?? ""
            
            // create aes
            let aes = try AES(keyString: Constants.keyForRealm)
            
            if keyEncrypted.isEmpty {
                // generate random data
                var newKey = Data(count: 64)
                
                try newKey.withUnsafeMutableBytes { dataBytes in
                    guard let dataBytesBaseAddress = dataBytes.baseAddress else {
                        throw AESError.generateRandomIVFailed
                    }
                    
                    let status: Int32 = SecRandomCopyBytes(
                        kSecRandomDefault,
                        64,
                        dataBytesBaseAddress
                    )
                    
                    guard status == 0 else {
                        throw AESError.generateRandomIVFailed
                    }
                }
                
                let key = newKey.base64EncodedString()
                let keyDataEncrypted = try aes.encrypt(key)
                
                keyEncrypted = keyDataEncrypted.base64EncodedString()
                
                if keyEncrypted.isEmpty {
                    logD("key encrypted is nil!", logLevel: .error)
                    return nil
                }
                
                //insert key to keychain
                if KeyChainUtils.insert(key: Constants.realmConfigKey, value: keyEncrypted) == false {
                    logD("can't save key encrypted!",logLevel: .error)
                    return nil
                }
            }
            
            guard let dataEncrypted = Data(base64Encoded: keyEncrypted) else {
                logD("Data encrypted is nil!", logLevel: .error)
                return nil
            }
            
            let keyDecrypted = try aes.decrypt(dataEncrypted)
            
            if keyDecrypted.isEmpty {
                logD("key decrypted is nil!", logLevel: .error)
                return nil
            }
            
            let encryptionConfig = Realm.Configuration(encryptionKey: Data(base64Encoded: keyDecrypted))
            
            return try Realm(configuration: encryptionConfig)
        }
    }
    
    static func deleteAllDatabase() {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Extension Realm

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
