//
//  SaveObjectToUserDefaultViewController.swift
//  UsingCodableDecodable
//
//  Created by HuyPQ22 on 2021/09/03.
//  Copyright © 2021 exlinct. All rights reserved.
//
// https://stackoverflow.com/questions/45058048/how-to-save-an-array-with-objects-to-userdefaults/45059394

import UIKit

class SaveObjectToUserDefaultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    static var getAllObjects: [MyObject] {
        let defaultObject = MyObject(name: "My Object Name", something: ["1", "2", "3"])
          if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [MyObject] {
                return objectsDecoded
             } else {
                return [defaultObject]
             }
          } else {
             return [defaultObject]
          }
       }

     static func saveAllObjects(allObjects: [MyObject]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allObjects){
             UserDefaults.standard.set(encoded, forKey: "user_objects")
          }
     }
}

struct MyObject: Codable {
    var name: String
    var something: [String]
}
