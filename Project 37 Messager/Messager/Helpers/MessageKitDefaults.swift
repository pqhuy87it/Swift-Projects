//
//  MessageKitDefaults.swift
//  Messager
//
//  Created by David Kababyan on 30/08/2020.
//

import Foundation
import UIKit
import MessageKit

struct MKSender: SenderType, Equatable {
    var senderId: String
    var displayName: String
}

enum MessageDefaults {
    //Bubble
    static let bubbleColorOutgoing = UIColor(named: "chatOutgoingBubble") ?? UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
    static let bubbleColorIncoming = UIColor(named: "chatIncomingBubble") ?? UIColor(red: 230/255, green: 229/255, blue: 234/255, alpha: 1.0)

}

