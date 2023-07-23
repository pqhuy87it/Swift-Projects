//
//  ItemViewC.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/23.
//

import UIKit

class ItemViewC: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [[DataItem]] = [[DataItem]]()
    var indexPath: IndexPath?
    
    weak var delegate: ItemCellDelegate?
    
    func setup() {
        collectionView.registerCellByNib(ColorCell.self)
        self.data = (0...2).map({ i in (0...20).map({ j in DataItem("\(String(i)):\(String(j))", colours[i])})})
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension ItemViewC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueCell(ColorCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        let dataItem = data[collectionView.tag][indexPath.item]
            
        cell.label.text = String(indexPath.item) + "\n\n" + dataItem.indexes
        cell.backgroundColor = dataItem.colour
        
        return cell
    }
}
