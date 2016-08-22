//
//  NewTimelineComment.swift
//  CA
//
//  Created by Ant on 16/8/19.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class NewTimelineComment: UIView {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var commentSentClosure: ((comment: TimelineComment)->())?
    
    var id: String!
    var hasComment = false
    var isMessage = false
    var selfY: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.confirmBtn.enabled  = false
        self.textview.delegate = self
        
        shadowBtn = UIButton(type: .Custom)
        shadowBtn.addTarget(self, action: #selector(NewTimelineComment.shadowBtnClick), forControlEvents: .TouchUpInside)
        shadowBtn.backgroundColor = UIColor.blackColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineComment.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineComment.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineComment.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    class func alertview() -> NewTimelineComment {
        let view = NSBundle.mainBundle().loadNibNamed("NewTimelineCommentView", owner: nil, options: nil).first as! NewTimelineComment
        
        return view
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func cancelBtnClick() {
        shadowBtnClick()
    }
    @IBAction func confirmBtnClick() {
        if isMessage {
            let tempComment = TimelineComment()
            tempComment.userId = "husband"
            tempComment.content = self.textview.text!
            tempComment.createAt = "\(NSDate().timeIntervalSince1970)"
            let ref = Wilddog(url: SERVER+"/Timeline/\(id)/messages")
            if hasComment {
                let newRef = ref.childByAutoId()
                let newData: [String:AnyObject] = [
                    "userId": "husband",
                    "content": self.textview.text!,
                    "createAt": "\(NSDate().timeIntervalSince1970)",
                    ]
                newRef.setValue(newData)
                tempComment.id = newRef.key
                commentSentClosure!(comment: tempComment)
            } else {
                ref.setValue([], withCompletionBlock: { (error, completeRef) in
                    let newRef = ref.childByAutoId()
                    let newData: [String:AnyObject] = [
                        "userId": "husband",
                        "content": self.textview.text!,
                        "createAt": "\(NSDate().timeIntervalSince1970)",
                    ]
                    newRef.setValue(newData)
                    tempComment.id = newRef.key
                    self.commentSentClosure!(comment: tempComment)
                })
            }
        } else {
            let tempComment = TimelineComment()
            tempComment.userId = "husband"
            tempComment.content = self.textview.text!
            tempComment.createAt = "\(NSDate().timeIntervalSince1970)"
            let ref = Wilddog(url: SERVER+"/Timeline/\(id)/comments")
            if hasComment {
                let newRef = ref.childByAutoId()
                let newData: [String:AnyObject] = [
                    "userId": "husband",
                    "content": self.textview.text!,
                    "createAt": "\(NSDate().timeIntervalSince1970)",
                    ]
                newRef.setValue(newData)
                tempComment.id = newRef.key
                self.commentSentClosure!(comment: tempComment)
            } else {
                ref.setValue([], withCompletionBlock: { (error, completeRef) in
                    let newRef = ref.childByAutoId()
                    let newData: [String:AnyObject] = [
                        "userId": "husband",
                        "content": self.textview.text!,
                        "createAt": "\(NSDate().timeIntervalSince1970)",
                    ]
                    newRef.setValue(newData)
                    tempComment.id = newRef.key
                    self.commentSentClosure!(comment: tempComment)
                })
            }
        }
        shadowBtnClick()
    }
    
    
    
    let ApplicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var showView: UIView {
        return ApplicationDelegate.window!
    }
    
    private var shadowBtn: UIButton!
    func show() {
        
        let size = UIScreen.mainScreen().bounds.size
        self.shadowBtn.center = CGPoint(x: size.width/2, y: size.height/2)
        self.shadowBtn.frame = self.showView.bounds
        self.shadowBtn.alpha = 0
        self.alpha = 0
        
        let width = size.width - 40
        self.frame.size = CGSizeMake(width, width * 0.8)
        self.center = self.shadowBtn.center
        
        self.selfY = self.frame.origin.y
        
        self.transform = CGAffineTransformMakeScale(1.2, 1.2)
        
        
        UIView.animateWithDuration(0.25) {
            
            self.shadowBtn.alpha = 0.4
            self.showView.addSubview(self.shadowBtn)
            
            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .CurveEaseInOut, animations: {
                self.showView.addSubview(self)
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                
                self.alpha = 1
                }, completion: { (_) in
                    self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.showView.addSubview(self)
                    self.alpha = 1
            })
        }
    }
    
    @objc private func shadowBtnClick() {
        
        UIView.animateWithDuration(0.15, animations: {
            self.shadowBtn.alpha = 0
            self.alpha = 0
        }) { (success) in
            self.shadowBtn.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
}

extension NewTimelineComment: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        self.confirmBtn.enabled = textView.hasText()
    }
}

// keyboard events
extension NewTimelineComment {
    func keyboardWillShow(notification: NSNotification) {
        
        self.frame = CGRectMake(20, self.selfY - 60, self.frame.width, self.frame.height)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        
        UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseOut], animations: {
            self.frame = CGRectMake(20, self.selfY - 60, self.frame.width, self.frame.height)
        }) { (complete) in
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            self.frame = CGRectMake(20, self.selfY, self.frame.width, self.frame.height)
        }) { (complete) in
        }
    }
}


