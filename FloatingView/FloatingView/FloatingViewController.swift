//
//  FloatingViewController.swift
//  FloatingView
//
//  Created by huy on 2023/06/16.
//

import UIKit


public enum ScrollDirection {
  case up
  case down
  case none
}

public enum FloatingPanelType {
  case normal
  case extendable
}

public enum FloatingPanelMode {
  case shrink
  case extend
}

class FloatingViewController: UIViewController {

    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    var panelMode: FloatingPanelMode = .shrink
    let panelType: FloatingPanelType = .extendable
    
    private var topMarginToEdge: CGFloat {
      if #available(iOS 13.0, *) {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? UIApplication.shared.statusBarFrame.height) +
          (self.navigationController?.navigationBar.frame.height ?? 0.0)
      } else {
        return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
      }
    }
    
    private var isPaning = false
    
    private var lastContentOffsetY: CGFloat = 0
    
    private var contentHeight: CGFloat = 0
    
    public lazy var maxHeight: CGFloat = UIScreen.main.bounds.size.height - topMarginToEdge - 100
    
    private lazy var shrinkContentHeight: CGFloat = {
      return contentHeight * 0.6
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pan.maximumNumberOfTouches = 1
        self.contentView.addGestureRecognizer(pan)
        
        updateContentHeight()
        
        contentViewBottonConstraint.constant = -contentHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isBeingPresented {
          animatePanel(show: true)
        }
    }
    
    func updateContentHeight(height: CGFloat? = nil, shouldAnimate: Bool = false) {
      if let height = height {
        contentHeight = min(maxHeight, height)
      } else {
        contentHeight = maxHeight
      }
      
        contentViewHeightConstraint.constant = contentHeight

      if shouldAnimate {
        UIView.animate(withDuration: 0.2) {
          self.view.layoutIfNeeded()
        }
      } else {
        self.view.layoutIfNeeded()
      }
    }

    // MARK: - Actions
    @objc open func dismissAction() {
      handleDismiss(0.3)
    }
    
    open func handleDismiss(_ duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
      dismissPanel(duration: duration) {
        self.dismiss(animated: false, completion: completion)
      }
    }
    
    // MARK: - Animation
    open func animatePanel(show: Bool, panelMode: FloatingPanelMode = .shrink, completion: (() -> Void)? = nil) {
      var bottomOffset: CGFloat = 0.0
      
      if show {
        switch panelType {
        case .normal:
          bottomOffset = 0.0
          
        case .extendable:
          switch panelMode {
          case .shrink:
            self.panelMode = .shrink
            bottomOffset = contentHeight - shrinkContentHeight
            
          case .extend:
            self.panelMode = .extend
            bottomOffset = 0.0
          }
        }
        
        contentViewBottonConstraint.constant = -bottomOffset
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 2.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: { _ in
          completion?()
        })
      } else {
        dismissPanel(duration: 0.3, completion: completion)
      }
    }
    
    open func dismissPanel(duration: TimeInterval, completion: (() -> Void)?) {
        contentViewBottonConstraint.constant = -contentHeight
      
      UIView.animate(withDuration: duration, animations: {
        self.view.layoutIfNeeded()
      }, completion: { _ in
        completion?()
      })
    }
    
    // handle panel floatation event
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
      // offset of pan gesture
      let panOffsetY = sender.translation(in: contentView).y
      let velocityY = abs(sender.velocity(in: contentView).y)
      let isSwipe = velocityY > 1000
      
      switch sender.state {
      case .began, .changed:
        isPaning = true
        if panelType == .normal || panelMode == .extend {
          if panOffsetY >= 0 {
            contentViewBottonConstraint.constant = -panOffsetY
          }
        } else if panelMode == .shrink {
            contentViewBottonConstraint.constant = -max(0, contentHeight - shrinkContentHeight + panOffsetY)
        } else {
          break
        }
        
      case .ended:
        isPaning = false
        let isSwipeDown = isSwipe && panOffsetY > 0
        switch panelType {
        case .normal:
          if panOffsetY < contentHeight / 2 {
            if isSwipeDown {
              let duration = TimeInterval((contentHeight / UIScreen.main.bounds.size.height) * 0.2)
              handleDismiss(duration)
            } else {
                
              animatePanel(show: true)
            }
          } else {
            handleDismiss(0.15)
          }
        case .extendable:
          switch panelMode {
          case .shrink:
            if panOffsetY < 0 {
              animatePanel(show: true, panelMode: .extend)
            } else if isSwipe || panOffsetY >= shrinkContentHeight / 2 {
              handleDismiss(0.1)
            } else {
              animatePanel(show: true, panelMode: .shrink)
            }
          case .extend:
            if panOffsetY < contentHeight - shrinkContentHeight {
              if isSwipeDown {
                animatePanel(show: true, panelMode: .shrink)
              } else {
                animatePanel(show: true, panelMode: .extend)
              }
            } else if panOffsetY < contentHeight - (shrinkContentHeight / 2) {
              animatePanel(show: true, panelMode: .shrink)
            } else {
              handleDismiss(0.1)
            }
          }
        }
        
      default:
        break
      }
    }
}
