//
//  ItemCellD.swift
//  CollapseExpandSections
//
//  Created by huy on 2023/07/22.
//

import UIKit

class ItemCellD: UITableViewCell {
    
    weak var delegate: ItemCellDelegate?
    
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setup()
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
    }
    
}
