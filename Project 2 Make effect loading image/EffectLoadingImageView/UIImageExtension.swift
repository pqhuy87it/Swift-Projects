//
//  UIImageExtension.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation

public enum MessageImageTailDirection {
    case Left
    case Right
}

extension UIImage {
    public struct BubbleMaskImage {
        public static let leftTail: UIImage = {
            let scale = UIScreen.mainScreen().scale
            let orientation: UIImageOrientation = .Up
            var maskImage = UIImage(CGImage: UIImage(named: "left_tail_image_bubble")!.CGImage!, scale: scale, orientation: orientation)
            maskImage = maskImage.resizableImageWithCapInsets(UIEdgeInsets(top: 25, left: 27, bottom: 20, right: 20), resizingMode: UIImageResizingMode.Stretch)
            return maskImage
        }()
        
        public static let rightTail: UIImage = {
            let scale = UIScreen.mainScreen().scale
            let orientation: UIImageOrientation = .Up
            var maskImage = UIImage(CGImage: UIImage(named: "right_tail_image_bubble")!.CGImage!, scale: scale, orientation: orientation)
            maskImage = maskImage.resizableImageWithCapInsets(UIEdgeInsets(top: 24, left: 20, bottom: 20, right: 27), resizingMode: UIImageResizingMode.Stretch)
            return maskImage
        }()
    }
    
    func renderAtSize(size: CGSize) -> UIImage {
        
        // 确保 size 为整数，防止 mask 里出现白线
        let size = CGSize(width: ceil(size.width), height: ceil(size.height))
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0) // key
        
        let context = UIGraphicsGetCurrentContext()
        
        drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let cgImage = CGBitmapContextCreateImage(context)!
        
        let image = UIImage(CGImage: cgImage)
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func bubbleImageWithTailDirection(tailDirection: MessageImageTailDirection, size: CGSize, forMap: Bool = false) -> UIImage {
        
        //let orientation: UIImageOrientation = tailDirection == .Left ? .Up : .UpMirrored
        
        let maskImage: UIImage
        
        if tailDirection == .Left {
            maskImage = BubbleMaskImage.leftTail.renderAtSize(size)
        } else {
            maskImage = BubbleMaskImage.rightTail.renderAtSize(size)
        }
        
        if forMap {
            let image = cropToAspectRatio(size.width / size.height).resizeToTargetSize(size)
            
            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
            
            image.drawAtPoint(CGPointZero)
            
            let bottomShadowImage = UIImage(named: "location_bottom_shadow")!
            let bottomShadowHeightRatio: CGFloat = 0.185 // 20 / 108
            bottomShadowImage.drawInRect(CGRect(x: 0, y: floor(image.size.height * (1 - bottomShadowHeightRatio)), width: image.size.width, height: ceil(image.size.height * bottomShadowHeightRatio)))
            
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            let bubbleImage = finalImage.maskWithImage(maskImage)
            
            return bubbleImage
        }
        
        // fixRotation 会消耗大量内存，改在发送前做
        let bubbleImage = /*self.fixRotation().*/cropToAspectRatio(size.width / size.height).resizeToTargetSize(size).maskWithImage(maskImage)
        
        return bubbleImage
    }
    
    func cropToAspectRatio(aspectRatio: CGFloat) -> UIImage {
        let size = self.size
        
        let originalAspectRatio = size.width / size.height
        
        var rect = CGRectZero
        
        if originalAspectRatio > aspectRatio {
            let width = size.height * aspectRatio
            rect = CGRect(x: (size.width - width) * 0.5, y: 0, width: width, height: size.height)
            
        } else if originalAspectRatio < aspectRatio {
            let height = size.width / aspectRatio
            rect = CGRect(x: 0, y: (size.height - height) * 0.5, width: size.width, height: height)
            
        } else {
            return self
        }
        
        let cgImage = CGImageCreateWithImageInRect(self.CGImage, rect)!
        return UIImage(CGImage: cgImage)
    }
    
    func maskWithImage(maskImage: UIImage) -> UIImage {
        
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()
        
        var transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0, -1.0))
        transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(0.0, self.size.height))
        CGContextConcatCTM(context, transform)
        
        let drawRect = CGRect(origin: CGPointZero, size: self.size)
        
        CGContextClipToMask(context, drawRect, maskImage.CGImage)
        
        CGContextDrawImage(context, drawRect, self.CGImage)
        
        let roundImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return roundImage
    }
    
    func resizeToTargetSize(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        let scale = UIScreen.mainScreen().scale
        let newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(scale * floor(size.width * heightRatio), scale * floor(size.height * heightRatio))
        } else {
            newSize = CGSizeMake(scale * floor(size.width * widthRatio), scale * floor(size.height * widthRatio))
        }
        
        let rect = CGRectMake(0, 0, floor(newSize.width), floor(newSize.height))
        
        //println("size: \(size), newSize: \(newSize), rect: \(rect)")
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func decodedImage() -> UIImage {
        return decodedImage(scale: scale)
    }
    
    public func decodedImage(scale scale: CGFloat) -> UIImage {
        let imageRef = CGImage
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(nil, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        if let context = context {
            let rect = CGRectMake(0, 0, CGFloat(CGImageGetWidth(imageRef)), CGFloat(CGImageGetHeight(imageRef)))
            CGContextDrawImage(context, rect, imageRef)
            let decompressedImageRef = CGBitmapContextCreateImage(context)!
            
            return UIImage(CGImage: decompressedImageRef, scale: scale, orientation: imageOrientation) ?? self
        }
        
        return self
    }
}