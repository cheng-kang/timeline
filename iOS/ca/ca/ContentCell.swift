//
//  ContentCell.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var containnerView: UIView!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var contentContainnerView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    
    
    
    @IBOutlet weak var contentTextViewHeightConstraint: NSLayoutConstraint!
    var contentViewHeightDif: CGFloat = 0
    
    var imgCount = 0
    var borderColor = UIColor.whiteColor().CGColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containnerView.clipsToBounds = true
        self.containnerView.layer.cornerRadius = 10
        
        self.sliderView.clipsToBounds = true
        self.sliderView.layer.cornerRadius = 10
//        self.sliderView.layer.borderWidth = 2
        
        self.locationBtn.titleLabel?.font = UIFont(name: "FZYANS_JW--GB1-0", size: 12)
        
        self.backBtn.enabled = false
    }
    
    func initCell(borderColor: UIColor, imgs: [UIImage], content: String) {
        self.containnerView.layer.borderColor = borderColor.CGColor
        self.sliderView.layer.borderColor = borderColor.CGColor
        if imgs.count > 0 {
            let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(ContentCell.pinchOnContainerView(_:)))
            self.coverImg.addGestureRecognizer(pinchGesture1)
            let pinchGesture2 = UIPinchGestureRecognizer(target: self, action: #selector(ContentCell.pinchOnSliderView(_:)))
            self.sliderView.addGestureRecognizer(pinchGesture2)
        }
        for i in 0..<imgs.count {
            let imgView = UIImageView()
            imgView.contentMode = .ScaleAspectFit
            imgView.image = imgs[i]
            // 此处使用 self.scrollView.frame.height 有问题
            imgView.frame = CGRectMake(self.scrollView.frame.width * CGFloat(i), 0, self.scrollView.frame.width, self.scrollView.frame.width)
            self.scrollView.addSubview(imgView)
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(imgs.count), self.scrollView.frame.height)
        
        self.imgCount = imgs.count
        
        self.contentTextView.text = content
        self.contentViewHeightDif = self.contentTextView.heightThatFitsContent() - self.contentTextViewHeightConstraint.constant
        self.contentTextViewHeightConstraint.constant = self.contentTextView.heightThatFitsContent()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func backBtnClick(sender: UIButton) {
//        print(self.scrollView.contentOffset.x)
        if self.scrollView.contentOffset.x <= 0 {
            // nothing would happen
        } else {
            // 不知为何有 2px 误差
            self.scrollView.contentOffset.x -= (self.scrollView.frame.width + 2)
        }
        
        if self.scrollView.contentOffset.x < self.scrollView.frame.width {
            self.backBtn.enabled = false
        } else {
            self.backBtn.enabled = true
        }
        
        self.forwardBtn.enabled = true
    }
    @IBAction func forwardBtnClick(sender: UIButton) {
//        print(self.scrollView.frame.height)
//        print(self.scrollView.contentOffset.x)
        if self.scrollView.contentOffset.x >= ((self.scrollView.frame.width + 2) * CGFloat(self.imgCount - 1)) {
            // nothing would happen
        } else {
            // 不知为何有 2px 误差
            self.scrollView.contentOffset.x += (self.scrollView.frame.width + 2)
        }
        if self.scrollView.contentOffset.x >= self.scrollView.frame.width * CGFloat(self.imgCount - 1) {
            self.forwardBtn.enabled = false
        } else {
            self.forwardBtn.enabled = true
        }
        
        self.backBtn.enabled = true
    }
    
    func pinchOnContainerView(sender: UIPinchGestureRecognizer) {
        let fullDuration = 0.8
        
        let scale = sender.scale
        
//        print("scale:container:\(scale)")
        
        self.coverImg.alpha = scale
        self.sliderView.alpha = 1 - scale
        self.containnerView.layer.borderWidth = 2 * (1 - scale)
        
        if sender.state == .Ended {
            if scale < 0.5 {
                UIView.animateWithDuration(fullDuration * Double(self.coverImg.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.coverImg.alpha = 0
                    self.sliderView.alpha = 1
                    
                    self.containnerView.layer.borderWidth = 2
                    
                    }, completion: { (complete) in
                })
            } else {
                
                UIView.animateWithDuration(fullDuration * Double(sliderView.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.coverImg.alpha = 1
                    self.sliderView.alpha = 0
                    
                    self.containnerView.layer.borderWidth = 0
                    }, completion: { (complete) in
                })
            }
        }
    }
    
    func pinchOnSliderView(sender: UIPinchGestureRecognizer) {
        let fullDuration = 0.8
        
        let scale = sender.scale
        
//        print("scale:slider:\(scale)")
        
        self.coverImg.alpha = (scale - 1) > 1 ? 1 : (scale - 1)
        self.sliderView.alpha = 1 - ((scale - 1) > 1 ? 1 : (scale - 1))
        self.containnerView.layer.borderWidth = 2 * (1 - ((scale - 1) > 1 ? 1 : (scale - 1)))
        
        if sender.state == .Ended {
            if scale > 1.5 {
                UIView.animateWithDuration(fullDuration * Double(self.sliderView.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.coverImg.alpha = 1
                    self.sliderView.alpha = 0
                    
                    self.containnerView.layer.borderWidth = 0
                    }, completion: { (complete) in
                })
            } else {
                UIView.animateWithDuration(fullDuration * Double(self.coverImg.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.coverImg.alpha = 0
                    self.sliderView.alpha = 1
                    
                    self.containnerView.layer.borderWidth = 2
                    }, completion: { (complete) in
                })
            }
        }
    }
}
