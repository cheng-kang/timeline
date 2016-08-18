//
//  TimelineViewController.swift
//  ca
//
//  Created by Ant on 16/7/13.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import CoreLocation
import Wilddog

class TimelineViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    // text display views
    let topView = UIView()
    let bottomView = UIView()
    let topViewLbl = UILabel()
    let bottomViewLbl = UILabel()
    var currentTimelineCount = 0
    var currentBottomViewY: CGFloat = 0
    var textDisplayViewsSet = false
    
    var dataForCells = [Timeline]()
    
    var timelineCount = 7
    
    var topCellIndex = -1 {
        didSet {
            if oldValue != topCellIndex {
                self.tableview.beginUpdates()
                self.tableview.endUpdates()
                print(self.contentView.layer.anchorPoint)
                if self.contentView.layer.anchorPoint != CGPointMake(0.5,0.5) {
                    self.contentView.layer.anchorPoint = CGPointMake(0.5,0.5)
                }
                
                var transformComplete: (()->())?
                
                if let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: topCellIndex, inSection: 0)) as? TimelineCell {
                    
                    print(cell.snippetBgView.frame.origin.y)
                    
                    if cell.originalFrame == nil {
                        cell.originalFrame = CGRectMake(cell.snippetBgView.frame.origin.x, cell.snippetBgView.frame.origin.y, cell.snippetBgView.frame.width, cell.snippetBgView.frame.height)
                    }
                    setAnchorPoint(CGPointMake(0.5,0), forView: cell.snippetBgView)
                    var transform = CATransform3DIdentity
                    transform.m34 = -1/500
                    transform = CATransform3DRotate(transform, -20 * CGFloat(M_PI) / 180, 1, 0, 0)
                    cell.snippetBgView.layer.transform = transform
                    print(cell.snippetBgView.frame.origin.y)
                    self.setAnchorPoint(CGPointMake(0.5,0.5), forView: cell.snippetBgView)
                    
                    transformComplete = {
//                        print(o)
//                        if cell.snippetBgView.frame.origin.y != 0 {
//                            cell.snippetBgView.frame.origin.y = o
//                        }
//                        cell.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0.5)
                    }
                    
                }
                
                if let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: oldValue, inSection: 0)) as? TimelineCell {
//                    let o = cell.snippetBgView.frame.origin.y
//                    cell.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0)
                    //                                        setAnchorPoint(CGPointMake(0.5,0), forView: cell.snippetBgView)
//                    cell.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0.5)
//                    self.setAnchorPoint(CGPointMake(0.5,0.5), forView: cell.snippetBgView)
                    cell.snippetBgView.layer.transform = CATransform3DIdentity
                    //                    cell.snippetBgView.frame = cell.originalFrame!
//                    self.setAnchorPoint(CGPointMake(0.5,0.5), forView: cell.snippetBgView)
                    
                    transformComplete = {
//                        if cell.snippetBgView.frame.origin.y != 0 {
//                            cell.snippetBgView.frame.origin.y = o
//                        }
//                        cell.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0.5)
//                        self.setAnchorPoint(CGPointMake(0.5,0.5), forView: cell.snippetBgView)
                    }
                }
                
                if transformComplete != nil {
                    transformComplete!()
                }
            }
            
        }
    }
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    func qiniuTest() {
        
        //        test()
        
//        let image = UIImage(named: "avatar2")
//        let imageData = UIImagePNGRepresentation(image!)
//        let filename = "avatar2.png"
//        let token = generateQiniuToken(filename)
//        
//        let upManager = QNUploadManager()
//        upManager.putData(imageData,
//                          key: filename,
//                          token: token,
//                          complete: { (info, key, resp) in
//                            print("---------------")
//                            print(info)
//                            print("---------------")
//                            print(key)
//                            print("---------------")
//                            print(resp)
//                            print("---------------")
//            },
//                          option: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.tableFooterView = UIView()
        self.tableview.cellLayoutMarginsFollowReadableWidth = false
        
        // Do any additional setup after loading the view.
        let timelineRef = Wilddog(url: SERVER+"/Timeline")
        timelineRef.queryOrderedByChild("createAt").observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value != nil {
                var tempList = [Timeline]()
                for (key, value) in (snapshot.value as! [String:AnyObject]) {
                    print(key)
                    print(value)
                    print("1")
                    let data = value as! [String:AnyObject]
                    
                    let temp = Timeline()
                    temp.id = key
                    temp.userId = data["userId"] as! String
                    temp.type = data["type"] as! String
                    temp.subtype = data["subtype"] as! String
                    temp.title = data["title"] as! String
                    temp.content = data["content"] as! String
                    temp.location = data["location"] as! String
                    temp.images = data["images"] as! [String:AnyObject]
                    temp.iconIndex = data["icon"] as! Int
                    temp.bgColorIndex = data["bgColor"] as! Int
                    temp.createAt = data["createAt"] as! String
                    temp.updateAt = data["updateAt"] as! String
                    temp.messages = data["messages"] as? [String:AnyObject]
                    temp.comments = data["comments"] as? [String:AnyObject]
                    
                    tempList.append(temp)
                }
                self.dataForCells = tempList
                self.tableview.reloadData()
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewDidAppear(animated: Bool) {
        let sb = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(0, 50, sb.width, sb.height - 100)
        if !textDisplayViewsSet {
            
            topView.frame = CGRectMake(0, -60, self.view.frame.width, 60)
            
            topViewLbl.numberOfLines = 2
            topViewLbl.textColor = THEME().textMainColor(0.8)
            topViewLbl.text = "我们在一起的 \(getDaysSinceBeginningOfRelationShip()) 天里\n记录了 ∞ 个时刻"
            topViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
            topViewLbl.frame = CGRectMake(8, 0, topView.frame.width, topView.frame.height)
            
            topView.addSubview(topViewLbl)
            self.tableview.addSubview(topView)
            
            
            let bottomViewY = self.tableview.contentSize.height > self.tableview.frame.height ? self.tableview.contentSize.height : self.tableview.frame.height
            self.currentBottomViewY = bottomViewY
            bottomView.frame = CGRectMake(0, bottomViewY, self.view.frame.width, 60)
            
            self.tableview.addSubview(bottomView)
            
            bottomViewLbl.numberOfLines = 2
            bottomViewLbl.textColor = THEME().textMainColor(0.8)
            bottomViewLbl.text = "I ❤️ U~"
            bottomViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
            bottomViewLbl.textAlignment = .Center
            bottomViewLbl.frame = CGRectMake(8, 0, bottomView.frame.width, bottomView.frame.height)
            
            bottomView.addSubview(bottomViewLbl)
            
            textDisplayViewsSet = true
        }
    }
    
    class func timelineViewController() -> TimelineViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TimelineViewController") as! TimelineViewController
        
        return vc
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuBtnClick(sender: UIButton) {
//        let menu = SideMenuView.sideMenuView(UIImage(named: "avatar1")!)
        LEFTMENU.show()
        LEFTMENU.menuDismissing = {
            
//            self.contentView.layer.anchorPoint = CGPointMake(1,1)
//            UIView.animateWithDuration(0.5) {
////                self.contentView.layer.anchorPoint = CGPointMake(1,1)
//                self.contentView.layer.transform = CATransform3DIdentity
//            }
            
            UIView.animateWithDuration(0.3, animations: {
                
                self.contentView.layer.transform = CATransform3DIdentity
                }, completion: { (complete) in
                    if complete {
                        
                        self.setAnchorPoint(CGPointMake(0.5,0.5), forView: self.contentView)
                    }
            })
        }
        
//        self.tableview.frame = CGRectMake(10, 60, self.tableview.frame.width, self.tableview.frame.height + 50)
        self.contentView.layer.anchorPoint = CGPointMake(1,1)
        self.contentView.layer.position = CGPointMake(self.view.frame.width, self.view.frame.height)
        UIView.animateWithDuration(0.25) {
            var transform = CATransform3DIdentity
            transform.m34 = -1/500
            transform = CATransform3DRotate(transform, -10 * CGFloat(M_PI) / 180, 0, 1, 0)
            self.contentView.layer.transform = transform
        }
    }
    
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForCells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as! TimelineCell
        
        let cellData = dataForCells[indexPath.row]
        
        cell.initCell("KangCheng",
                      avatarImage: UIImage(named: "avatar2")!,
                      title: cellData.title!,
                      content: cellData.content!,
                      time: cellData.timeToNow,
                      location: cellData.location!,
                      coverImage: (cellData.imageIdList?.count)! == 0 ? "" : (cellData.imageIdList?.first)!,
                      type: cellData.type!,
                      subtype: cellData.subtype!,
                      commentCount: cellData.messageList.count,
                      backgroundColor: cellData.bgColor!,
                      icon: cellData.icon!
        )
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        (cell as! TimelineCell).checkShouldFold()
        if indexPath.row > tableView.visibleCells.count - 1 {
            updateTextDisplayViews(dataForCells.count)
        }
        
        let c = cell as! TimelineCell
        
        print("snippet frame")
        print(c.snippetBgView.frame)
        print(c.snippetLeftImg.frame)
        print(c.snippetRightView.frame)
        
        c.snippetLeftImg.frame.size.width = (self.view.frame.width - 68) / 2
        
        print(cell.frame.size)
        print(self.view.frame.size)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //*
        //        if indexPath.row <= self.topCellIndex {
        //            return 186
        //        }
        
        return 216
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: false)
        
        let vc = TempViewController.tempViewController(dataForCells, index: indexPath.row)
        self.presentViewController(vc, animated: true) { 
            
        }
    }
}

