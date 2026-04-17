//
//  ProtocolEncodableViewController.swift
//  UsingCodableDecodable
//
//  Created by HuyPQ22 on 2021/09/03.
//  Copyright © 2021 exlinct. All rights reserved.
//
// https://stackoverflow.com/questions/62252547/value-of-protocol-type-encodable-cannot-conform-to-encodable-only-struct-en

import UIKit

protocol JsonEncoding where Self: Encodable { }

extension JsonEncoding {
    func encode(using encoder: JSONEncoder) throws -> Data {
        try encoder.encode(self)
    }
}

extension Dictionary where Value == JsonEncoding {
    func encode(using encoder: JSONEncoder) throws -> [Key: String] {
        try compactMapValues {
            try String(data: $0.encode(using: encoder), encoding: .utf8)
        }
    }
}

extension String: JsonEncoding { }
extension Int: JsonEncoding { }

class ProtocolEncodableViewController: UIViewController {
    
    var things: [String: JsonEncoding] = [
        "Hello": "World!",
        "answer": 42
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        doStuff(payload: things)
    }
    
    func doStuff(payload: [String: JsonEncoding]) {
        let encoder = JSONEncoder()
        do {
            let encodedValues = try payload.encode(using: encoder)
            let jsonData = try encoder.encode(encodedValues)
            
            // Write to file
        } catch {
            print(error)
        }
    }

}
