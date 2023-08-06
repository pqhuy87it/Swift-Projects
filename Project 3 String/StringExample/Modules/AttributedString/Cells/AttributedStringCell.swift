//
//  AttributedStringCell.swift
//  TemplateProject
//
//  Created by Pham Quang Huy on 2022/01/13.
//

import UIKit

class AttributedStringCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWith(_ attributedString: NSAttributedString) {
        titleLb.attributedText = attributedString
    }
}
