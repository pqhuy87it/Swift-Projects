//
//  Delay.swift
//  Swift-Utility
//
//  Created by Pham Quang Huy on 2020/06/08.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import Foundation

// A delay function
public func delay(_ seconds: Double, completion: @escaping ( )-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
