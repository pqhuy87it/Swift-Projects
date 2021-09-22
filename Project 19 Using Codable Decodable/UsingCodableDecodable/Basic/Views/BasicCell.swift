//
//  BasicCell.swift
//  UsingCodableDecodable
//
//  Created by HuyPQ22 on 2021/09/22.
//  Copyright © 2021 exlinct. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {

    @IBOutlet weak var sttViewBg: UIView!
    @IBOutlet weak var sttLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        sttViewBg.layer.cornerRadius = 3.0
        self.selectionStyle = .none
    }
    
    func configWith(_ indexPath: IndexPath, subject: Subject) {
        self.sttLabel.text = "\(indexPath.row + 1)"
        self.contentLabel.text = subject.title
        self.descriptionLabel.text = subject.description
    }
}
