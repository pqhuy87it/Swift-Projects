//
//  CollapseExpandStackViewViewController.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/21.
//

import UIKit

class CollapseExpandStackViewViewController: UIViewController {
    
    @IBOutlet weak var stackViews: UIStackView!
    
    
    var items: [Item] = [Item(type: .ItemA, state: .expand, headerTitle: ItemType.ItemA.rawValue),
                         Item(type: .ItemB, state: .expand, headerTitle: ItemType.ItemB.rawValue),
                         Item(type: .ItemC, state: .expand, headerTitle: ItemType.ItemC.rawValue),
                         Item(type: .ItemD, state: .expand, headerTitle: ItemType.ItemD.rawValue),
                         Item(type: .ItemE, state: .expand, headerTitle: ItemType.ItemE.rawValue)
    ]
    
    lazy var headerViewA: HeaderView = {
        let headerView = (Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0]) as! HeaderView
        
        headerView.delegate = self
        headerView.headerBtn.tag = 0
        
        return headerView
    }()
    
    lazy var headerViewB: HeaderView = {
        let headerView = (Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0]) as! HeaderView
        
        headerView.delegate = self
        headerView.headerBtn.tag = 1
        
        return headerView
    }()
    
    lazy var headerViewC: HeaderView = {
        let headerView = (Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0]) as! HeaderView
        
        headerView.delegate = self
        headerView.headerBtn.tag = 2
        
        return headerView
    }()
    
    lazy var headerViewD: HeaderView = {
        let headerView = (Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0]) as! HeaderView
        
        headerView.delegate = self
        headerView.headerBtn.tag = 3
        
        return headerView
    }()
    
    lazy var headerViewE: HeaderView = {
        let headerView = (Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0]) as! HeaderView
        
        headerView.delegate = self
        headerView.headerBtn.tag = 4
        
        return headerView
    }()
    
    lazy var itemViewA: ItemViewA = {
        let itemViewA = (Bundle.main.loadNibNamed("ItemViewA", owner: self, options: nil)![0]) as! ItemViewA
        
        return itemViewA
    }()
    
    lazy var itemViewB: ItemViewB = {
        let itemView = (Bundle.main.loadNibNamed("ItemViewB", owner: self, options: nil)![0]) as! ItemViewB
        itemView.setup()
        
        return itemView
    }()
    
    lazy var itemViewC: ItemViewC = {
        let itemView = Bundle.main.loadNibNamed("ItemViewC", owner: self, options: nil)![0] as! ItemViewC
        
        itemView.setup()
        
        return itemView
    }()
    
    lazy var itemViewD: ItemViewD = {
        let itemView = (Bundle.main.loadNibNamed("ItemViewD", owner: self, options: nil)![0]) as! ItemViewD
        
        return itemView
    }()
    
    lazy var itemViewE: ItemViewE = {
        let itemView = (Bundle.main.loadNibNamed("ItemViewE", owner: self, options: nil)![0]) as! ItemViewE
        
        itemView.setup()
        
        return itemView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.itemViewB.reloadData()
        self.itemViewC.reloadData()
        
//        self.headerViewA.up
        
        self.stackViews.layoutIfNeeded()
    }

    func setupUI() {
        
        for (_, item) in self.items.enumerated() {
            switch item.type {
            case .ItemA:
                self.headerViewA.titleLb.text = item.headerTitle
                
                stackViews.addArrangedSubview(self.headerViewA)
                stackViews.addArrangedSubview(self.itemViewA)
                let spaceView1 = (Bundle.main.loadNibNamed("SpaceView", owner: self, options: nil)![0]) as! SpaceView
                stackViews.addArrangedSubview(spaceView1)
            case .ItemB:
                self.headerViewB.titleLb.text = item.headerTitle
                
                stackViews.addArrangedSubview(self.headerViewB)
                stackViews.addArrangedSubview(self.itemViewB)
                let spaceView2 = (Bundle.main.loadNibNamed("SpaceView", owner: self, options: nil)![0]) as! SpaceView
                stackViews.addArrangedSubview(spaceView2)
            case .ItemC:
                self.headerViewC.titleLb.text = item.headerTitle
                
                stackViews.addArrangedSubview(self.headerViewC)
                stackViews.addArrangedSubview(self.itemViewC)
                let spaceView3 = (Bundle.main.loadNibNamed("SpaceView", owner: self, options: nil)![0]) as! SpaceView
                stackViews.addArrangedSubview(spaceView3)
            case .ItemD:
                self.headerViewD.titleLb.text = item.headerTitle
                
                stackViews.addArrangedSubview(self.headerViewD)
                stackViews.addArrangedSubview(self.itemViewD)
                let spaceView4 = (Bundle.main.loadNibNamed("SpaceView", owner: self, options: nil)![0]) as! SpaceView
                stackViews.addArrangedSubview(spaceView4)
            case .ItemE:
                self.headerViewE.titleLb.text = "Header View E"

                stackViews.addArrangedSubview(self.headerViewE)
                stackViews.addArrangedSubview(self.itemViewE)
                let spaceView5 = (Bundle.main.loadNibNamed("SpaceView", owner: self, options: nil)![0]) as! SpaceView
                stackViews.addArrangedSubview(spaceView5)
            }
        }
    }
}


extension CollapseExpandStackViewViewController: ItemCellDelegate {
    func didTapButton(_ button: RoundedButton) {
        let item = self.items[button.tag]
        
        button.updateUI(rect: button.bounds, state: item.state)
        
        switch button.tag {
        case 0:
            self.headerViewA.isUserInteractionEnabled = false
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.headerViewA.isUserInteractionEnabled = true
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.itemViewA.isHidden = !self.itemViewA.isHidden
            }, completion: nil)
            
            CATransaction.commit()
        case 1:
            self.headerViewB.isUserInteractionEnabled = false
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.headerViewB.isUserInteractionEnabled = true
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
//                self.itemViewB.isHidden = !self.itemViewB.isHidden
//                if self.itemViewB.collectionViewHeightConstraint.constant > 0 {
//                    self.itemViewB.collectionViewHeightConstraint.constant = 0
//                } else {
//                    self.itemViewB.reloadData()
//                }
                
                self.itemViewB.isHidden = !self.itemViewB.isHidden
                
                if self.itemViewB.alpha == 1 {
                    self.itemViewB.alpha = 0
                } else {
                    self.itemViewB.alpha = 1
                }
            }, completion: nil)
            
            CATransaction.commit()
        case 2:
            self.headerViewC.isUserInteractionEnabled = false
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.headerViewC.isUserInteractionEnabled = true
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.itemViewC.isHidden = !self.itemViewC.isHidden
                
                if self.itemViewC.alpha == 1 {
                    self.itemViewC.alpha = 0
                } else {
                    self.itemViewC.alpha = 1
                }
            }, completion: nil)
            
            CATransaction.commit()
        case 3:
            self.headerViewD.isUserInteractionEnabled = false
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.headerViewD.isUserInteractionEnabled = true
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.itemViewD.isHidden = !self.itemViewD.isHidden
            }, completion: nil)
            
            CATransaction.commit()
        case 4:
            self.headerViewE.isUserInteractionEnabled = false
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.headerViewE.isUserInteractionEnabled = true
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.itemViewE.isHidden = !self.itemViewE.isHidden
            }, completion: nil)
            
            CATransaction.commit()
        default:
            break
        }
        
        if item.state == .expand {
            self.items[button.tag].state = .collapse
        } else {
            self.items[button.tag].state = .expand
        }

    }
}
