//
//  EventDetailView.swift
//  CA
//
//  Created by Ant on 16/7/29.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class EventDetailView: UIView {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var timeTipLbl: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var alarmBtn: UIButton!
    
    var event: Event!
    var isCountDown = false {
        didSet {
            if isCountDown {
                self.timeLbl.text = event.alarmCountDown
                self.timeTipLbl.text = "TIME LEFT"
            } else {
                self.timeLbl.text = event.alarmTime
                self.timeTipLbl.text = "ALARM AT"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.layer.borderColor = THEME().textMainColor(0.8).CGColor
        self.cardView.layer.borderWidth = 3
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EventDetailView.switchTimeTipLbl(_:)))
//        self.timeLbl.addGestureRecognizer(tapGesture)
//        
        shadowBtn = UIButton(type: .Custom)
        shadowBtn.addTarget(self, action: #selector(EventDetailView.shadowBtnClick), forControlEvents: .TouchUpInside)
        shadowBtn.backgroundColor = UIColor.blackColor()
    }
    
    func initView(event: Event) {
        self.event = event
        self.dateLbl.text = event.alarmDate
        
        isCountDown = false
        
        self.contentTextView.text = event.content
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(EventDetailView.updateCountDownText), userInfo: nil, repeats: true)
    }
    
    func updateCountDownText() {
        if isCountDown {
            self.timeLbl.text = event.alarmCountDown
        }
    }
    
    class func eventDetailView(event: Event) -> EventDetailView {
        let view = NSBundle.mainBundle().loadNibNamed("EventDetailView", owner: nil, options: nil).first as! EventDetailView
        
        view.initView(event)
        
        return view
    }
    
    @IBAction func switchTimeTipLbl(sender: UILabel) {
        self.isCountDown = !self.isCountDown
    }
    
    @IBAction func alarmBtnClick(sender: UIButton) {
        
    }
    
    let ApplicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var showView: UIView {
        return ApplicationDelegate.window!
    }
    
    private var shadowBtn: UIButton!
    
    func show() {
        
        let size = UIScreen.mainScreen().bounds.size
        self.shadowBtn.center = CGPoint(x: size.width/2, y: size.height/2)
        self.center = self.shadowBtn.center
        self.shadowBtn.frame = self.showView.bounds
        self.shadowBtn.alpha = 0
        self.alpha = 0
        
        
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
