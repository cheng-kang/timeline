//
//  PullToLoadView.swift
//  CA
//
//  Created by Ant on 16/7/27.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PullToLoadView: UIView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var viewHeight: CGFloat?
    var superViewWidth: CGFloat?
    var iconHeight: CGFloat?
    var iconTintColor: UIColor? {
        didSet {
            self.iconView.tintColor = iconTintColor
        }
    }
    
    let iconView = UIImageView()
    var isRotated = false
    var isUp = false
    
    func initView(isUp: Bool,viewHeight: CGFloat, superViewWidth: CGFloat, superViewHeight: CGFloat, iconHeight: CGFloat = 18, iconTintColor: UIColor = UIColor.grayColor()) {
        self.isUp = isUp
        self.viewHeight = viewHeight
        self.superViewWidth = superViewWidth
        self.iconHeight = iconHeight
        self.iconTintColor = iconTintColor
        
        self.frame = CGRectMake(0,
                                isUp ? -viewHeight : superViewHeight,
                                superViewWidth,
                                viewHeight)
        
        // special for this project
        let lineView = UIView()
        lineView.backgroundColor = GREY_THEME_COLOR
        lineView.frame = CGRectMake((superViewWidth / 2) - 0.5, 0, 1, viewHeight)
        
        // icon view
        let iconImage = UIImage(named: "Circled Up")!
        self.iconView.image = iconImage.imageWithRenderingMode(.AlwaysTemplate)
        self.iconView.tintColor = iconTintColor
        self.iconView.frame = CGRectMake((superViewWidth / 2) - (iconHeight / 2), (viewHeight / 2) - (iconHeight / 2), iconHeight, iconHeight)
        
        self.addSubview(lineView)
        self.addSubview(self.iconView)
    }
    
    func updateFrame(viewHeight: CGFloat, superViewWidth: CGFloat, superViewHeight: CGFloat) {
        
        self.frame = CGRectMake(0,
                                isUp ? -viewHeight : superViewHeight,
                                superViewWidth,
                                viewHeight)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

