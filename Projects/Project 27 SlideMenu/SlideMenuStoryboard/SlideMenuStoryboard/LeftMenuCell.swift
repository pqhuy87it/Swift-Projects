//
//  LeftMenuCell.swift
//  SlideMenuStoryboard
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {

	@IBOutlet weak var titleLb: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configWith(_ model: NavigationModel) {
		self.titleLb.text = model.name
	}
}
