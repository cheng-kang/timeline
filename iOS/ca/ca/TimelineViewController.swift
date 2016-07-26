//
//  TimelineViewController.swift
//  ca
//
//  Created by Ant on 16/7/13.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var contentView: UIView!
    var dataForCells: [Dictionary<String, AnyObject?>] = [
        [
            "backgroundColor": PINK_THEME_COLOR,
            "icon": UIImage(named: "Two Hearts White")!,
            "cover": UIImage(named: "infrontofstone")!,
            "username": "Kang Cheng1",
            "avatar": UIImage(named: "avatar2")!,
            "type": "Event",
            "time": "3hrs",
            "location": "University of Science & Technology",
            "title": "Remember to take the pills!",
            "content": "Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": BLUE_THEME_COLOR,
            "icon": UIImage(named: "Ferris Wheel White")!,
            "cover": nil,
            "username": "Catherine2",
            "avatar": UIImage(named: "avatar1")!,
            "type": "Life",
            "time": "3days",
            "location": "Los Angeles",
            "title": "Disneyland!!!",
            "content": "I wanna go to disneyland with you!!!",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": PINK_THEME_COLOR,
            "icon": UIImage(named: "Two Hearts White")!,
            "cover": UIImage(named: "infrontofstone")!,
            "username": "Kang Cheng3",
            "avatar": UIImage(named: "avatar2")!,
            "type": "Event",
            "time": "3hrs",
            "location": "University of Science & Technology",
            "title": "Remember to take the pills!",
            "content": "Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": BLUE_THEME_COLOR,
            "icon": UIImage(named: "Ferris Wheel White")!,
            "cover": UIImage(named: "disney")!,
            "username": "Catherine4",
            "avatar": UIImage(named: "avatar1")!,
            "type": "Wish",
            "time": "3days",
            "location": "Los Angeles",
            "title": "Disneyland!!!",
            "content": "I wanna go to disneyland with you!!!",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": PINK_THEME_COLOR,
            "icon": UIImage(named: "Two Hearts White")!,
            "cover": UIImage(named: "infrontofstone")!,
            "username": "Kang Cheng5",
            "avatar": UIImage(named: "avatar2")!,
            "type": "Event",
            "time": "3hrs",
            "location": "University of Science & Technology",
            "title": "Remember to take the pills!",
            "content": "Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": BLUE_THEME_COLOR,
            "icon": UIImage(named: "Ferris Wheel White")!,
            "cover": UIImage(named: "disney")!,
            "username": "Catherine6",
            "avatar": UIImage(named: "avatar1")!,
            "type": "Wish",
            "time": "3days",
            "location": "Los Angeles",
            "title": "Disneyland!!!",
            "content": "I wanna go to disneyland with you!!!",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": PINK_THEME_COLOR,
            "icon": UIImage(named: "Two Hearts White")!,
            "cover": UIImage(named: "infrontofstone")!,
            "username": "Kang Cheng5",
            "avatar": UIImage(named: "avatar2")!,
            "type": "Event",
            "time": "3hrs",
            "location": "University of Science & Technology",
            "title": "Remember to take the pills!",
            "content": "Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
        [
            "backgroundColor": BLUE_THEME_COLOR,
            "icon": UIImage(named: "Ferris Wheel White")!,
            "cover": UIImage(named: "disney")!,
            "username": "Catherine6",
            "avatar": UIImage(named: "avatar1")!,
            "type": "Wish",
            "time": "3days",
            "location": "Los Angeles",
            "title": "Disneyland!!!",
            "content": "I wanna go to disneyland with you!!!",
            "comment": ["I love you!", "Miss you~"],
            "subtype": "Moment"
        ],
    ]
    var topCellIndex = -1 {
        didSet {
            if oldValue != topCellIndex {
//                if self.contentView.layer.anchorPoint != CGPointMake(0.5,0.5) {
//                    self.contentView.layer.anchorPoint = CGPointMake(0.5,0.5)
//                }
                self.tableview.beginUpdates()
                self.tableview.endUpdates()
                print(self.contentView.layer.anchorPoint)
                if self.contentView.layer.anchorPoint != CGPointMake(0.5,0.5) {
                    self.contentView.layer.anchorPoint = CGPointMake(0.5,0.5)
                }
//                self.contentView.layer.anchorPoint = CGPointMake(0.5,0.5)
//                self.tableview.reloadRowsAtIndexPaths([NSIndexPath(forRow: topCellIndex, inSection: 0)], withRowAnimation: .Middle)
                
                var transformComplete: (()->())?
                
                if let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: topCellIndex, inSection: 0)) as? TimelineCell {
                    
//                    let o = cell.snippetBgView.frame.origin.y
                    
                    print(cell.snippetBgView.frame.origin.y)
                    
                    if cell.originalFrame == nil {
                        cell.originalFrame = CGRectMake(cell.snippetBgView.frame.origin.x, cell.snippetBgView.frame.origin.y, cell.snippetBgView.frame.width, cell.snippetBgView.frame.height)
                    }
//                    cell.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TIMELINE == nil {
            TIMELINE = self
        }
        
        
        LEFTMENU.lifeBtnClickClosure = {
            self.presentViewController(TIMELINE!, animated: true, completion: {
                
            })
        }
        LEFTMENU.visitedBtnClickClosure = {
            self.presentViewController(PLACES, animated: true, completion: {
                
            })
        }
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.tableFooterView = UIView()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        LISTMENU.show()
        LISTMENU.momentBtnClickClosure = {
            LISTMENU.hide()
            self.performSegueWithIdentifier("TimelineToNewTimeline", sender: nil)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForCells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as! TimelineCell
        
        let cellData = dataForCells[indexPath.row]
        
        cell.initCell(cellData["username"] as! String,
                      avatarImage: cellData["avatar"] as! UIImage,
                      title: cellData["title"] as! String,
                      content: cellData["content"] as! String,
                      time: cellData["time"] as! String,
                      location: cellData["location"] as! String,
                      coverImage: cellData["cover"] as? UIImage,
                      type: cellData["type"] as! String,
                      subtype: cellData["subtype"] as! String,
                      commentCount: (cellData["comment"] as! [String]).count,
                      backgroundColor: cellData["backgroundColor"] as! UIColor,
                      icon: cellData["icon"] as! UIImage)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! TimelineCell).checkShouldFold()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row <= self.topCellIndex {
            return 186
        }
        
        return 216
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: false)
        
        let vc = TimelineDetailViewController.timelineDetailViewController()
        self.presentViewController(vc, animated: true) { 
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if self.contentView.layer.anchorPoint != CGPointMake(0.5,0.5) {
//            self.contentView.layer.anchorPoint = CGPointMake(0.5,0.5)
//        }
        
        let cellHeight = CGFloat(186)
        
        let y = scrollView.contentOffset.y
        
        print("y: \(y)")
        
        if y <= 0 {
            self.topCellIndex = -1
        } else {
            if y > CGFloat(self.topCellIndex) * cellHeight {
                self.topCellIndex = Int(y / cellHeight)
            } else {
                self.topCellIndex = self.topCellIndex - 1
            }
        }
        
        if y >= scrollView.contentSize.height - self.tableview.frame.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - self.tableview.frame.height
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            print("setset")
            self.topCellIndex = -1
        }
        
        if scrollView.contentOffset.y >= scrollView.contentSize.height - self.tableview.frame.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - self.tableview.frame.height - 5
        }
    }

}
