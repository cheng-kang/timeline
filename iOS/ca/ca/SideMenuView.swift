//
//  SideMenuView.swift
//  ca
//
//  Created by Ant on 16/7/15.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

class SideMenuView: UIView {
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var menuPanel: UIView!
    @IBOutlet weak var profileItem: ElasticView!
    @IBOutlet weak var lifeItem: ElasticView!
    @IBOutlet weak var bucketlistItem: ElasticView!
    @IBOutlet weak var visitedItem: ElasticView!
    @IBOutlet weak var eventsItem: ElasticView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var lifeBtn: UIButton!
    @IBOutlet weak var visitedBtn: UIButton!
    @IBOutlet weak var eventsBtn: UIButton!
    @IBOutlet weak var butcketlistBtn: UIButton!
    @IBOutlet weak var avatarImg: RoundedCornerImage!
    
    var menuDismissing: (()->())?
    var profileBtnClickClosure: (()->())?
    var lifeBtnClickClosure: (()->())?
    var visitedBtnClickClosure: (()->())?
    var momentBtnClickClosure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarImg.showBorder = true
        
        self.menuPanel.layer.shadowColor = UIColor.blackColor().CGColor
        self.menuPanel.layer.shadowOpacity = 0.7
        self.menuPanel.layer.shadowRadius = 50
        
        self.frame = UIScreen.mainScreen().bounds
        self.alpha = 0
    }
    
    class func sideMenuView(avatar: UIImage) -> SideMenuView {
        
        let sideMenu = NSBundle.mainBundle().loadNibNamed("SideMenuView", owner: nil, options: nil).first as! SideMenuView
        
        sideMenu.avatarImg.image = avatar
        
        return sideMenu
    }
    
    func show() {
        self.alpha = 0
        self.menuPanel.layer.shadowOpacity = 0.7
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        self.profileItem.startShowAnimation()
        self.lifeItem.startShowAnimation()
        self.bucketlistItem.startShowAnimation()
        self.visitedItem.startShowAnimation()
        self.eventsItem.startShowAnimation()
        
        let menuPanelWidth = self.menuPanel.frame.width
        let menuPanelHeight = self.menuPanel.frame.height
        self.menuPanel.frame = CGRectMake(-1 * menuPanelWidth, 0, menuPanelWidth, menuPanelHeight)
        
        UIView.animateWithDuration(0.25, delay: 0, options: [.CurveEaseOut], animations: {
            self.alpha = 1
            self.menuPanel.frame = CGRectMake(0, 0, menuPanelWidth, menuPanelHeight)
        }) { (complete) in
            if complete {
            }
        }
    }
    
    func hide() {
        let menuPanelWidth = self.menuPanel.frame.width
        let menuPanelHeight = self.menuPanel.frame.height
        
        
        let shadowAnimation = CABasicAnimation()
        shadowAnimation.keyPath = "shadowOpacity"
        shadowAnimation.fromValue = 0.7
        shadowAnimation.toValue = 0
        shadowAnimation.duration = 0.3
        
        self.menuPanel.layer.addAnimation(shadowAnimation, forKey: "shadowOpacity")
        self.menuPanel.layer.shadowOpacity = 0.7
        
        self.profileItem.startHideAnimation()
        self.lifeItem.startHideAnimation()
        self.bucketlistItem.startHideAnimation()
        self.visitedItem.startHideAnimation()
        self.eventsItem.startHideAnimation()
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseIn], animations: {
            self.menuPanel.frame = CGRectMake(-1 * menuPanelWidth, 0, menuPanelWidth, menuPanelHeight)
            self.menuPanel.layer.shadowOpacity = 0
            }) { (complete) in
                if complete {
                    self.removeFromSuperview()
                }
        }
        self.menuDismissing!()
    }
    
    @IBAction func profileBtnClick(sender: UIButton) {
        profileBtnClickClosure!()
        hide()
    }
    @IBAction func lifeBtnClick(sender: UIButton) {
        lifeBtnClickClosure!()
        hide()
    }
    @IBAction func bucketlistBtnClick(sender: UIButton) {
    }
    @IBAction func visitedBtnClick(sender: UIButton) {
        visitedBtnClickClosure!()
        hide()
    }
    @IBAction func eventsBtnClick(sender: UIButton) {
    }
    @IBAction func dismissBtnClick(sender: UIButton) {
        hide()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
