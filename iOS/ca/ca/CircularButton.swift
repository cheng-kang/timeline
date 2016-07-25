//
//  CircularButton.swift
//  ca
//
//  Created by Ant on 16/7/16.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    // When creating a Circular Button, the width should equal to the height.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
