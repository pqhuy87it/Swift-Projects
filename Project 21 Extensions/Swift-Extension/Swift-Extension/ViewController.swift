//
//  ViewController.swift
//  Swift-Extension
//
//  Created by Huy Pham Quang on 5/3/20.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//		createUrlUsage()
//
//		subStringFromEndUsage()
//
//		uppercaseStringUsage()
//
//		arrayUnifyUsage()
//
//        statusBarBackgroundColorTest()
        
//        testSubString()
        
//        testPath()
        
        testSliceStringFromString()
    }
    
    func testPath() {
        let urlString = "/Users/vladgohn/Desktop/e405d.jpg"
        print(urlString.pathExtension)
        print(urlString.fileName)
        print(urlString.lastPathComponent)
        print(urlString.pathDirectory)
    }
    
    func testSubString() {
        let length = "2021/08/20 16:11:35.473 JvmaSDK Version:0.2.30".count
        print(self.subStringFromIndex(0, toIndex: 23))
        print(self.subStringFromIndex(24, toIndex: length))
    }
    
    func subStringFromIndex(_ fromIndex: Int, toIndex: Int) -> String {
         return "2021/08/20 16:11:35.473 JvmaSDK Version:0.2.30".subString(fromIndex: fromIndex, toIndex: toIndex)
    }
    
    func testSliceStringFromString() {
        let result = "/private/var/mobile/Containers/Data/Application/36F5F8F1-4A37-4028-BA68-4FAB4ED0D9F7/Documents/JvmaSDKLog/SDK.log".sliceFromString("Documents", to: .end)
        print(result)
        
        let result1 = "/private/var/mobile/Containers/Data/Application/36F5F8F1-4A37-4028-BA68-4FAB4ED0D9F7/Documents/JvmaSDKLog/SDK.log".sliceFromString("Documents", to: .bein)
        print(result1)
    }

	func createUrlUsage() {
		if let url = "https://www.google.com/".url {
			print(url.absoluteString)
		}
	}

	func subStringFromEndUsage() {
		let str = "abcdefghijklmn".removeCharsFromEnd(count: 3)
		print(str)
	}

	func uppercaseStringUsage() {
		let str = "hello world."
		print(str.firstUppercased)
		print(str.capitalizingFirstLetter())
	}

	func arrayUnifyUsage() {
		let array = [1, 2, 3, 3, 2, 1, 4]
		let result = array.unified()
		print(result)
		// [1, 2, 3, 4]
	}
    
    func statusBarBackgroundColorTest() {
//        UIApplication.shared.statusBarView?.backgroundColor = .red
        self.navigationController?.setStatusBar(backgroundColor: .red)
    }
}

