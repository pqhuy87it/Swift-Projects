//
//  CollapseExpandCellsViewController.swift
//  CollapseExpandCells
//
//  Created by huy on 2023/07/21.
//

import UIKit

class CollapseExpandCellsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = [Item(type: .ItemB, cellState: .expand),
                         Item(type: .ItemA, cellState: .expand),
                         Item(type: .ItemC, cellState: .expand),
                         Item(type: .ItemD, cellState: .expand)]

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
    }
    
    func expandCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        self.items[indexPath.row].state = .expand
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
        }
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
            if cell.frame.minY < self.tableView.contentOffset.y {
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            } else if cell.frame.maxY > self.tableView.frame.maxY + self.tableView.contentOffset.y {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }, completion: nil)
        
        CATransaction.commit()
    }
    
    func collapseCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        self.items[indexPath.row].state = .collapse
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
            if cell.frame.minY < self.tableView.contentOffset.y {
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            } else if cell.frame.maxY > self.tableView.frame.maxY + self.tableView.contentOffset.y {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }, completion: nil)
        
        CATransaction.commit()
    }
}

//MARK: - UITableViewDelegate

extension CollapseExpandCellsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.items[indexPath.row]
        
        if item.state == .collapse {
            return 40
        }
        
        switch item.type {
        case .ItemA:
            
            return 200//UITableView.automaticDimension
        case .ItemB:

            return 356//UITableView.automaticDimension
        case .ItemC:
            
            return (40 + 150)
        case .ItemD:

            return 183 //UITableView.automaticDimension
        }
    }
}

//MARK: - UITableViewDataSource

extension CollapseExpandCellsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        
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
        }
        
       
    }
}

extension CollapseExpandCellsViewController: ItemCellDelegate {
    func didTapCell(_ cell: UITableViewCell, at indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        
        let item = self.items[indexPath.row]
        
        if item.state == .expand {
            self.collapseCell(cell, at: indexPath)
        } else {
            self.expandCell(cell, at: indexPath)
        }
    }
}
