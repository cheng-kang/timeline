//
//  TDCell2.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDCell2: UIView {

    
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var selectedBar: UIView!
    
    var commentBtnClosure: (()->())?
    var messageBtnClosure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func headerview() -> TDCell2 {
        
        let vc = NSBundle.mainBundle().loadNibNamed("TDCell2", owner: nil, options: nil).first as! TDCell2
        return vc
    }
}


extension TDCell2 {
    
    @IBAction func commentBtnClick(sender: UIButton) {
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: { 
            self.selectedBar.frame.origin.x = 0
        }) { (_) in
            self.commentBtn.titleLabel?.textColor = GREEN_THEME_COLOR_DARK
            self.messageBtn.titleLabel?.textColor = GREEN_THEME_COLOR
        }
        
        commentBtnClosure!()
    }
    
    @IBAction func messageBtnClick(sender: UIButton) {
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            self.selectedBar.frame.origin.x = 60
        }) { (_) in
            self.commentBtn.titleLabel?.textColor = GREEN_THEME_COLOR
            self.messageBtn.titleLabel?.textColor = GREEN_THEME_COLOR_DARK
        }
        messageBtnClosure!()
    }
    
    
}