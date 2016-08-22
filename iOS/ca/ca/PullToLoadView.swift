//
//  PullToLoadView.swift
//  CA
//
//  Created by Ant on 16/7/27.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PullToLoadView: UIView {
    
    var viewHeight: CGFloat = 60
    var superViewWidth: CGFloat?
    var iconHeight: CGFloat = 18
    var iconTintColor = GREEN_THEME_COLOR
    
    let iconView = UIImageView()
    var isRotated = false
    var isUp = false
    
    func initView(isUp: Bool, superViewWidth: CGFloat, superViewHeight: CGFloat) {
        self.isUp = isUp
        self.superViewWidth = superViewWidth
        
        self.frame = CGRectMake(0,
                                isUp ? -viewHeight : superViewHeight,
                                superViewWidth,
                                viewHeight)
        
        // icon view
        let iconImage = UIImage(named: "Circled Up")!
        self.iconView.image = iconImage.imageWithRenderingMode(.AlwaysTemplate)
        self.iconView.tintColor = iconTintColor
        self.iconView.frame = CGRectMake((superViewWidth / 2) - (iconHeight / 2), (viewHeight / 2) - (iconHeight / 2), iconHeight, iconHeight)
        if !isUp {
            self.iconView.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180)
        }
        
        self.addSubview(self.iconView)
    }
    
    func updateFrame(superViewWidth: CGFloat, superViewHeight: CGFloat) {
        
        self.frame = CGRectMake(0,
                                isUp ? -viewHeight : superViewHeight,
                                superViewWidth,
                                viewHeight)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

