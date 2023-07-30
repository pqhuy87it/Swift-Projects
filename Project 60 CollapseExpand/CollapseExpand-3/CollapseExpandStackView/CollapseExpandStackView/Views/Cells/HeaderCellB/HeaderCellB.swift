//
//  ItemCellB.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/21.
//

import UIKit

class HeaderCellB: UITableViewCell {
    
    weak var delegate: ItemCellDelegate?
    
    var collectionViewLayout: CustomLayout?
    var indexPath: IndexPath?


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
    }
    
    
    func setup() {
        self.selectionStyle = .none
    }
    
}
