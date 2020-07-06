//
//  NSFileManagerExtension.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation

public enum FileExtension: String {
    case JPEG = "jpg"
    case MP4 = "mp4"
    case M4A = "m4a"
    
    public var mimeType: String {
        switch self {
        case .JPEG:
            return "image/jpeg"
        case .MP4:
            return "video/mp4"
        case .M4A:
            return "audio/m4a"
        }
    }
}

public extension NSFileManager {
    public class func CachesURL() -> NSURL {
        return try! NSFileManager.defaultManager().URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
    }
    
    public class func ImageCachesURL() -> NSURL? {
        
        let fileManager = NSFileManager.defaultManager()
        
        let messageCachesURL = CachesURL().URLByAppendingPathComponent("message_caches", isDirectory: true)
        
        do {
            try fileManager.createDirectoryAtURL(messageCachesURL, withIntermediateDirectories: true, attributes: nil)
            return messageCachesURL
        } catch let error {
            print("Directory create: \(error)")
        }
        
        return nil
    }
    
    public class func ImageURLWithName(name: String) -> NSURL? {
        
        if let messageCachesURL = ImageCachesURL() {
            return messageCachesURL.URLByAppendingPathComponent("\(name).\(FileExtension.JPEG.rawValue)")
        }
        
        return nil
    }
    
    public class func saveImageData(messageImageData: NSData, withName name: String) -> NSURL? {
        
        if let messageImageURL = ImageURLWithName(name) {
            return messageImageURL
//            print(messageImageURL.path)
            /* bo save anh, nang qua
            if NSFileManager.defaultManager().createFileAtPath(messageImageURL.path!, contents: messageImageData, attributes: nil) {
                return messageImageURL
            }
            */
        }
        
        return nil
    }
}