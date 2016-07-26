//
//  CommentCell.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var cardMiddleView: UIView!
    @IBOutlet weak var commentMetaInfoLbl: UILabel!
    @IBOutlet weak var commentContentLbl: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.cardMiddleView.clipsToBounds = true
        self.cardMiddleView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cardMiddleView.layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
