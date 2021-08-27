
import Foundation
import RealmSwift

protocol DAO {
    associatedtype T: Object
    func readDB() -> [T]?
    func readDBBy(_ condition: NSPredicate) -> [T]?
    func readDBBy(_ key: String) -> T?
    func createDB(_ object: T)
    func updateDB(_ object: T)
    func deleteDB(_ object: T)
    func deleteDB(_ objects: [T])
    func deleteDBBy(_ byKey: Int)
    func deleteAllObjects()
}

extension DAO {
    
    // MARK: - CREATE
    
    func createDB(_ object: T) {
        do {
            guard let realm = try RealmService.getRealm() else {
                logD("can't create instance realm!", logLevel: .emergency)
                return
            }
            
            try realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    func createDB(_ objects: [T]) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            try realm.write {
                realm.add(objects)
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    // MARK: - READ
    
    func readDB() -> [T]? {
        do {
            guard let realm = try RealmService.getRealm() else {
                return nil
            }
            
            // get objects from db
            let results = realm.objects(T.self).toArray(type: T.self)
            
            // return results
            return results
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
            return nil
        }
    }
    
    func readDBBy(_ condition: NSPredicate) -> [T]? {
        do {
            guard let realm = try RealmService.getRealm() else {
                return nil
            }
            
            // get objects from db filter by condition
            let results = realm.objects(T.self).filter(condition).toArray(type: T.self)
            
            // return results
            return results
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
            return nil
        }
    }
    
    func readDBBy(_ stringKey: String) -> T? {
        do {
            guard let realm = try RealmService.getRealm() else {
                return nil
            }
            
            let results = realm.object(ofType: T.self, forPrimaryKey: stringKey)
            return results
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
            return nil
        }
    }
    
    func readDBBy(_ intKey: Int) -> T? {
        do {
            guard let realm = try RealmService.getRealm() else {
                return nil
            }
            
            let results = realm.object(ofType: T.self, forPrimaryKey: intKey)
            return results
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
            return nil
        }
    }
    
    // MARK: - UPDATE
    
    func updateDB(_ object: T) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    func updateDB(_ objects: [T]) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    // MARK: - DELETE
    
    func deleteAllObjects() {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            // get all object from db
            let objects = realm.objects(T.self)
            
            // try to delete
            try realm.write {
                realm.delete(objects)
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    func deleteDB(_ object: T) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            try realm.write {
                realm.delete(object)
                return
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    func deleteDB(_ objects: [T]) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            try realm.write {
                realm.delete(objects)
                return
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    func deleteDBBy(_ stringKey: String) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            if let object = realm.object(ofType: T.self, forPrimaryKey: stringKey) {
                try realm.write {
                    realm.delete(object)
                    return
                }
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    func deleteDBBy(_ intKey: Int) {
        do {
            guard let realm = try RealmService.getRealm() else {
                return
            }
            
            if let object = realm.object(ofType: T.self, forPrimaryKey: intKey) {
                try realm.write {
                    realm.delete(object)
                    return
                }
            }
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
        }
    }
    
    // MARK: - GET INCREMENT ID
    
    func getLastObjectBy(_ byKey: String) -> T? {
        do {
            guard let realm = try RealmService.getRealm() else {
                return nil
            }
            
            let object = realm.objects(T.self).sorted(byKeyPath: byKey).toArray(type: T.self).last
            return object
        } catch let error as NSError {
            // handle error
            logD(error, logLevel: .error)
            return nil
        }
    }
}
