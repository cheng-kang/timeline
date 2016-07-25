//
//  RoundedCornerImage.swift
//  ca
//
//  Created by Ant on 16/7/15.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class RoundedCornerImage: UIImageView {
    
    var borderWidth = CGFloat(3)
    var borderColor = UIColor.whiteColor().CGColor
    
    var showBorder = false {
        didSet {
            if showBorder {
                self.layer.borderWidth = borderWidth
                self.layer.borderColor = borderColor
            } else {
                self.layer.borderWidth = 0
            }
        }
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
