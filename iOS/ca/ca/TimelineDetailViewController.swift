//
//  TimelineDetailViewController.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class TimelineDetailViewController: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var currentTableView: UITableView!
    
    var tableviewHeight: CGFloat = 0
    var commentViewY: CGFloat = 0
    
    var contentCellDif: CGFloat = 0
    
    var lastScrollViewOffsetY: CGFloat = 0
    
    let refreshControl = UIRefreshControl()
    let upView = PullToLoadView()
    let downView = PullToLoadView()
    let pullToLoadViewHeight: CGFloat = 60
    let pullToLoadViewIconHeight: CGFloat = 18
    
    var currentIndex = 0
    var timelineList = [Timeline]()
    
    var dataForCell: Dictionary<String, AnyObject?> = [
        "backgroundColor": PINK_THEME_COLOR,
        "icon": UIImage(named: "Two Hearts White")!,
        "cover": UIImage(named: "infrontofstone")!,
        "username": "Kang Cheng",
        "avatar": UIImage(named: "avatar2")!,
        "type": "Event",
        "time": "17:32",
        "date": "23/May/2016",
        "location": "University of Science & Technology",
        "title": "Remember to take the pills!",
        "content": "在学校一起拍照片了！！！开心~~宝贝我爱你！~耶！！！✌️Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
        "images": [
            UIImage(named: "infrontofstone")!,
            UIImage(named: "kiss")!,
            UIImage(named: "3")!,
            UIImage(named: "avatar1")!,
            UIImage(named: "disney")!,
        ],
        "messages": [
            [
                "username": "Kang Cheng",
                "avatar": UIImage(named: "avatar2")!,
                "content": "I love you so much!!!",
                "time": "17:32",
                "date": "23/May/2016"
            ],
            [
                "username": "Catherine",
                "avatar": UIImage(named: "avatar1")!,
                "content": "Me too!!!~",
                "time": "17:33",
                "date": "23/May/2016"
            ],
            [
                "username": "Kang Cheng",
                "avatar": UIImage(named: "avatar2")!,
                "content": "Ohhhhhhhh~",
                "time": "17:33",
                "date": "23/May/2016"
            ],
        ],
        "comments": [
            [
                "username": "Carrie",
                "content": "You are so nice!",
                "time": "17:32",
                "date": "23/May/2016"
            ],
            [
                "username": "Someone",
                "content": "Wowowowow!!!",
                "time": "17:33",
                "date": "23/May/2016"
            ],
        ],
        "subtype": "Moment"
    ]
    var dataForCell1: Dictionary<String, AnyObject?> = [
        "backgroundColor": BLUE_THEME_COLOR,
        "icon": UIImage(named: "Two Hearts White")!,
        "cover": UIImage(named: "disney")!,
        "username": "Kang Cheng",
        "avatar": UIImage(named: "avatar2")!,
        "type": "Event",
        "time": "17:32",
        "date": "23/May/2016",
        "location": "University of Science & Technology",
        "title": "Remember to take the pills!",
        "content": "Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
        "images": [
            UIImage(named: "infrontofstone")!,
            UIImage(named: "kiss")!,
            UIImage(named: "3")!,
            UIImage(named: "avatar1")!,
            UIImage(named: "disney")!,
        ],
        "messages": [
            [
                "username": "Kang Cheng",
                "avatar": UIImage(named: "avatar2")!,
                "content": "I love you so much!!!",
                "time": "17:32",
                "date": "23/May/2016"
            ],
            [
                "username": "Catherine",
                "avatar": UIImage(named: "avatar1")!,
                "content": "Me too!!!~",
                "time": "17:33",
                "date": "23/May/2016"
            ],
            [
                "username": "Kang Cheng",
                "avatar": UIImage(named: "avatar2")!,
                "content": "Ohhhhhhhh~",
                "time": "17:33",
                "date": "23/May/2016"
            ],
        ],
        "comments": [
            [
                "username": "Carrie",
                "content": "You are so nice!",
                "time": "17:32",
                "date": "23/May/2016"
            ],
            [
                "username": "Someone",
                "content": "Wowowowow!!!",
                "time": "17:33",
                "date": "23/May/2016"
            ],
        ],
        "subtype": "Moment"
    ]
    
    var dataForCell2: Dictionary<String, AnyObject?> = [
        "backgroundColor": BLUE_THEME_COLOR,
        "icon": UIImage(named: "Two Hearts White")!,
        "cover": UIImage(named: "kiss")!,
        "username": "Kang Cheng",
        "avatar": UIImage(named: "avatar2")!,
        "type": "Event",
        "time": "17:32",
        "date": "23/May/2016",
        "location": "University of Science & Technology",
        "title": "Remember to take the pills!",
        "content": "Had a great morning at USTB!!! 😘😘😘I love you sooooooo much!!! Hope to see you again soon~",
        "images": [
            UIImage(named: "infrontofstone")!,
            UIImage(named: "kiss")!,
            UIImage(named: "3")!,
            UIImage(named: "avatar1")!,
            UIImage(named: "disney")!,
        ],
        "messages": [
            [
                "username": "Kang Cheng",
                "avatar": UIImage(named: "avatar2")!,
                "content": "I love you so much!!!",
                "time": "17:32",
                "date": "23/May/2016"
            ],
            [
                "username": "Catherine",
                "avatar": UIImage(named: "avatar1")!,
                "content": "Me too!!!~",
                "time": "17:33",
                "date": "23/May/2016"
            ],
            [
                "username": "Kang Cheng",
                "avatar": UIImage(named: "avatar2")!,
                "content": "Ohhhhhhhh~",
                "time": "17:33",
                "date": "23/May/2016"
            ],
        ],
        "comments": [
            [
                "username": "Carrie",
                "content": "You are so nice!",
                "time": "17:32",
                "date": "23/May/2016"
            ],
            [
                "username": "Someone",
                "content": "Wowowowow!!!",
                "time": "17:33",
                "date": "23/May/2016"
            ],
        ],
        "subtype": "Moment"
    ]
    
    var currentData: Dictionary<String, AnyObject?>? {
        didSet {
//            if oldValue != nil {
//                if let tableview = self.currentTableView {
//                    self.currentTableView.reloadData()
//                }
//            }
            
            getPrevAndNextData()
        }
    }
    var prevData: Dictionary<String, AnyObject?>?
    var nextData: Dictionary<String, AnyObject?>?
    
    func getPrevAndNextData() {
        // get prev data
        prevData = dataForCell1
        
        // get next data
        nextData = dataForCell2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimelineDetailViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimelineDetailViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimelineDetailViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(TimelineDetailViewController.handleSwipeGesture(_:)))
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.Down //不设置是右
        self.view.addGestureRecognizer(swipeDownGesture)
        
    }
    
    func initTableView() {
        
        self.navBarView.backgroundColor = timelineList[currentIndex].bgColor
        
        let newTableView = UITableView()
        newTableView.tag = 1
        newTableView.tableFooterView = UIView()
        newTableView.separatorStyle = .None
        newTableView.allowsSelection = false
        newTableView.showsVerticalScrollIndicator = false
        newTableView.showsHorizontalScrollIndicator = false
        newTableView.keyboardDismissMode = .Interactive
        
        newTableView.dataSource = self
        newTableView.delegate = self
        
        newTableView.registerNib(UINib(nibName: "TopCell", bundle: nil), forCellReuseIdentifier: "TopCell")
        newTableView.registerNib(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "ContentCell")
        newTableView.registerNib(UINib(nibName: "LoverCell", bundle: nil), forCellReuseIdentifier: "LoverCell")
        newTableView.registerNib(UINib(nibName: "MeCell", bundle: nil), forCellReuseIdentifier: "MeCell")
        newTableView.registerNib(UINib(nibName: "CommentTopCell", bundle: nil), forCellReuseIdentifier: "CommentTopCell")
        newTableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        newTableView.registerNib(UINib(nibName: "CommentBottomCell", bundle: nil), forCellReuseIdentifier: "CommentBottomCell")
        
        newTableView.frame = CGRectMake(0, self.navBarView.frame.height, self.view.frame.width, self.view.frame.height - self.navBarView.frame.height - self.commentView.frame.height)
        
        self.view.addSubview(newTableView)
        self.view.sendSubviewToBack(newTableView)
        
        self.currentTableView = newTableView
    }
    
    override func viewWillAppear(animated: Bool) {
        self.sendBtn.setTitleColor(self.timelineList[currentIndex].bgColor, forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableviewHeight = self.currentTableView.frame.height
        self.commentViewY = self.commentView.frame.origin.y
        
        self.currentTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .None)
        self.upView.updateFrame(pullToLoadViewHeight, superViewWidth: self.currentTableView.frame.width, superViewHeight: self.currentTableView.contentSize.height)
        self.downView.updateFrame(pullToLoadViewHeight, superViewWidth: self.currentTableView.frame.width, superViewHeight: self.currentTableView.contentSize.height)
        
//        self.currentTableView.beginUpdates()
//        self.currentTableView.endUpdates()
        
        self.setPullToLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    class func timelineDetailViewController(timelineList: [Timeline],index: Int) -> TimelineDetailViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TimelineDetailViewController") as! TimelineDetailViewController
        
        vc.timelineList = timelineList
        vc.currentIndex = index
//        vc.currentData = vc.dataForCell
        
        return vc
    }
    
    func setPullToLoad() {
        self.currentTableView.endUpdates()
        self.upView.initView(true,
                             viewHeight: pullToLoadViewHeight,
                             superViewWidth: self.view.frame.width,
                             superViewHeight: self.view.frame.height,
                             iconHeight: pullToLoadViewIconHeight,
                             iconTintColor: (self.timelineList[currentIndex].bgColor)!
        )
        self.downView.initView(false,
                             viewHeight: pullToLoadViewHeight,
                             superViewWidth: self.view.frame.width,
                             superViewHeight: self.currentTableView.contentSize.height,
                             iconHeight: pullToLoadViewIconHeight,
                             iconTintColor: (self.timelineList[currentIndex].bgColor)!
        )
        self.currentTableView.addSubview(upView)
        self.currentTableView.addSubview(downView)
        
        self.refreshControl.alpha = 0
//        self.refreshControl.addTarget(self, action: #selector(TimelineDetailViewController.didRefresh(_:)), forControlEvents: .ValueChanged)
        self.currentTableView.addSubview(self.refreshControl)
        self.currentTableView.sendSubviewToBack(self.refreshControl)
    }
    
    var hasNew = false
    var isUp = true
    func didPull(isUp: Bool) {
        if self.refreshControl.refreshing {
            
            self.hasNew = true
            self.isUp = isUp
            
            self.refreshControl.endRefreshing()
            
            let currentTableViewHeight = self.currentTableView.frame.height
            let currentTableViewWidth = self.currentTableView.frame.width
            let currentTableViewY = self.currentTableView.frame.origin.y
            
            let newTableViewController = TimelineDetailTableViewController()
            newTableViewController.dataForCell = self.isUp ? self.timelineList[currentIndex-1] : self.timelineList[currentIndex+1]
            
            let newTableView = UITableView()
            newTableView.tag = 2
            newTableView.tableFooterView = UIView()
            newTableView.separatorStyle = .None
            newTableView.allowsSelection = false
            newTableView.showsVerticalScrollIndicator = false
            newTableView.showsHorizontalScrollIndicator = false
            newTableView.keyboardDismissMode = .Interactive
            
            newTableView.dataSource = self
            newTableView.delegate = self
            
            newTableView.registerNib(UINib(nibName: "TopCell", bundle: nil), forCellReuseIdentifier: "TopCell")
            newTableView.registerNib(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "ContentCell")
            newTableView.registerNib(UINib(nibName: "LoverCell", bundle: nil), forCellReuseIdentifier: "LoverCell")
            newTableView.registerNib(UINib(nibName: "MeCell", bundle: nil), forCellReuseIdentifier: "MeCell")
            newTableView.registerNib(UINib(nibName: "CommentTopCell", bundle: nil), forCellReuseIdentifier: "CommentTopCell")
            newTableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
            newTableView.registerNib(UINib(nibName: "CommentBottomCell", bundle: nil), forCellReuseIdentifier: "CommentBottomCell")
            
            newTableView.frame = isUp ? CGRectMake(0, -currentTableViewHeight, currentTableViewWidth, currentTableViewHeight) : CGRectMake(0, currentTableViewY + currentTableViewHeight, currentTableViewWidth, currentTableViewHeight)
            newTableView.alpha = 0
            
            self.view.addSubview(newTableView)
            self.view.sendSubviewToBack(newTableView)
            
            let targetNewTableViewCenter = CGPointMake(self.currentTableView.center.x, self.currentTableView.center.y)
            let targetCurrentTableViewCenter = isUp ? CGPointMake(self.currentTableView.center.x, self.currentTableView.center.y + currentTableViewHeight) : CGPointMake(self.currentTableView.center.x, self.currentTableView.center.y - currentTableViewHeight)
            
            let duration = 0.7
            UIView.animateWithDuration(duration, delay: 0, options: [.CurveEaseOut], animations: {
                let bgColor = newTableViewController.dataForCell.bgColor
                self.navBarView.backgroundColor = bgColor
                
                newTableView.center = targetNewTableViewCenter
                newTableView.alpha = 1
                self.currentTableView.center = targetCurrentTableViewCenter
                }, completion: { (_) in
            })
            
            let timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: #selector(TimelineDetailViewController.didFinishPull(_:)), userInfo: ["newTableView": newTableView], repeats: false)
        }
    }
    
    func didFinishPull(sender: NSTimer) {
        let newTableView = (sender.userInfo as! Dictionary<String, AnyObject>)["newTableView"] as! UITableView
        self.currentTableView.delegate = nil
        self.currentTableView.dataSource = nil
        self.currentTableView.removeFromSuperview()
        self.currentTableView = nil
        self.currentTableView = newTableView
        self.currentTableView.tag = 1
        
//        self.currentData = isUp ? prevData : nextData
        self.currentIndex = self.currentIndex + (isUp ? -1 : 1)
        
        self.hasNew = false
        
        self.setPullToLoad()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(keyboardHeight)
        
        self.currentTableView.frame = CGRectMake(0, self.currentTableView.frame.origin.y, self.currentTableView.frame.width, self.tableviewHeight - keyboardHeight)
        self.commentView.frame = CGRectMake(0, self.commentViewY - keyboardHeight, self.commentView.frame.width, self.commentView.frame.height)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(keyboardHeight)
        
        UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseOut], animations: {
            self.currentTableView.frame = CGRectMake(0, self.currentTableView.frame.origin.y, self.currentTableView.frame.width, self.tableviewHeight - keyboardHeight)
            self.commentView.frame = CGRectMake(0, self.commentViewY - keyboardHeight, self.commentView.frame.width, self.commentView.frame.height)
        }) { (complete) in
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(keyboardHeight)
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            self.currentTableView.frame = CGRectMake(0, self.currentTableView.frame.origin.y, self.currentTableView.frame.width, self.tableviewHeight)
            self.commentView.frame = CGRectMake(0, self.commentViewY, self.commentView.frame.width, self.commentView.frame.height)
        }) { (complete) in
        }
    }
    
    func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        //判断是上下左右
        switch (direction){
        case UISwipeGestureRecognizerDirection.Left:
            print("Left")
            break
        case UISwipeGestureRecognizerDirection.Right:
            print("Right")
            break
        case UISwipeGestureRecognizerDirection.Up:
            print("Up")
            break
        case UISwipeGestureRecognizerDirection.Down:
            print("Down")
            self.view.endEditing(true)
            break
        default:
            break;
        }
    }
    
    @IBAction func dismissBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendBtnClick() {
        let content = self.textField.text!
        self.textField.text = ""
        self.view.endEditing(true)
        let ref = Wilddog(url: SERVER+"/Timeline/\(timelineList[currentIndex].id ?? "")/messages")
        if timelineList[currentIndex].messageList.count == 0 {
            ref.setValue([], withCompletionBlock: { (error, completeRef) in
                
                let newMsgRef = completeRef.childByAutoId()
                let newMsg: [String:AnyObject] = [
                    "userId": "husband",
                    "content": content,
                    "createAt": "\(NSDate().timeIntervalSince1970)"
                ]
                
                newMsgRef.setValue(newMsg)
                
                let temp = TimelineComment()
                temp.id = "\(newMsgRef.key)"
                temp.userId = "husband"
                temp.content = content
                temp.createAt = "\(NSDate().timeIntervalSince1970)"
                self.timelineList[self.currentIndex].messageList.append(temp)
                self.currentTableView.reloadData()
                
            })
        } else {
            
            let newMsgRef = ref.childByAutoId()
            let newMsg: [String:AnyObject] = [
                "userId": "husband",
                "content": content,
                "createAt": "\(NSDate().timeIntervalSince1970)"
            ]
            
            newMsgRef.setValue(newMsg)
            
            let temp = TimelineComment()
            temp.id = "\(newMsgRef.key)"
            temp.userId = "husband"
            temp.content = content
            temp.createAt = "\(NSDate().timeIntervalSince1970)"
            self.timelineList[self.currentIndex].messageList.append(temp)
            self.currentTableView.reloadData()
        }
    }

    
    var isFullScreen = false
    let animateFullScreenDuration = 0.3
    
    var justEnter = false
    func enterFullScreen() {
        if !isFullScreen && justEnter {
            let navVarViewCenter = CGPointMake(self.navBarView.center.x, self.navBarView.center.y - self.navBarView.frame.height)
            let commentViewCenter = CGPointMake(self.commentView.center.x, self.commentView.center.y + self.commentView.frame.height)
            let tableviewBounds = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            let tableviewCenter = CGPointMake(self.view.center.x, self.view.center.y)
            self.currentTableView.frame.height
            UIView.animateWithDuration(animateFullScreenDuration, delay: 0, options: [.CurveEaseOut], animations: {
                self.navBarView.center = navVarViewCenter
                self.commentView.center = commentViewCenter
                self.currentTableView.bounds = tableviewBounds
                self.currentTableView.center = tableviewCenter
                }, completion: { (_) in
            })
            
            isFullScreen = true
        }
        justEnter = true
    }
    
    func exitFullScreen() {
        if isFullScreen && !justEnter {
            let navVarViewCenter = CGPointMake(self.navBarView.center.x, self.navBarView.center.y + self.navBarView.frame.height)
            let commentViewCenter = CGPointMake(self.commentView.center.x, self.commentView.center.y - self.commentView.frame.height)
            let tableviewBounds = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - self.navBarView.frame.height - self.commentView.frame.height)
            let tableviewCenter = CGPointMake(self.view.center.x, self.navBarView.center.y + self.navBarView.frame.height/2 + (self.view.frame.height - self.navBarView.frame.height - self.commentView.frame.height)/2)
            UIView.animateWithDuration(animateFullScreenDuration, delay: 0, options: [.CurveEaseOut], animations: {
                self.navBarView.center = navVarViewCenter
                self.commentView.center = commentViewCenter
                self.currentTableView.bounds = tableviewBounds
                self.currentTableView.center = tableviewCenter
                }, completion: { (_) in
            })
            
            isFullScreen = false
        }
        
        justEnter = false
    }
    
}

