//
//  ItemCellA.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/21.
//

import UIKit

protocol ItemCellDelegate: AnyObject {
    func didTapCell(_ cell: UITableViewCell, at indexPath: IndexPath?)
    func didTapButton(_ button: UIButton)
}

class ItemCellA: UITableViewCell {
    
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
