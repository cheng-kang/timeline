//
//  CircularItemListMenu.swift
//  ca
//
//  Created by Ant on 16/7/16.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class CircularItemListMenu: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var eventBtn: CircularButton!
    @IBOutlet weak var wishBtn: CircularButton!
    @IBOutlet weak var momentBtn: CircularButton!
    @IBOutlet weak var plusButton: CircularButton!
    
    var momentBtnClickClosure: (()->())?
    
    
    var eventBtnPosition: CGPoint!
    var wishBtnPosition: CGPoint!
    var momentBtnPosition: CGPoint!
    var plusBtnPosition: CGPoint!
    
    var isFold = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSizeMake(3, -3)
        
//        self.frame = UIScreen.mainScreen().bounds
        self.frame = CGRectMake(UIScreen.mainScreen().bounds.width - self.frame.width - 10, UIScreen.mainScreen().bounds.height - self.frame.height - 30, self.frame.width, self.frame.height)
        self.plusButton.frame = CGRectMake(UIScreen.mainScreen().bounds.width - self.frame.width - 10, UIScreen.mainScreen().bounds.height - self.frame.height - 30, 45, 45)
        self.plusBtnPosition = self.plusButton.layer.position
        self.eventBtnPosition = self.eventBtn.layer.position
        self.wishBtnPosition = self.wishBtn.layer.position
        self.momentBtnPosition = self.momentBtn.layer.position
        print(self.frame)
        self.alpha = 0
    }
    
    class func circularItemListMenu() -> CircularItemListMenu {
        
        let listMenu = NSBundle.mainBundle().loadNibNamed("CircularItemListMenu", owner: nil, options: nil).first as! CircularItemListMenu
        
        UIApplication.sharedApplication().keyWindow?.addSubview(listMenu)
        
        return listMenu
    }
    
    func show() {
        self.alpha = 1
        self.layer.shadowOpacity = 0.3
        
        print(self.plusButton.frame)
        
        self.eventBtn.layer.position = self.plusBtnPosition
        self.wishBtn.layer.position = self.plusBtnPosition
        self.momentBtn.layer.position = self.plusBtnPosition
        self.eventBtn.alpha = 0
        self.wishBtn.alpha = 0
        self.momentBtn.alpha = 0
    
    }
    
    func hide() {
        self.alpha = 0
//        self.removeFromSuperview()
    }
    
    @IBAction func plusBtnClick(sender: CircularButton) {
        if isFold {
            
            UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseIn], animations: {
                self.eventBtn.alpha = 1
                self.eventBtn.layer.position = self.eventBtnPosition
                }, completion: { (complete) in
            })
            UIView.animateWithDuration(0.2, delay: 0.1, options: [.CurveEaseIn], animations: {
                self.wishBtn.alpha = 1
                self.wishBtn.layer.position = self.wishBtnPosition
                }, completion: { (complete) in
            })
            UIView.animateWithDuration(0.1, delay: 0.2, options: [.CurveEaseIn], animations: {
                self.momentBtn.alpha = 1
                self.momentBtn.layer.position = self.momentBtnPosition
                }, completion: { (complete) in
            })
        } else {
            UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseIn], animations: {
                self.eventBtn.alpha = 0
                self.eventBtn.layer.position = self.plusBtnPosition
                }, completion: { (complete) in
            })
            UIView.animateWithDuration(0.2, delay: 0.1, options: [.CurveEaseIn], animations: {
                self.wishBtn.alpha = 0
                self.wishBtn.layer.position = self.plusBtnPosition
                }, completion: { (complete) in
            })
            UIView.animateWithDuration(0.1, delay: 0.2, options: [.CurveEaseIn], animations: {
                self.momentBtn.alpha = 0
                self.momentBtn.layer.position = self.plusBtnPosition
                }, completion: { (complete) in
            })
        }
        isFold = !isFold
    }
    @IBAction func momentBtnClick(sender: CircularButton) {
        momentBtnClickClosure!()
    }
    @IBAction func wishBtnClick(sender: CircularButton) {
        
    }
    @IBAction func eventBtnClick(sender: CircularButton) {
        
    }
}
