//
//  TDCell0.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDCell0: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var imgCountLbl: UILabel!
    
    var displayView = UIScrollView()
    var fullScreenDisplayView = UIScrollView()
    
    let width = UIScreen.mainScreen().bounds.width - 40
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var addDisplayViewClosure: ((fullScreenDisplayView: UIScrollView)->())?
    
    var location: String?
    var photos: [String]? {
        didSet {
            if photos?.count > 0 {
                for i in 0..<photos!.count {
                    let temp = UIImageView()
                    let tempForFullScreen = UIImageView()
                    getImageByIdAndLocation(photos![i], location: location!, complete: { (image) in
                        temp.image = image
                        tempForFullScreen.image = image
                    })
                    temp.contentMode = .ScaleAspectFill
                    temp.clipsToBounds = true
                    temp.frame = CGRectMake(width * CGFloat(i) , 0, width, 160)
                    temp.backgroundColor = UIColor.clearColor()
                    
                    self.displayView.addSubview(temp)
                    
                    tempForFullScreen.contentMode = .ScaleAspectFit
                    tempForFullScreen.clipsToBounds = true
                    tempForFullScreen.frame = CGRectMake(screenWidth * CGFloat(i), 0, screenWidth, screenHeight)
                    tempForFullScreen.backgroundColor = UIColor.blackColor()
                    
                    self.fullScreenDisplayView.addSubview(tempForFullScreen)
                }
                self.displayView.contentSize = CGSizeMake(width * CGFloat(photos!.count), 160)
                self.displayView.pagingEnabled = true
                self.displayView.showsHorizontalScrollIndicator = false
                self.displayView.showsVerticalScrollIndicator = false
                self.displayView.bounces = false
                self.displayView.frame = CGRectMake(0, 85 + 1, width, 160)
                self.displayView.alpha = 1
                
                self.addSubview(displayView)
                
                self.fullScreenDisplayView.contentSize = CGSizeMake(screenWidth * CGFloat(photos!.count), screenHeight)
                self.fullScreenDisplayView.pagingEnabled = true
                self.fullScreenDisplayView.showsHorizontalScrollIndicator = false
                self.fullScreenDisplayView.showsVerticalScrollIndicator = false
                self.fullScreenDisplayView.bounces = false
                self.fullScreenDisplayView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
                self.fullScreenDisplayView.alpha = 0
                
                addDisplayViewClosure!(fullScreenDisplayView: fullScreenDisplayView)
                
                let tap1 = UITapGestureRecognizer(target: self, action: #selector(TDCell0.didClickDisplayView))
                self.displayView.addGestureRecognizer(tap1)
                
                let tap2 = UITapGestureRecognizer(target: self, action: #selector(TDCell0.didClickFullScreenDisplayView))
                self.fullScreenDisplayView.addGestureRecognizer(tap2)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.displayView.backgroundColor = UIColor.clearColor()
        self.fullScreenDisplayView.backgroundColor = UIColor.clearColor()
    }
    
    func didClickDisplayView() {
        let index = floor(self.displayView.contentOffset.x / width)
        self.fullScreenDisplayView.setContentOffset(CGPointMake(screenWidth * CGFloat(index), 0), animated: false)
        UIView.animateWithDuration(0.15, delay: 0, options: [.CurveEaseIn], animations: {
            self.fullScreenDisplayView.alpha = 1
        }) { (complete) in
        }
    }
    
    func didClickFullScreenDisplayView() {
        let index = floor(self.fullScreenDisplayView.contentOffset.x / screenWidth)
        self.displayView.setContentOffset(CGPointMake(width * CGFloat(index), 0), animated: false)
        UIView.animateWithDuration(0.15, delay: 0, options: [.CurveEaseIn], animations: {
            self.fullScreenDisplayView.alpha = 0
        }) { (complete) in
        }
    }
    
    deinit {
        self.fullScreenDisplayView.removeFromSuperview()
    }

}
