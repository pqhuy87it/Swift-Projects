//
//  NSDictionary+Extension.swift
//  N3Vocabulary
//
//  Created by Huy Pham Quang on 3/14/20.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation

extension NSDictionary{
    func JsonString() -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)

            guard let convertedString = String.init(data: jsonData, encoding: .utf8) else {
                return ""
            }

            return convertedString
        } catch {
            return "error converting"
        }
    }
}

public extension Dictionary {
    /// SwifterSwift: Check if key exists in dictionary.
    ///
    ///        let dict: [String: Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///        dict.has(key: "testKey") -> true
    ///        dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for.
    /// - Returns: true if key exists in dictionary.
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// SwifterSwift: Remove all keys contained in the keys parameter from the dictionary.
    ///
    ///        var dict : [String: String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict.removeAll(keys: ["key1", "key2"])
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed.
    mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }
    
    /// SwifterSwift: JSON Data from dictionary.
    ///
    /// - Parameter prettify: set true to prettify data (default is false).
    /// - Returns: optional JSON Data (if applicable).
    func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization
            .WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    /// SwifterSwift: JSON String from dictionary.
    ///
    ///        dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
    ///
    ///        dict.jsonString(prettify: true)
    ///        /*
    ///        returns the following string:
    ///
    ///        "{
    ///        "testKey" : "testValue",
    ///        "testArrayKey" : [
    ///            1,
    ///            2,
    ///            3,
    ///            4,
    ///            5
    ///        ]
    ///        }"
    ///
    ///        */
    ///
    /// - Parameter prettify: set true to prettify string (default is false).
    /// - Returns: optional JSON String (if applicable).
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization
            .WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// SwifterSwift: Creates a new dictionary using specified keys.
    ///
    ///        var dict =  ["key1": 1, "key2": 2, "key3": 3, "key4": 4]
    ///        dict.pick(keys: ["key1", "key3", "key4"]) -> ["key1": 1, "key3": 3, "key4": 4]
    ///        dict.pick(keys: ["key2"]) -> ["key2": 2]
    ///
    /// - Complexity: O(K), where _K_ is the length of the keys array.
    ///
    /// - Parameter keys: An array of keys that will be the entries in the resulting dictionary.
    ///
    /// - Returns: A new dictionary that contains the specified keys only. If none of the keys exist, an empty dictionary will be returned.
    func pick(keys: [Key]) -> [Key: Value] {
        keys.reduce(into: [Key: Value]()) { result, item in
            result[item] = self[item]
        }
    }
}

// MARK: - Methods (Value: Equatable)

public extension Dictionary where Value: Equatable {
    /// SwifterSwift: Returns an array of all keys that have the given value in dictionary.
    ///
    ///        let dict = ["key1": "value1", "key2": "value1", "key3": "value2"]
    ///        dict.keys(forValue: "value1") -> ["key1", "key2"]
    ///        dict.keys(forValue: "value2") -> ["key3"]
    ///        dict.keys(forValue: "value3") -> []
    ///
    /// - Parameter value: Value for which keys are to be fetched.
    /// - Returns: An array containing keys that have the given value.
    func keys(forValue value: Value) -> [Key] {
        return keys.filter { self[$0] == value }
    }
}

// MARK: - Methods (ExpressibleByStringLiteral)

public extension Dictionary where Key: StringProtocol {
    /// SwifterSwift: Lowercase all keys in dictionary.
    ///
    ///        var dict = ["tEstKeY": "value"]
    ///        dict.lowercaseAllKeys()
    ///        print(dict) // prints "["testkey": "value"]"
    ///
    mutating func lowercaseAllKeys() {
        // http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
        for key in keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = removeValue(forKey: key)
            }
        }
    }
}

// MARK: - Subscripts

public extension Dictionary {
    /// SwifterSwift: Deep fetch or set a value from nested dictionaries.
    ///
    ///        var dict =  ["key": ["key1": ["key2": "value"]]]
    ///        dict[path: ["key", "key1", "key2"]] = "newValue"
    ///        dict[path: ["key", "key1", "key2"]] -> "newValue"
    ///
    /// - Note: Value fetching is iterative, while setting is recursive.
    ///
    /// - Complexity: O(N), _N_ being the length of the path passed in.
    ///
    /// - Parameter path: An array of keys to the desired value.
    ///
    /// - Returns: The value for the key-path passed in. `nil` if no value is found.
    subscript(path path: [Key]) -> Any? {
        get {
            guard !path.isEmpty else { return nil }
            var result: Any? = self
            for key in path {
                if let element = (result as? [Key: Any])?[key] {
                    result = element
                } else {
                    return nil
                }
            }
            return result
        }
        set {
            if let first = path.first {
                if path.count == 1, let new = newValue as? Value {
                    return self[first] = new
                }
                if var nested = self[first] as? [Key: Any] {
                    nested[path: Array(path.dropFirst())] = newValue
                    return self[first] = nested as? Value
                }
            }
        }
    }
}

// MARK: - Operators

public extension Dictionary {
    /// SwifterSwift: Merge the keys/values of two dictionaries.
    ///
    ///        let dict: [String: String] = ["key1": "value1"]
    ///        let dict2: [String: String] = ["key2": "value2"]
    ///        let result = dict + dict2
    ///        result["key1"] -> "value1"
    ///        result["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary.
    ///   - rhs: dictionary.
    /// - Returns: An dictionary with keys and values from both.
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
    
    /// SwifterSwift: Append the keys and values from the second dictionary into the first one.
    ///
    ///        var dict: [String: String] = ["key1": "value1"]
    ///        let dict2: [String: String] = ["key2": "value2"]
    ///        dict += dict2
    ///        dict["key1"] -> "value1"
    ///        dict["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary.
    ///   - rhs: dictionary.
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1 }
    }
    
    /// SwifterSwift: Remove keys contained in the sequence from the dictionary.
    ///
    ///        let dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
    ///        let result = dict-["key1", "key2"]
    ///        result.keys.contains("key3") -> true
    ///        result.keys.contains("key1") -> false
    ///        result.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary.
    ///   - keys: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    static func - <S: Sequence>(lhs: [Key: Value], keys: S) -> [Key: Value] where S.Element == Key {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }

    /// SwifterSwift: Remove keys contained in the sequence from the dictionary.
    ///
    ///        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
    ///        dict-=["key1", "key2"]
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary.
    ///   - keys: array with the keys to be removed.
    static func -= <S: Sequence>(lhs: inout [Key: Value], keys: S) where S.Element == Key {
        lhs.removeAll(keys: keys)
    }
}
