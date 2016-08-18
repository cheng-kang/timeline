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
    var isMessage = true {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                return 161
            }
        } else if indexPath.section == 1 {
            return 84
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerview = TDCell2.headerview()
            headerview.messageBtnClosure = {
                self.isMessage = true
            }
            headerview.commentBtnClosure = {
                self.isMessage = false
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
