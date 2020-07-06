//
//  ViewController.swift
//  swift-autolayout
//
//  Created by Pham Quang Huy on 2020/05/18.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var customView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(customView)
        customView.backgroundColor = .red
    }
    
    // custom view's center with self.view
    func setupWithHeightWidth() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: customView,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: self.view,
                                                      attribute: .centerX,
                                                      multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: customView,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        let widthConstraint = NSLayoutConstraint(item: customView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 100)
        let heightConstraint = NSLayoutConstraint(item: customView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 100)
        view.addConstraints([horizontalConstraint,
                             verticalConstraint,
                             widthConstraint,
                             heightConstraint])
        /*
         NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
         */
    }
    
    func setupSameWithOtherWay() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: customView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: customView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: customView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 100).isActive = true
        NSLayoutConstraint(item: customView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 100).isActive = true
    }
    
    func setupUsingVisualFormat() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["view": view!,
                     "customView": customView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-(<=0)-[customView(100)]",
                                                                   options: .alignAllCenterY,
                                                                   metrics: nil,
                                                                   views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(<=0)-[customView(100)]",
                                                                 options: .alignAllCenterX,
                                                                 metrics: nil,
                                                                 views: views)
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
        
        /*
         NSLayoutConstraint.activate(horizontalConstraints)
         NSLayoutConstraint.activate(verticalConstraints)
         */
    }
    
    func setupMix() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["customView": customView]
        let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[customView(100)]",
                                                              options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                              metrics: nil,
                                                              views: views)
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[customView(100)]",
                                                               options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                               metrics: nil,
                                                               views: views)
        let horizontalConstraint = NSLayoutConstraint(item: customView, attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: customView,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        view.addConstraints(widthConstraints)
        view.addConstraints(heightConstraints)
        view.addConstraints([horizontalConstraint, verticalConstraint])
        
        /*
         NSLayoutConstraint.activate(widthConstraints)
         NSLayoutConstraint.activate(heightConstraints)
         NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
         */
    }
    
    func setupWithNSLayoutAnchor() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = customView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = customView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = customView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = customView.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint,
                             verticalConstraint,
                             widthConstraint,
                             heightConstraint])
        
        /*
        customView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = customView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = customView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = customView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = customView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([horizontalConstraint,
                                     verticalConstraint,
                                     widthConstraint,
                                     heightConstraint])
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        */
    }
}

