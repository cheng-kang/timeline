//
//  CommentTopCell.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class CommentTopCell: UITableViewCell {

    @IBOutlet weak var cardTopView: UIView!
    @IBOutlet weak var cardTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.cardTopView.layer.cornerRadius = 10
        self.cardTopView.clipsToBounds = true
        self.cardTopView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cardTopView.layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
