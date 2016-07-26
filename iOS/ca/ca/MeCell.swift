//
//  MeCell.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {

    @IBOutlet weak var avatarImg: RoundedCornerImage!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var msgTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.bubbleView.clipsToBounds = true
        self.bubbleView.layer.cornerRadius = 6
        self.bubbleView.layer.borderWidth = 1
        self.bubbleView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
