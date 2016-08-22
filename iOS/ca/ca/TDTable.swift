//
//  TDTable.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDTable: UITableView {
    
    let tableViewController = TDTableViewController()
    var data: Timeline! {
        didSet {
            tableViewController.data = data
        }
    }
    var currentIndex = 0
    var timelineCount = 0
    
    let pullToLoadTopView = PullToLoadView()
    let pullToLoadBottomView = PullToLoadView()
    let refreshControl = UIRefreshControl()
    
    var reloadDataClosure: (()->())?
    var didPullClosure: ((isUp: Bool)->())?
    var addDisplayViewClosure: ((fullScreenDisplayView: UIScrollView)->())?
    
    class func tableview(data: Timeline, currentIndex: Int, timelineCount: Int) -> TDTable {
        
        let vc = NSBundle.mainBundle().loadNibNamed("TDTable", owner: nil, options: nil).first as! TDTable
        vc.data = data
        vc.timelineCount = timelineCount
        vc.currentIndex = currentIndex
        vc.tableViewController.timelineCount = timelineCount
        vc.tableViewController.currentIndex = currentIndex
        return vc
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = tableViewController
        self.dataSource = tableViewController
        
        refreshControl.alpha = 0
        
        self.addSubview(refreshControl)
        
        tableViewController.currentIndex = self.currentIndex
        tableViewController.timelineCount = self.timelineCount
        tableViewController.reloadDataClosure = {
            self.reloadData()
            self.reloadDataClosure!()
        }
        tableViewController.didPullClosure = { isUp in
            self.didPullClosure!(isUp: isUp)
        }
        tableViewController.addDisplayViewClosure = { fullScreenDisplayView in
            self.addDisplayViewClosure!(fullScreenDisplayView: fullScreenDisplayView)
        }
        
        self.registerNib(UINib(nibName: "TDCell0", bundle: nil), forCellReuseIdentifier: "TDCell0")
        self.registerNib(UINib(nibName: "TDCell1", bundle: nil), forCellReuseIdentifier: "TDCell1")
        self.registerNib(UINib(nibName: "TDCell3", bundle: nil), forCellReuseIdentifier: "TDCell3")
    }

}