extension TimelineDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hasNew && tableView.tag == 2 {
            let cellData = self.isUp ? self.timelineList[currentIndex-1] : self.timelineList[currentIndex+1]
            let msgCount = cellData.messageList.count
            let cmtCount = cellData.commentList.count
            return 2+msgCount+(cmtCount == 0 ? 0 : cmtCount + 2)
        }
        
        if self.timelineList.count > 0 {
            let cellData = self.timelineList[currentIndex]
            let msgCount = cellData.messageList.count
            let cmtCount = cellData.commentList.count
            return 2+msgCount+(cmtCount == 0 ? 0 : cmtCount + 2)
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cellData: Timeline!
        if self.hasNew && tableView.tag == 2 {
            cellData = self.isUp ? self.timelineList[currentIndex-1] : self.timelineList[currentIndex+1]
        } else {
            cellData = self.timelineList[currentIndex]
        }
        let msgs = cellData.messageList
        let msgCount = msgs.count
        let cmts = cellData.commentList
        let cmtCount = cmts.count
        if row == 0 {
            let cell = tableview.dequeueReusableCellWithIdentifier("TopCell") as! TopCell
            cell.dateLbl.text = cellData.date!
            cell.timeLbl.text = cellData.time!
            cell.nameLbl.text = cellData.userid
            cell.iconBgView.backgroundColor = cellData.bgColor
            cell.iconImg.image = UIImage(named: "Two Hearts White")
            
            return cell
        } else if row == 1{
            let cell = tableview.dequeueReusableCellWithIdentifier("ContentCell") as! ContentCell
            if cellData.imageIdList?.count > 0 {
                getImageByIdAndLocation((cellData.imageIdList?.first)!, location: cellData.location!, complete: { (image) in
                    cell.coverImg.image = image
                })
            }
            cell.contentContainnerView.backgroundColor = cellData.bgColor
            cell.contentTextView.text = cellData.content
            cell.locationBtn.setTitle(cellData.location, forState: .Normal)
            cell.typeLbl.textColor = cellData.bgColor!
            cell.typeLbl.text = getTypeLblText(cellData.type!, subtype: cellData.subtype!)
            
            cell.initCell(cellData.bgColor!,
                          imgs: cellData.imageIdList!,
                          location: cellData.location!,
                          content: cellData.content!
            )
            
            self.contentCellDif = cell.contentViewHeightDif
            
            return cell
            
        } else if row <= (1 + msgCount) {
            let msgData = msgs[row-2]
            if (cellData.userid) == (msgData.userId) {
                let cell = tableView.dequeueReusableCellWithIdentifier("MeCell") as! MeCell
                cell.avatarImg.image = UIImage(named: "avatar2")
                cell.msgTextView.text = msgData.content
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("LoverCell") as! LoverCell
                cell.avatarImg.image = UIImage(named: "avatar1")
                cell.msgTextView.text = msgData.content
                
                return cell
            }
        } else if row == (2 + msgCount) {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTopCell") as! CommentTopCell
            
            return cell
        } else if row <= (2 + msgCount + cmtCount) {
            let cmtData = cmts[row-3-msgCount]
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
            cell.commentMetaInfoLbl.text = "\(cmtData.userId)    \(cmtData.time) \(cmtData.date)"
            cell.commentContentLbl.text = cmtData.content
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentBottomCell") as! CommentBottomCell
            return cell
        }
        
        // to erase error warning
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentBottomCell") as! CommentBottomCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        var cellData: Timeline
        if self.hasNew && tableView.tag == 2 {
            cellData = self.isUp ? self.timelineList[currentIndex-1] : self.timelineList[currentIndex+1]
        } else {
            cellData = self.timelineList[currentIndex]
        }
        let msgCount = (cellData.messageList).count
        let cmtCount = (cellData.commentList).count
        
        if row == 0 {
            return 80
        } else if row == 1 {
            if self.contentCellDif != 0 {
                return 468 + self.contentCellDif
            }
            return 468
        } else if row <= (1 + msgCount) {
            return 75
        } else if row == (2 + msgCount) {
            return 50
        } else if row <= (2 + msgCount + cmtCount) {
            return 60
        } else {
            return 70
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //        cell.alpha = 0
        //        UIView.animateWithDuration(0.8, delay: 0, options: [.CurveEaseOut], animations: {
        //            cell.alpha = 1
        //            }) { (complete) in
        //        }
    }
}

