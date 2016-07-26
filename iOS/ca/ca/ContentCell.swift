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
    
    var imgCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containnerView.clipsToBounds = true
        self.containnerView.layer.cornerRadius = 10
        
        self.sliderView.clipsToBounds = true
        self.sliderView.layer.cornerRadius = 10
        self.sliderView.layer.borderWidth = 2
        
        self.backBtn.enabled = false
        
        let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(ContentCell.pinchOnContainerView(_:)))
        self.containnerView.addGestureRecognizer(pinchGesture1)
        let pinchGesture2 = UIPinchGestureRecognizer(target: self, action: #selector(ContentCell.pinchOnSliderView(_:)))
        self.sliderView.addGestureRecognizer(pinchGesture2)
    }
    
    func initCell(borderColor: UIColor, imgs: [UIImage]) {
        self.sliderView.layer.borderColor = borderColor.CGColor
        
        
        for i in 0..<imgs.count {
            print(i)
            let imgView = UIImageView()
            imgView.contentMode = .ScaleAspectFit
            imgView.image = imgs[i]
            imgView.frame = CGRectMake(self.scrollView.frame.width * CGFloat(i), 0, self.scrollView.frame.width, self.scrollView.frame.height)
            self.scrollView.addSubview(imgView)
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(imgs.count), self.scrollView.frame.height)
        
        self.imgCount = imgs.count
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func backBtnClick(sender: UIButton) {
        print(self.scrollView.contentOffset.x)
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
        print(self.scrollView.contentOffset.x)
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
        
        print("scale:container:\(scale)")
        
        self.containnerView.alpha = scale
        self.sliderView.alpha = 1 - scale
        
        if sender.state == .Ended {
            if scale < 0.5 {
                UIView.animateWithDuration(fullDuration * Double(self.containnerView.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.containnerView.alpha = 0
                    self.sliderView.alpha = 1
                    }, completion: { (complete) in
                })
            } else {
                
                UIView.animateWithDuration(fullDuration * Double(sliderView.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.containnerView.alpha = 1
                    self.sliderView.alpha = 0
                    }, completion: { (complete) in
                })
            }
        }
    }
    
    func pinchOnSliderView(sender: UIPinchGestureRecognizer) {
        let fullDuration = 0.8
        
        let scale = sender.scale
        
        print("scale:slider:\(scale)")
        
        self.containnerView.alpha = (scale - 1) > 1 ? 1 : (scale - 1)
        self.sliderView.alpha = 1 - ((scale - 1) > 1 ? 1 : (scale - 1))
        
        if sender.state == .Ended {
            if scale > 1.5 {
                UIView.animateWithDuration(fullDuration * Double(self.sliderView.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.containnerView.alpha = 1
                    self.sliderView.alpha = 0
                    }, completion: { (complete) in
                })
            } else {
                UIView.animateWithDuration(fullDuration * Double(self.containnerView.alpha), delay: 0, options: [.CurveEaseOut], animations: {
                    self.containnerView.alpha = 0
                    self.sliderView.alpha = 1
                    }, completion: { (complete) in
                })
            }
        }
    }
}
