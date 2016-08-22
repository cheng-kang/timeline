//
//  TDTableViewController.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDTableViewController: UITableViewController {

    var data: Timeline!
    var currentIndex = 0
    var timelineCount = 0
    
    var pullToLoadViewHeight: CGFloat = 60
    
    var isMessage = true {
        didSet {
            reloadDataClosure!()
        }
    }
    
    let headerview = TDCell2.headerview()
    
    var reloadDataClosure: (()->())?
    var didPullClosure: ((isUp: Bool)->())?
    var addDisplayViewClosure: ((fullScreenDisplayView: UIScrollView)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return isMessage ? data.messageList.count : data.commentList.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TDCell0") as! TDCell0
                cell.nameLbl.text = data.userId
                cell.dateLbl.text = data.dateAndWeekday
                cell.location = data.location
                
                cell.addDisplayViewClosure = { fullScreenDisplayView in
                    self.addDisplayViewClosure!(fullScreenDisplayView: fullScreenDisplayView)
                }
                
                cell.photos = data.imageIdList
                
                
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TDCell1") as! TDCell1
                cell.content = data.content
                cell.locationLbl.setTitle(data.location, forState: .Normal)
                cell.timeLbl.text = data.time
                
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TDCell3") as! TDCell3
            let celldata = isMessage ? data.messageList[indexPath.row] : data.commentList[indexPath.row]
            cell.avatarView.image = UIImage(named: "avatar1")
            cell.nameLbl.text = celldata.userId
            cell.datetimeLbl.text = celldata.datetime
            cell.content = celldata.content
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 282
            } else if indexPath.row == 1 {
                let height = data.content.heightThatFitsContentByWidth(SCREEN_WIDTH - 40 - 60 - 8)
                let dif = height - 121
                
                return 161 + dif
            }
        } else if indexPath.section == 1 {
            let list = isMessage ? data.messageList : data.commentList
            if list.count > indexPath.row {
                let temp = list[indexPath.row]
                let height = temp.content!.heightThatFitsContentByWidth(SCREEN_WIDTH - 40 - 60 - 8)
                let dif = height - 41.5
                
                return 84 + dif
            }
            return 84
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            // headerview btn closure
            headerview.messageBtnClosure = {
                self.isMessage = true
            }
            headerview.commentBtnClosure = {
                self.isMessage = false
            }
            headerview.commentSentClosure = { comment in
                if self.isMessage {
                    self.data.messageList.append(comment)
                } else {
                    self.data.commentList.append(comment)
                }
                self.reloadDataClosure!()
            }
            headerview.id = data.id
            headerview.hasComment = isMessage ? data.messageList.count > 0 : data.commentList.count > 0
            if headerview.isMessage != self.isMessage {
                headerview.isMessage = self.isMessage
            }
            return headerview
        }
        
        return UIView()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 55
        }
        
        return 0
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

extension TDTableViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if let this = (scrollView as? TDTable) {
            if scrollView.contentOffset.y < -60 {
                scrollView.contentOffset.y = -60
            }
            
            let frameHeight = this.frame.height
            let contentSizeHeight = scrollView.contentSize.height
            let displayHeight = contentSizeHeight > frameHeight ? contentSizeHeight : frameHeight
            let bottomOffsetY = displayHeight - frameHeight
            let maxOffsetY = bottomOffsetY + 60
            
            if scrollView.contentOffset.y > maxOffsetY {
                scrollView.contentOffset.y = maxOffsetY
            }
            
            if self.currentIndex > 0 {
                print("aaa")
                print((scrollView.contentOffset.y < -pullToLoadViewHeight*(11/16)))
                if scrollView.contentOffset.y < -pullToLoadViewHeight*(11/16) {
                    if this.pullToLoadTopView.isRotated == false {
                        this.pullToLoadTopView.isRotated = true
                        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                            this.pullToLoadTopView.iconView.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180)
                            }, completion: { (complete) in
                        })
                    }
                } else {
                    if this.pullToLoadTopView.isRotated == true {
                        this.pullToLoadTopView.isRotated = false
                        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                            this.pullToLoadTopView.iconView.transform = CGAffineTransformIdentity
                            }, completion: { (complete) in
                        })
                    }
                }
            }
            
            if currentIndex < timelineCount - 1 {
                if this.contentOffset.y - bottomOffsetY > pullToLoadViewHeight*(11/16) {
                    if this.pullToLoadBottomView.isRotated == false {
                        this.pullToLoadBottomView.isRotated = true
                        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                            this.pullToLoadBottomView.iconView.transform = CGAffineTransformIdentity
                            }, completion: { (complete) in
                        })
                    }
                } else {
                    if this.pullToLoadBottomView.isRotated == true {
                        this.pullToLoadBottomView.isRotated = false
                        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseOut], animations: {
                            this.pullToLoadBottomView.iconView.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180)
                            }, completion: { (complete) in
                        })
                    }
                }
            }
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if let this = (scrollView as? TDTable) {
            if this.pullToLoadTopView.isRotated == true && !this.refreshControl.refreshing {
                this.refreshControl.beginRefreshing()
                didPullClosure!(isUp: true)
            }
            if this.pullToLoadBottomView.isRotated == true && !this.refreshControl.refreshing {
                this.refreshControl.beginRefreshing()
                didPullClosure!(isUp: false)
            }
        }
    }
}

