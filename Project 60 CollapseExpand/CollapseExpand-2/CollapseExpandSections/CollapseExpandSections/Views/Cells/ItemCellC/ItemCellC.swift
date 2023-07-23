//
//  ItemCellC.swift
//  CollapseExpandSections
//
//  Created by huy on 2023/07/22.
//

import UIKit

class ItemCellC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [[DataItem]] = [[DataItem]]()
    var indexPath: IndexPath?
    
    weak var delegate: ItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDidTap(_ sender: Any) {
        self.delegate?.didTapCell(self, at: indexPath)
    }
    
    
    func setup() {
        self.selectionStyle = .none
        
        collectionView.registerCellByNib(ColorCell.self)
        self.data = (0...2).map({ i in (0...20).map({ j in DataItem("\(String(i)):\(String(j))", colours[i])})})
    }
    
}

extension ItemCellC: UICollectionViewDataSource, UICollectionViewDelegate {
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
