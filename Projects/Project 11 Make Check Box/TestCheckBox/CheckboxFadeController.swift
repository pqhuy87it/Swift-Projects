//
//  CheckboxFadeController.swift
//  TestCheckBox
//
//  Created by HuyPQ on 2019/06/26.
//  Copyright © 2019 fujitsu. All rights reserved.
//

import UIKit

class CheckboxFadeController: CheckboxController {
    //----------------------------
    // MARK: - Properties
    //----------------------------
    
    override var tintColor: UIColor {
        didSet {
            selectedBoxLayer.strokeColor = tintColor.cgColor
            if style == .stroke {
                markLayer.strokeColor = tintColor.cgColor
            } else {
                selectedBoxLayer.fillColor = tintColor.cgColor
            }
        }
    }
    
    override var secondaryTintColor: UIColor? {
        didSet {
            unselectedBoxLayer.strokeColor = secondaryTintColor?.cgColor
        }
    }
    
    override var secondaryCheckmarkTintColor: UIColor? {
        didSet {
            if style == .fill {
                markLayer.strokeColor = secondaryCheckmarkTintColor?.cgColor
            }
        }
    }
    
    override var hideBox: Bool {
        didSet {
            selectedBoxLayer.isHidden = hideBox
            unselectedBoxLayer.isHidden = hideBox
        }
    }
    
    fileprivate var style: AnimationStyle = .stroke
    
    init(style: AnimationStyle) {
        self.style = style
        super.init()
        sharedSetup()
    }
    
    override init() {
        super.init()
        sharedSetup()
    }
    
    fileprivate func sharedSetup() {
        // Disable som implicit animations.
        let newActions = [
            "opacity": NSNull(),
            "strokeEnd": NSNull(),
            "transform": NSNull(),
            "fillColor": NSNull(),
            "path": NSNull(),
            "lineWidth": NSNull()
        ]
        
        // Setup the unselected box layer
        unselectedBoxLayer.lineCap = .round
        unselectedBoxLayer.rasterizationScale = UIScreen.main.scale
        unselectedBoxLayer.shouldRasterize = true
        unselectedBoxLayer.actions = newActions
        
        unselectedBoxLayer.opacity = 1.0
        unselectedBoxLayer.strokeEnd = 1.0
        unselectedBoxLayer.transform = CATransform3DIdentity
        unselectedBoxLayer.fillColor = nil
        
        // Setup the selected box layer.
        selectedBoxLayer.lineCap = .round
        selectedBoxLayer.rasterizationScale = UIScreen.main.scale
        selectedBoxLayer.shouldRasterize = true
        selectedBoxLayer.actions = newActions
        
        selectedBoxLayer.fillColor = nil
        selectedBoxLayer.transform = CATransform3DIdentity
        
        // Setup the checkmark layer.
        markLayer.lineCap = .round
        markLayer.lineJoin = .round
        markLayer.rasterizationScale = UIScreen.main.scale
        markLayer.shouldRasterize = true
        markLayer.actions = newActions
        
        markLayer.transform = CATransform3DIdentity
        markLayer.fillColor = nil
    }
    
    //----------------------------
    // MARK: - Layers
    //----------------------------
    
    let markLayer = CAShapeLayer()
    let selectedBoxLayer = CAShapeLayer()
    let unselectedBoxLayer = CAShapeLayer()
    
    override var layersToDisplay: [CALayer] {
        return [unselectedBoxLayer, selectedBoxLayer, markLayer]
    }
    
    //----------------------------
    // MARK: - Animations
    //----------------------------
    
    override func animate(_ fromState: CheckState?, toState: CheckState?, completion: (() -> Void)?) {
        super.animate(fromState, toState: toState)
        
        if pathGenerator.pathForMark(toState) == nil && pathGenerator.pathForMark(fromState) != nil {
            let opacityAnimation = animationGenerator.opacityAnimation(true)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ () -> Void in
                self.resetLayersForState(self.state)
                completion?()
            })
            
            selectedBoxLayer.add(opacityAnimation, forKey: "opacity")
            markLayer.add(opacityAnimation, forKey: "opacity")
            
            CATransaction.commit()
        } else if pathGenerator.pathForMark(toState) != nil && pathGenerator.pathForMark(fromState) == nil {
            markLayer.path = pathGenerator.pathForMark(toState)?.cgPath
            
            let opacityAnimation = animationGenerator.opacityAnimation(false)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ () -> Void in
                self.resetLayersForState(self.state)
                completion?()
            })
            
            selectedBoxLayer.add(opacityAnimation, forKey: "opacity")
            markLayer.add(opacityAnimation, forKey: "opacity")
            
            CATransaction.commit()
        } else {
            let fromPath = pathGenerator.pathForMark(fromState)
            let toPath = pathGenerator.pathForMark(toState)
            
            let morphAnimation = animationGenerator.morphAnimation(fromPath, toPath: toPath)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({ [unowned self] () -> Void in
                self.resetLayersForState(self.state)
                completion?()
            })
            
            markLayer.add(morphAnimation, forKey: "path")
            
            CATransaction.commit()
        }
        
    }
    
    //----------------------------
    // MARK: - Layout
    //----------------------------
    
    override func layoutLayers() {
        // Frames
        unselectedBoxLayer.frame = CGRect(x: 0.0, y: 0.0, width: pathGenerator.size, height: pathGenerator.size)
        selectedBoxLayer.frame = CGRect(x: 0.0, y: 0.0, width: pathGenerator.size, height: pathGenerator.size)
        markLayer.frame = CGRect(x: 0.0, y: 0.0, width: pathGenerator.size, height: pathGenerator.size)
        // Paths
        unselectedBoxLayer.path = pathGenerator.pathForBox()?.cgPath
        selectedBoxLayer.path = pathGenerator.pathForBox()?.cgPath
        markLayer.path = pathGenerator.pathForMark(state)?.cgPath
    }
    
    //----------------------------
    // MARK: - Display
    //----------------------------
    
    override func resetLayersForState(_ state: CheckState?) {
        super.resetLayersForState(state)
        // Remove all remnant animations. They will interfere with each other if they are not removed before a new round of animations start.
        unselectedBoxLayer.removeAllAnimations()
        selectedBoxLayer.removeAllAnimations()
        markLayer.removeAllAnimations()
        
        // Set the properties for the final states of each necessary property of each layer.
        unselectedBoxLayer.strokeColor = secondaryTintColor?.cgColor
        unselectedBoxLayer.lineWidth = pathGenerator.boxLineWidth
        
        selectedBoxLayer.strokeColor = tintColor.cgColor
        selectedBoxLayer.lineWidth = pathGenerator.boxLineWidth
        
        if style == .stroke {
            selectedBoxLayer.fillColor = nil
            markLayer.strokeColor = tintColor.cgColor
            markLayer.fillColor = tintColor.cgColor
        } else {
            selectedBoxLayer.fillColor = tintColor.cgColor
            markLayer.strokeColor = secondaryCheckmarkTintColor?.cgColor
        }
        
        markLayer.lineWidth = pathGenerator.checkmarkLineWidth
        
        if pathGenerator.pathForMark(state) != nil {
            markLayer.opacity = 1.0
            selectedBoxLayer.opacity = 1.0
        } else {
            selectedBoxLayer.opacity = 0.0
            markLayer.opacity = 0.0
        }
        
        // Paths
        unselectedBoxLayer.path = pathGenerator.pathForBox()?.cgPath
        selectedBoxLayer.path = pathGenerator.pathForBox()?.cgPath
        markLayer.path = pathGenerator.pathForMark(state)?.cgPath
    }
}
