//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 01/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
