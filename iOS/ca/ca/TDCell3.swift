//
//  TDCell3.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDCell3: UITableViewCell {

    @IBOutlet weak var avatarView: RoundedCornerImage!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var datetimeLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var contentLblHeight: NSLayoutConstraint!
    
    var contentLblHeightDif: CGFloat = 0
    
    var updateCellHeightClosure: ((height: String)->())?
    
    var content: String! {
        didSet {
            contentLbl.text = content
            
            let height = content.heightThatFitsContentByWidth(SCREEN_WIDTH - 40 - 60 - 8)
            self.contentLblHeightDif = height - self.contentLblHeight.constant
            self.contentLblHeight.constant = height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
