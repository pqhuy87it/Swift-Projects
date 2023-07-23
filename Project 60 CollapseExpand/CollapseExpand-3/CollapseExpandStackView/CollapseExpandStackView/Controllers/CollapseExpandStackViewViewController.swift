//
//  CollapseExpandStackViewViewController.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/21.
//

import UIKit

class CollapseExpandStackViewViewController: UIViewController {
    
    @IBOutlet weak var stackViews: UIStackView!
    
    
    var items: [BaseObject] = [Header(title: "Header A", cellType: .ItemA),
                               Item(type: .ItemB, cellState: .expand),
                               Header(title: "Header B", cellType: .ItemB),
                               Item(type: .ItemA, cellState: .expand),
                               Header(title: "Header C", cellType: .ItemC),
                               Item(type: .ItemC, cellState: .expand),
                               Header(title: "Header D", cellType: .ItemD),
                               Item(type: .ItemD, cellState: .expand),
                               Header(title: "Header E", cellType: .ItemE),
                               Item(type: .ItemE, cellState: .expand)]
    
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
        let itemView = (Bundle.main.loadNibNamed("ItemViewC", owner: self, options: nil)![0]) as! ItemViewC
        
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
    }

    func setupUI() {
        
        self.headerViewA.titleLb.text = "Header View A"
        
        stackViews.addArrangedSubview(self.headerViewA)
        stackViews.addArrangedSubview(self.itemViewA)
        
        self.headerViewB.titleLb.text = "Header View B"
        
        stackViews.addArrangedSubview(self.headerViewB)
        stackViews.addArrangedSubview(self.itemViewB)
        
        self.headerViewC.titleLb.text = "Header View C"
        
        stackViews.addArrangedSubview(self.headerViewC)
        stackViews.addArrangedSubview(self.itemViewC)
        
        self.headerViewD.titleLb.text = "Header View D"
        
        stackViews.addArrangedSubview(self.headerViewD)
        stackViews.addArrangedSubview(self.itemViewD)
        
        self.headerViewE.titleLb.text = "Header View E"

        stackViews.addArrangedSubview(self.headerViewE)
        stackViews.addArrangedSubview(self.itemViewE)
        
        self.itemViewB.reloadData()
        self.itemViewC.reloadData()
        
        self.stackViews.layoutIfNeeded()
    }
    
    func expandCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let object = self.items[indexPath.section]
        
        guard let item = object as? Item else {
            return
        }
        
        item.state = .expand
        
        self.items[indexPath.section] = item
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            
            
            
            
        }, completion: nil)
        
        CATransaction.commit()
    }
    
    func collapseCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let object = self.items[indexPath.section]
        
        guard let item = object as? Item else {
            return
        }
        
        item.state = .collapse
        
        self.items[indexPath.section] = item
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            
        }, completion: nil)
        
        CATransaction.commit()
    }
}


extension CollapseExpandStackViewViewController: ItemCellDelegate {
    func didTapButton(_ button: UIButton) {
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
    }
    
    func didTapCell(_ cell: UITableViewCell, at indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        
        let newIndexPath = IndexPath(row: 0, section: (indexPath.section + 1))
        
        let object = self.items[newIndexPath.section]
        
        guard let item = object as? Item else {
            return
        }
        
        if item.state == .expand {
            self.collapseCell(cell, at: newIndexPath)
        } else {
            self.expandCell(cell, at: newIndexPath)
        }
    }
}
