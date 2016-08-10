//
//  CommentBottomCell.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class CommentBottomCell: UITableViewCell {

    @IBOutlet weak var cardBottomView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.cardBottomView.layer.cornerRadius = 6
        self.cardBottomView.clipsToBounds = true
        self.cardBottomView.layer.borderColor = THEME().TextSubColor.CGColor
        self.cardBottomView.layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
