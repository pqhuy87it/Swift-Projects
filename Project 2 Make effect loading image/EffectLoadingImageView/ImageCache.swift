//
//  ImageCache.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ImageCache {
    static let sharedInstance = ImageCache()
    
    let cache = NSCache()
    let cacheQueue = dispatch_queue_create("ImageCacheQueue", DISPATCH_QUEUE_SERIAL)
    let cacheAttachmentQueue = dispatch_queue_create("ImageCacheAttachmentQueue", DISPATCH_QUEUE_SERIAL)
    
    class func attachmentOriginKeyWithURLString(URLString: String) -> String {
        return "attachment-0.0-\(URLString)"
    }
    
    class func attachmentSideLengthKeyWithURLString(URLString: String, sideLength: CGFloat) -> String {
        return "attachment-\(sideLength)-\(URLString)"
    }
    
    func setImageItem(item: Item, completion: (loadingProgress: Double, image: UIImage?) -> Void) {
        dispatch_async(self.cacheQueue) {
            Downloader.downloadAttachment(item, reportProgress: { (progress, image) in
                SafeDispatch.async {
                    completion(loadingProgress: progress, image: image)
                }
                }, imageTransform: { image in
                    print("image transform")
                    return image.decodedImage()
            }) { image in
                print("completion")
                let imageFile = image.decodedImage()
                
                SafeDispatch.async {
                    completion(loadingProgress: 1.0, image: imageFile)
                }
            }
        }
    }
}