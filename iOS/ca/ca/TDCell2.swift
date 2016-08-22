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
    @IBOutlet weak var speakBtn: UIButton!
    @IBOutlet weak var selectedBar: UIView!
    @IBOutlet weak var selectedBarX: NSLayoutConstraint!
    
    
    var commentBtnClosure: (()->())?
    var messageBtnClosure: (()->())?
    var speakBtnClosure: (()->())?
    var commentSentClosure: ((comment: TimelineComment)->())?
    
    var isMessage = true {
        didSet {
            if isMessage != oldValue {
                if isMessage {
                    if messageBtnClosure != nil {
                        messageBtnClosure!()
                    }
                } else {
                    if commentBtnClosure != nil {
                        commentBtnClosure!()
                    }
                }
            }
        }
    }
    
    var id: String!
    var hasComment = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }
    
    class func headerview() -> TDCell2 {
        
        let vc = NSBundle.mainBundle().loadNibNamed("TDCell2", owner: nil, options: nil).first as! TDCell2
        return vc
    }
    
    func setUpUI() {
        if isMessage {
            self.selectedBarX.constant = 60
            self.commentBtn.titleLabel?.textColor = GREEN_THEME_COLOR
            self.messageBtn.titleLabel?.textColor = GREEN_THEME_COLOR_DARK
        } else {
            self.selectedBarX.constant = 0
            self.commentBtn.titleLabel?.textColor = GREEN_THEME_COLOR_DARK
            self.messageBtn.titleLabel?.textColor = GREEN_THEME_COLOR
        }
        
        speakBtn.layer.cornerRadius = 6
        speakBtn.layer.borderColor = GREEN_THEME_COLOR.CGColor
        speakBtn.layer.borderWidth = 1
    }
}


extension TDCell2 {
    
    @IBAction func commentBtnClick(sender: UIButton) {
        if isMessage {
            self.selectedBarX.constant = 0
            self.selectedBar.frame.origin.x = 60
            UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
                self.selectedBar.frame.origin.x = 0
            }) { (_) in
                self.commentBtn.titleLabel?.textColor = GREEN_THEME_COLOR_DARK
                self.messageBtn.titleLabel?.textColor = GREEN_THEME_COLOR
            }
            
            isMessage = false
        }
    }
    
    @IBAction func messageBtnClick(sender: UIButton) {
        if !isMessage {
            self.selectedBarX.constant = 60
            self.selectedBar.frame.origin.x = -60
            UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
                self.selectedBar.frame.origin.x = 0
            }) { (_) in
                self.commentBtn.titleLabel?.textColor = GREEN_THEME_COLOR
                self.messageBtn.titleLabel?.textColor = GREEN_THEME_COLOR_DARK
            }
            
            isMessage = true
        }
    }
    
    @IBAction func speakBtnClick(sender: UIButton) {
        let alerview = NewTimelineComment.alertview()
        alerview.id = self.id
        alerview.hasComment = self.hasComment
        alerview.isMessage = self.isMessage
        alerview.show()
        alerview.commentSentClosure = { comment in
            self.commentSentClosure!(comment: comment)
        }
    }
    
}