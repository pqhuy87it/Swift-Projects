//
//  HeaderView.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/23.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var headerBtn: RoundedButton!
    
    weak var delegate: ItemCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    @IBAction func btnDidTapped(_ sender: RoundedButton) {
        self.delegate?.didTapButton(sender)
    }
    
    
}
