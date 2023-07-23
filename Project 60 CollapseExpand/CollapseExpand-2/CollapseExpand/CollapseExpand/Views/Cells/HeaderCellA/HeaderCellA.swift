//
//  ItemCellA.swift
//  CollapseExpand
//
//  Created by huy on 2023/07/21.
//

import UIKit

class HeaderCellA: UITableViewCell {
    
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
