//
//  ChatMessageTableViewCell.swift
//  Chatly
//
//  Created by Matthew Carroll on 10/26/16.
//  Copyright © 2016 codepath.com. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {

    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    public var message: String = "" {
        didSet {
            messageLabel.text = message
        }
    }
    
    public var username: String = "" {
        didSet {
            userNameLabel.text = username
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
