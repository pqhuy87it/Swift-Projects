//
//  MainViewCell.swift
//  TemplateProject
//
//  Created by HuyPQ22 on 2021/08/22.
//

import UIKit

class MainViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // background view
        bgView.backgroundColor = UIColor.white
        bgView.layer.borderColor = UIColor.Gray7.cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.shadowColor = UIColor.Gray7.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bgView.layer.shadowRadius = 1.0
        bgView.layer.shadowOpacity = 0.9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWith(title: String, description: String?) {
        self.titleLb.text = title
        self.descriptionLb.text = description
    }
    
}
