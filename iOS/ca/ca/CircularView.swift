//
//  RoundView.swift
//  ca
//
//  Created by Ant on 16/7/14.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class CircularView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
