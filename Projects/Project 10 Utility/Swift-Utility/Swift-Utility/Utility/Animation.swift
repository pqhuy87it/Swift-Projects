//
//  Animation.swift
//  Swift-Utility
//
//  Created by Pham Quang Huy on 2020/12/06.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

enum AnimationKeys: String {
    case opacity = "opacity"
    case positionX = "position.x"
    case positionY = "position.y"
    case strokeEnd = "strokeEnd"
    case path = "path"
}

class Animation {
    public class func duration(_ duration: TimeInterval,
                               animations: @escaping () -> Void) {
        UIView.animate(withDuration: duration,
                       animations: animations)
    }
    
    public class func withDelay(duration: TimeInterval,
                                delay: TimeInterval,
                                animations: (() -> Void)!) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.7,
            options: [],
            animations: {
                animations()
            }, completion: nil
        )
    }
    
    public class func easeIn(duration: TimeInterval,
                             delay: TimeInterval = 0,
                             animations: (() -> Void)!) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseIn,
            animations: {
                animations()
            },
            completion: nil
        )
    }
    
    public class func easeOut(duration: TimeInterval,
                              delay: TimeInterval = 0,
                              animations: (() -> Void)!) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseOut,
            animations: {
                animations()
            }, completion: nil
        )
    }
    
    public class func easeInOut(duration: TimeInterval,
                                delay: TimeInterval = 0,
                                animations: (() -> Void)!) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseInOut,
            animations: {
                animations()
            }, completion: nil
        )
    }
    
    public class func linear(duration: TimeInterval,
                             delay: TimeInterval = 0,
                             animations: (() -> Void)!) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveLinear,
            animations: {
                animations()
            }, completion: nil
        )
    }
    
    public class func withCompletion(duration: TimeInterval,
                                     animations: (() -> Void)!,
                                     completion: ((Bool) -> Void)!) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.7,
            options: [],
            animations: {
                animations()
            }, completion: { finished in
                completion(finished)
            }
        )
    }
    
    public class func opacity(fromValue: CGFloat = 0.0,
                              toValue: CGFloat = 1.0,
                              delay: TimeInterval = 0,
                              duration: TimeInterval,
                              timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .easeIn)) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationKeys.opacity.rawValue)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        // Set animation properties.
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.backwards
        animation.timingFunction = timingFunction
        
        return animation
    }
    
    public class func positionY(fromValue: CGFloat = 0.0,
                                toValue: CGFloat = 1.0,
                                delay: TimeInterval = 0,
                                duration: TimeInterval,
                                timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .easeIn)) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationKeys.positionY.rawValue)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        // Set animation properties.
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.backwards
        animation.timingFunction = timingFunction
        
        return animation
    }
    
    public class func positionX(fromValue: CGFloat = 0.0,
                                toValue: CGFloat = 1.0,
                                delay: TimeInterval = 0,
                                duration: TimeInterval,
                                timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .easeIn)) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationKeys.positionX.rawValue)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        // Set animation properties.
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = timingFunction
        
        return animation
    }
    
    public class func strokeEnd(fromValue: CGFloat = 0.0,
                                toValue: CGFloat = 1.0,
                                delay: TimeInterval = 0,
                                duration: TimeInterval,
                                timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .easeIn)) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationKeys.strokeEnd.rawValue)
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        // Set animation properties.
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = timingFunction
        
        return animation
    }
    
    public class func fromPath(_ fromPath: UIBezierPath,
                               toPath: UIBezierPath,
                               delay: TimeInterval = 0,
                               duration: TimeInterval,
                               timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .easeIn)) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: AnimationKeys.path.rawValue)
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        
        // Set animation properties.
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = timingFunction
        
        return animation
    }
}
