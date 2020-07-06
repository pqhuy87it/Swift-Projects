//
//  MessageView.swift
//  ReusableXibViews
//
//  Created by Matthias Lamoureux on 13/01/2020.
//  Copyright © 2020 QSC. All rights reserved.
//

import UIKit

@IBDesignable class MessageViewWrapper : NibWrapperView<MessageView> { }

class MessageView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageIcon: UIImageView!

    var message : String = "" {
        didSet { messageLabel.text = message }
    }
    
    var symbol : String = "" {
        didSet { if #available(iOS 13.0, *) {
            messageIcon.image = UIImage(systemName: symbol)
        } else {
            // Fallback on earlier versions
            } }
    }
}
