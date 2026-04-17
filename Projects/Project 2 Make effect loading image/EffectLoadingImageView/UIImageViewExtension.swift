//
//  UIImageViewExtension.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation

extension UIImageView {
    func setImageItem(item: Item, completion: (loadingProgress: Double, image: UIImage?) -> Void) {
        ImageCache.sharedInstance.setImageItem(item, completion: {progress, image in
            completion(loadingProgress: progress, image: image)
        })
    }
}