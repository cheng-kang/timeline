//
//  TDCell1.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDCell1: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var locationLbl: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    
    var content: String! {
        didSet {
            self.contentLbl.text = content
            
            let height = content.heightThatFitsContentByWidth(SCREEN_WIDTH - 40 - 16)
            self.contentLblHeightDif = height - self.contentLblHeight.constant
            self.contentLblHeight.constant = height
        }
    }
    
    @IBOutlet weak var contentLblHeight: NSLayoutConstraint!
    var contentLblHeightDif: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
