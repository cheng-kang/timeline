//
//  TimelineDetailViewController.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TimelineDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    
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
            if oldValue != nil {
                self.tableview.reloadData()
            }
            getPrevAndNextData()
        }
    }
    var prevData: Dictionary<String, AnyObject?>?
    var nextData: Dictionary<String, AnyObject?>?
    
    func getPrevAndNextData() {
        // get prev data
        prevData = dataForCell
        
        // get next data
        nextData = dataForCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.dataSource = self
        self.tableview.delegate = self

        // Do any additional setup after loading the view.
        let upView = UIView()
        upView.backgroundColor = UIColor.blueColor()
        upView.frame = CGRectMake(0, -20, self.view.frame.width, 20)
        self.tableview.addSubview(upView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func timelineDetailViewController() -> TimelineDetailViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TimelineDetailViewController") as! TimelineDetailViewController
        
        vc.currentData = vc.dataForCell
        
        return vc
    }
    
    @IBAction func dismissBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let msgCount = (self.currentData!["messages"] as! [Dictionary<String, AnyObject>]).count
        let cmtCount = (self.currentData!["comments"] as! [Dictionary<String, AnyObject>]).count
        return 4+msgCount+cmtCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellData = self.dataForCell
        let msgs = self.currentData!["messages"] as! [Dictionary<String, AnyObject>]
        let msgCount = msgs.count
        let cmts = self.currentData!["comments"] as! [Dictionary<String, AnyObject>]
        let cmtCount = cmts.count
        if row == 0 {
            let cell = tableview.dequeueReusableCellWithIdentifier("TopCell") as! TopCell
            cell.dateLbl.text = cellData["date"] as! String
            cell.timeLbl.text = cellData["time"] as! String
            cell.nameLbl.text = cellData["username"] as! String
            cell.iconBgView.backgroundColor = cellData["backgroundColor"] as! UIColor
            cell.iconImg.image = cellData["icon"] as! UIImage
            
            return cell
        } else if row == 1{
            let cell = tableview.dequeueReusableCellWithIdentifier("ContentCell") as! ContentCell
            
            cell.coverImg.image = cellData["cover"] as! UIImage
            cell.contentContainnerView.backgroundColor = cellData["backgroundColor"] as! UIColor
            cell.contentTextView.text = cellData["content"] as! String
            cell.locationBtn.setTitle(cellData["location"] as! String, forState: .Normal)
            
            cell.initCell(cellData["backgroundColor"] as! UIColor, imgs: cellData["images"] as! [UIImage])
            
            return cell
            
        } else if row <= (1 + msgCount) {
            let msgData = msgs[row-2]
            if (cellData["username"] as! String) == (msgData["username"] as! String) {
                let cell = tableView.dequeueReusableCellWithIdentifier("MeCell") as! MeCell
                cell.avatarImg.image = msgData["avatar"] as! UIImage
                cell.msgTextView.text = msgData["content"] as! String
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("LoverCell") as! LoverCell
                cell.avatarImg.image = msgData["avatar"] as! UIImage
                cell.msgTextView.text = msgData["content"] as! String
                
                return cell
            }
        } else if row == (2 + msgCount) {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTopCell") as! CommentTopCell
            
            return cell
        } else if row <= (2 + msgCount + cmtCount) {
            let cmtData = cmts[row-3-msgCount]
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
            cell.commentMetaInfoLbl.text = "\(cmtData["username"] as! String)    \(cmtData["time"] as! String) \(cmtData["date"] as! String)"
            cell.commentContentLbl.text = cmtData["content"] as! String
            
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
        let msgs = self.currentData!["messages"] as! [Dictionary<String, AnyObject>]
        let msgCount = msgs.count
        let cmts = self.currentData!["comments"] as! [Dictionary<String, AnyObject>]
        let cmtCount = cmts.count
        
        if row == 0 {
            return 80
        } else if row == 1 {
            return 274
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
        cell.alpha = 0
        UIView.animateWithDuration(0.8, delay: 0, options: [.CurveEaseOut], animations: {
            cell.alpha = 1
            }) { (complete) in
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

}
