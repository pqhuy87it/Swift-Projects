//
//  VisualFormatLanguageCell.swift
//  Autolayout
//
//  Created by Pham Quang Huy on 2022/01/01.
//

import UIKit

class VisualFormatLanguageCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // background view
        mainView.backgroundColor = UIColor.white
        mainView.layer.borderColor = UIColor.Gray7.cgColor
        mainView.layer.borderWidth = 0.5
        mainView.layer.shadowColor = UIColor.Gray7.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 1)
        mainView.layer.shadowRadius = 1.0
        mainView.layer.shadowOpacity = 0.9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
