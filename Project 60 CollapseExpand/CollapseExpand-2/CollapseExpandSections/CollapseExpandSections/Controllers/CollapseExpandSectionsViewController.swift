//
//  CollapseExpandSectionsViewController.swift
//  CollapseExpandSections
//
//  Created by huy on 2023/07/21.
//

import UIKit

class CollapseExpandSectionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshData()
    }

    func setupUI() {
        setupTableView()
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 400
        self.tableView.registerCellByNib(ItemCellA.self)
        self.tableView.registerCellByNib(ItemCellB.self)
        self.tableView.registerCellByNib(ItemCellC.self)
        self.tableView.registerCellByNib(ItemCellD.self)
        self.tableView.registerCellByNib(ItemCellE.self)
        
        self.tableView.registerCellByNib(HeaderCellA.self)
        self.tableView.registerCellByNib(HeaderCellB.self)
        self.tableView.registerCellByNib(HeaderCellC.self)
        self.tableView.registerCellByNib(HeaderCellD.self)
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
            self.tableView.performBatchUpdates {
                self.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            } completion: { _ in
                let newCell = self.tableView.cellForRow(at: indexPath)
                
                guard let newCell = newCell else {
                    return
                }
                
                if newCell.frame.minY < self.tableView.contentOffset.y {
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                } else if newCell.frame.maxY > self.tableView.frame.maxY + self.tableView.contentOffset.y {
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }

            
            
            
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
            self.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
            
            let newCell = self.tableView.cellForRow(at: indexPath)
            
            guard let newCell = newCell else {
                return
            }
            
            if newCell.frame.minY < self.tableView.contentOffset.y {
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            } else if newCell.frame.maxY > self.tableView.frame.maxY + self.tableView.contentOffset.y {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }, completion: nil)
        
        CATransaction.commit()
    }
}

//MARK: - UITableViewDelegate

extension CollapseExpandSectionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - UITableViewDataSource

extension CollapseExpandSectionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let object = self.items[section]
        
        if let item = object as? Item, item.state == .collapse {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = self.items[indexPath.section]
        
        if let header = object as? Header {
            switch header.type {
            case .ItemA:
                guard let cell = tableView.dequeueCell(HeaderCellA.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemB:
                guard let cell = tableView.dequeueCell(HeaderCellB.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemC:
                guard let cell = tableView.dequeueCell(HeaderCellC.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemD:
                guard let cell = tableView.dequeueCell(HeaderCellD.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemE:
                guard let cell = tableView.dequeueCell(HeaderCellD.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                cell.titleLb.text = header.title
                
                return cell
            }
        } else if let item = object as? Item {
            switch item.type {
            case .ItemA:
                guard let cell = tableView.dequeueCell(ItemCellA.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemB:
                guard let cell = tableView.dequeueCell(ItemCellB.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                cell.reloadData()
                
                return cell
            case .ItemC:
                guard let cell = tableView.dequeueCell(ItemCellC.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemD:
                guard let cell = tableView.dequeueCell(ItemCellD.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                
                return cell
            case .ItemE:
                guard let cell = tableView.dequeueCell(ItemCellE.self, forIndexPath: indexPath) else {
                    return UITableViewCell()
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                cell.reloadData()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension CollapseExpandSectionsViewController: ItemCellDelegate {
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