extension TimelineViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //        self.tableview.reloadData()
        //        if self.contentView.layer.anchorPoint != CGPointMake(0.5,0.5) {
        //            self.contentView.layer.anchorPoint = CGPointMake(0.5,0.5)
        //        }
        
        // *
        //        let cellHeight = CGFloat(186)
        //
        //        let y = scrollView.contentOffset.y
        //
        //        print("y: \(y)")
        //
        //        if y <= 0 {
        //            self.topCellIndex = -1
        //        } else {
        //            if y > CGFloat(self.topCellIndex) * cellHeight {
        //                self.topCellIndex = Int(y / cellHeight)
        //            } else {
        //                self.topCellIndex = self.topCellIndex - 1
        //            }
        //        }
        //
        //        if y >= scrollView.contentSize.height - self.tableview.frame.height {
        //            scrollView.contentOffset.y = scrollView.contentSize.height - self.tableview.frame.height
        //        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // *
        //        if scrollView.contentOffset.y <= 0 {
        //            print("setset")
        //            self.topCellIndex = -1
        //        }
        //
        //        if scrollView.contentOffset.y >= scrollView.contentSize.height - self.tableview.frame.height {
        //            scrollView.contentOffset.y = scrollView.contentSize.height - self.tableview.frame.height - 5
        //        }
    }
}

// for text display views
extension TimelineViewController {
    func updateTextDisplayViews(timelineCount: Int) {
        if timelineCount != currentTimelineCount {
            topViewLbl.text = "我们在一起的 \(getDaysSinceBeginningOfRelationShip()) 天里\n记录了 \(timelineCount) 个时刻"
            currentTimelineCount = timelineCount
        }
        
        let bottomViewY = self.tableview.contentSize.height > self.tableview.frame.height ? self.tableview.contentSize.height : self.tableview.frame.height
        if bottomViewY != currentBottomViewY {
            bottomView.frame.origin.y = bottomViewY
            currentBottomViewY = bottomViewY
        }
    }
}