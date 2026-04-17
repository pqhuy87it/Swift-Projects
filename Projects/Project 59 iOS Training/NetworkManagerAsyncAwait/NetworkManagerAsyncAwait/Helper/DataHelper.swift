//
//  JsonHelper.swift
//  NetworkManagerTest
//
//  Created by Huy Pham on 2024/10/31.
//

import Foundation

class DataHelper {
    class func load(_ filename: String) -> Data {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        return data
    }
}