extension TimelineDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let this = (scrollView as? UITableView) {
            if this == self.currentTableView {
                //                print(this.contentOffset.y)
                //                print(this.contentSize.height-70)
                //                if this.contentOffset.y >= 80 && this.contentOffset.y <= (this.contentSize.height-70-this.frame.height) && this.contentOffset.y > lastScrollViewOffsetY+3 {
                //                    enterFullScreen()
                //                } else {
                //                    exitFullScreen()
                //                }
                //                if this.contentOffset.y - lastScrollViewOffsetY > 3 {
                //                    self.lastScrollViewOffsetY = this.contentOffset.y
                //                }
                if currentIndex > 0 {
                    if scrollView.contentOffset.y < -pullToLoadViewHeight*(11/16) {
                        if self.upView.isRotated == false {
                            self.upView.isRotated = true
                            UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                                self.upView.iconView.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180)
                                }, completion: { (complete) in
                            })
                        }
                        
                        if scrollView.contentOffset.y < -pullToLoadViewHeight {
                            scrollView.contentOffset.y = -pullToLoadViewHeight
                        }
                    } else {
                        if self.upView.isRotated == true {
                            self.upView.isRotated = false
                            UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                                self.upView.iconView.transform = CGAffineTransformIdentity
                                }, completion: { (complete) in
                            })
                        }
                    }
                    print(this.contentOffset.y)
                    print(this.contentSize.height - pullToLoadViewHeight + pullToLoadViewHeight*(11/16))
                }
                
                if currentIndex < timelineList.count - 1 {
                    if this.contentOffset.y + this.frame.height > (this.contentSize.height + pullToLoadViewHeight*(11/16)) {
                        if self.downView.isRotated == false {
                            self.downView.isRotated = true
                            UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                                self.downView.iconView.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180)
                                }, completion: { (complete) in
                            })
                        }
                        
                        if this.contentOffset.y + this.frame.height > (this.contentSize.height + pullToLoadViewHeight) {
                            this.contentOffset.y = (this.contentSize.height + pullToLoadViewHeight) - this.frame.height
                        }
                    } else {
                        if self.downView.isRotated == true {
                            self.downView.isRotated = false
                            UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                                self.downView.iconView.transform = CGAffineTransformIdentity
                                }, completion: { (complete) in
                            })
                        }
                    }
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if let this = (scrollView as? UITableView) {
            if this == self.currentTableView {
                if self.upView.isRotated == true && !self.refreshControl.refreshing {
                    print(this.contentOffset)
                    self.refreshControl.beginRefreshing()
                    self.didPull(true)
                }
                if self.downView.isRotated == true && !self.refreshControl.refreshing {
                    print(this.contentOffset)
                    self.refreshControl.beginRefreshing()
                    self.didPull(false)
                }
            }
        }
    }
    
}