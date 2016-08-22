//
//  TempViewController.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class TempViewController: UIViewController {
    
    @IBOutlet weak var navBar: UIView!
    
    var timelineList: [Timeline]!
    var currentIndex = 0
    var isMessage = true
    
    var currentTableView: TDTable!
    
    let refreshControl = UIRefreshControl()
    let pullToLoadViewHeight: CGFloat = 60
    let pullToLoadViewIconHeight: CGFloat = 18
    var hasNew = false
    var isUp = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.alpha = 0
        
        initTableView()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    class func tempViewController(timelineList: [Timeline],index: Int) -> TempViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TempViewController") as! TempViewController
        
        vc.timelineList = timelineList
        vc.currentIndex = index
        //        vc.currentData = vc.dataForCell
        
        return vc
    }
    
    
    func initTableView() {
        let newTableView = TDTable.tableview(self.timelineList[currentIndex], currentIndex: currentIndex, timelineCount: timelineList.count)
        newTableView.tag = 1
        
        newTableView.frame = CGRectMake(20, 50, self.view.frame.width - 40, self.view.frame.height - 50)
        
        self.view.insertSubview(newTableView, belowSubview: navBar)
        
        
        self.currentTableView = newTableView
        self.currentTableView.reloadData()
        
        newTableView.addSubview(newTableView.pullToLoadTopView)
        newTableView.addSubview(newTableView.pullToLoadBottomView)
        
        newTableView.didPullClosure = { isUp in
            self.didPull(isUp)
        }
        newTableView.addDisplayViewClosure = { fullScreenDisplayView in
            self.view.addSubview(fullScreenDisplayView)
        }
        
        let superViewWidth = newTableView.frame.width
        let superViewHeight = newTableView.frame.height > newTableView.contentSize.height ? newTableView.frame.height : newTableView.contentSize.height
        newTableView.pullToLoadTopView.initView(true,
                                                superViewWidth: superViewWidth,
                                                superViewHeight: superViewHeight)
        newTableView.pullToLoadBottomView.initView(false,
                                                   superViewWidth: superViewWidth,
                                                   superViewHeight: superViewHeight)
    }

}

extension TempViewController {
    
    func pullToLoadView(isUp: Bool) {
        let view = UIView()
        let icon = UIImageView()
        if isUp {
            let iconImage = UIImage(named: "Circled Up")!
            icon.image = iconImage.imageWithRenderingMode(.AlwaysTemplate)
        } else {
            let iconImage = UIImage(named: "Circled Up")!
            icon.image = iconImage.imageWithRenderingMode(.AlwaysTemplate)
        }
        icon.tintColor = GREEN_THEME_COLOR
        icon.frame.size = CGSizeMake(18, 18)
        icon.center = view.center
        
        view.addSubview(icon)
    }
    
    func didPull(isUp: Bool) {
        if self.currentTableView.refreshControl.refreshing {
            
            self.hasNew = true
            self.isUp = isUp
            
            self.currentTableView.refreshControl.endRefreshing()
            
            let currentTableViewHeight = self.currentTableView.frame.height
            let currentTableViewWidth = self.currentTableView.frame.width
            let currentTableViewY = self.currentTableView.frame.origin.y
            
            
            let newTableView = TDTable.tableview(self.isUp ? self.timelineList[currentIndex-1] : self.timelineList[currentIndex+1], currentIndex: self.isUp ? currentIndex-1 : currentIndex+1,  timelineCount: timelineList.count)
            newTableView.tag = 2
            newTableView.alpha = 0
            
            newTableView.frame = isUp ? CGRectMake(20, -currentTableViewHeight + currentTableViewY , currentTableViewWidth, currentTableViewHeight) : CGRectMake(20, currentTableViewY + currentTableViewHeight, currentTableViewWidth, currentTableViewHeight)
            
            self.view.insertSubview(newTableView, belowSubview: navBar)
            
            newTableView.addSubview(newTableView.pullToLoadTopView)
            newTableView.addSubview(newTableView.pullToLoadBottomView)
            
            newTableView.didPullClosure = { isUp in
                self.didPull(isUp)
            }
            newTableView.addDisplayViewClosure = { fullScreenDisplayView in
                self.view.addSubview(fullScreenDisplayView)
            }
            
            let superViewWidth = newTableView.frame.width
            let superViewHeight = newTableView.frame.height > newTableView.contentSize.height ? newTableView.frame.height : newTableView.contentSize.height
            newTableView.pullToLoadTopView.initView(true,
                                                    superViewWidth: superViewWidth,
                                                    superViewHeight: superViewHeight)
            newTableView.pullToLoadBottomView.initView(false,
                                                       superViewWidth: superViewWidth,
                                                       superViewHeight: superViewHeight)
            
            
            let targetNewTableViewCenter = CGPointMake(self.currentTableView.center.x, self.currentTableView.center.y)
            let targetCurrentTableViewCenter = isUp ? CGPointMake(self.currentTableView.center.x, self.currentTableView.center.y + currentTableViewHeight) : CGPointMake(self.currentTableView.center.x, self.currentTableView.center.y - currentTableViewHeight)
            
            let duration = 0.7
            UIView.animateWithDuration(duration, delay: 0, options: [.CurveEaseOut], animations: {
                newTableView.center = targetNewTableViewCenter
                newTableView.alpha = 1
                self.currentTableView.center = targetCurrentTableViewCenter
                }, completion: { (_) in
            })
            
            NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: #selector(TempViewController.didFinishPull(_:)), userInfo: ["newTableView": newTableView], repeats: false)
        }
    }
    
    func didFinishPull(sender: NSTimer) {
        let newTableView = (sender.userInfo as! Dictionary<String, AnyObject>)["newTableView"] as! TDTable
        self.currentTableView.delegate = nil
        self.currentTableView.dataSource = nil
        self.currentTableView.removeFromSuperview()
        self.currentTableView = nil
        self.currentTableView = newTableView
        self.currentTableView.tag = 1
        
        self.currentIndex = self.currentIndex + (isUp ? -1 : 1)
        
        self.hasNew = false
    }
}

extension TempViewController {
    
    @IBAction func dismissBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { 
        }
    }
}

