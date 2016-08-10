//
//  ViewController.swift
//  ca
//
//  Created by Ant on 16/7/12.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var containnerView: UIScrollView!
    @IBOutlet var tabLbls: [UILabel]!
    
    var selectedTab = "L" {
        didSet {
            for item in tabLbls {
                if item.text == selectedTab {
                    UIView.animateWithDuration(0.6, delay: 0, options: [.CurveEaseOut], animations: {
                        
                        item.font = UIFont(name: "FZYANS_JW--GB1-0", size: 22)
                        item.alpha = 1
                        }, completion: { (_) in
                    })
                } else {
                    UIView.animateWithDuration(0.6, delay: 0, options: [.CurveEaseOut], animations: {
                        
                        item.font = UIFont(name: "FZYANS_JW--GB1-0", size: 17)
                        item.alpha = 0.7
                        }, completion: { (_) in
                    })
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpUI()
    }
    
    func setUpUI() {
        self.selectedTab = "L"
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        
        let topBarAlpha: CGFloat = 1
        let topBarTitleFont = UIFont(name: "Didot", size: 22)
        
        // TimelineViewController
        let topBar1 = UIView()
        topBar1.backgroundColor = GREEN_THEME_COLOR
        topBar1.alpha = topBarAlpha
        topBar1.frame = CGRectMake(0, 0, screenWidth, 50)
        
        let topBarTitle1 = UILabel()
        topBarTitle1.text = "Life - timeline"
        topBarTitle1.textColor = UIColor.whiteColor()
        topBarTitle1.font = topBarTitleFont
        topBarTitle1.sizeToFit()
        topBarTitle1.frame = CGRectMake(8, 42 - topBarTitle1.frame.height, topBarTitle1.frame.width, topBarTitle1.frame.height)
        
        topBar1.addSubview(topBarTitle1)
        
        let topBarBtn1 = UIButton()
        topBarBtn1.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn1.setTitle("", forState: .Normal)
        topBarBtn1.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn1.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar1.addSubview(topBarBtn1)
        
        topBarBtn1.addTarget(self, action: #selector(HomeViewController.topBarBtn1Click(_:)), forControlEvents: .TouchUpInside)
        
        let mainContent1 = TimelineViewController.timelineViewController()
        mainContent1.view.frame = CGRectMake(0, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent1)
        self.containnerView.addSubview(topBar1)
        self.containnerView.addSubview(mainContent1.view)
        
        // BucketListViewController
        let topBar2 = UIView()
        topBar2.backgroundColor = GREEN_THEME_COLOR
        topBar2.alpha = topBarAlpha
        topBar2.frame = CGRectMake(screenWidth, 0, screenWidth, 50)
        
        let topBarTitle2 = UILabel()
        topBarTitle2.text = "Oh!!! - bucket list"
        topBarTitle2.textColor = UIColor.whiteColor()
        topBarTitle2.font = topBarTitleFont
        topBarTitle2.sizeToFit()
        topBarTitle2.frame = CGRectMake(8, 42 - topBarTitle2.frame.height, topBarTitle2.frame.width, topBarTitle2.frame.height)
        
        topBar2.addSubview(topBarTitle2)
        
        let topBarBtn2 = UIButton()
        topBarBtn2.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn2.setTitle("", forState: .Normal)
        topBarBtn2.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn2.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar2.addSubview(topBarBtn2)
        
        let mainContent2 = BucketListViewController.bucketListViewController()
        mainContent2.view.frame = CGRectMake(screenWidth, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent2)
        self.containnerView.addSubview(topBar2)
        self.containnerView.addSubview(mainContent2.view)
        
        // PlacesViewController
        let topBar3 = UIView()
        topBar3.backgroundColor = GREEN_THEME_COLOR
        topBar3.alpha = topBarAlpha
        topBar3.frame = CGRectMake(screenWidth*2, 0, screenWidth, 50)
        
        let topBarTitle3 = UILabel()
        topBarTitle3.text = "Visited - photos"
        topBarTitle3.textColor = UIColor.whiteColor()
        topBarTitle3.font = topBarTitleFont
        topBarTitle3.sizeToFit()
        topBarTitle3.frame = CGRectMake(8, 42 - topBarTitle3.frame.height, topBarTitle3.frame.width, topBarTitle3.frame.height)
        
        topBar3.addSubview(topBarTitle3)
        
        let topBarBtn3 = UIButton()
        topBarBtn3.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn3.setTitle("", forState: .Normal)
        topBarBtn3.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn3.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar3.addSubview(topBarBtn3)
        
        let mainContent3 = PlacesViewController.placesViewController()
        mainContent3.view.frame = CGRectMake(screenWidth*2, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent3)
        self.containnerView.addSubview(topBar3)
        self.containnerView.addSubview(mainContent3.view)
        
        // EventsViewController
        let topBar4 = UIView()
        topBar4.backgroundColor = GREEN_THEME_COLOR
        topBar4.alpha = topBarAlpha
        topBar4.frame = CGRectMake(screenWidth*3, 0, screenWidth, 50)
        
        let topBarTitle4 = UILabel()
        topBarTitle4.text = "Events - alerts"
        topBarTitle4.textColor = UIColor.whiteColor()
        topBarTitle4.font = topBarTitleFont
        topBarTitle4.sizeToFit()
        topBarTitle4.frame = CGRectMake(8, 42 - topBarTitle4.frame.height, topBarTitle4.frame.width, topBarTitle4.frame.height)
        
        topBar4.addSubview(topBarTitle4)
        
        let topBarBtn4 = UIButton()
        topBarBtn4.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn4.setTitle("", forState: .Normal)
        topBarBtn4.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn4.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar4.addSubview(topBarBtn4)
        
        let mainContent4 = EventsViewController.eventsViewController()
        mainContent4.view.frame = CGRectMake(screenWidth*3, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent4)
        self.containnerView.addSubview(topBar4)
        self.containnerView.addSubview(mainContent4.view)
        
        self.containnerView.delegate = self
        self.containnerView.contentSize = CGSize(width: screenWidth*4, height: screenHeight-50)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.containnerView {
            let index = Int(round(scrollView.contentOffset.x / self.view.frame.width))
            self.selectedTab = self.tabLbls[index].text!
        }
    }
    
    func topBarBtn1Click(sender: UIButton) {
        let vc = NewTimelineViewController.newTimelineViewController()
        self.presentViewController(vc, animated: true) {
        }
    }
    
    let switchTabDuration = 0.3
    @IBAction func firstTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = 0
            }) { (_) in
        }
    }
    
    @IBAction func secondTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = self.view.frame.width
        }) { (_) in
        }
    }
    
    @IBAction func thirdTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = self.view.frame.width * 2
        }) { (_) in
        }
    }

    @IBAction func fourthTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = self.view.frame.width * 3
        }) { (_) in
        }
    }
}

