//
//  TimelineDetailTableViewController.swift
//  CA
//
//  Created by Ant on 16/7/28.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TimelineDetailTableViewController: UITableViewController {
    
    var dataForCell = Timeline()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let msgCount = (self.dataForCell.messageList).count
        let cmtCount = (self.dataForCell.commentList).count
        return 2+msgCount+(cmtCount == 0 ? 0 : cmtCount + 2)
    }
    
    var contentCellDif: CGFloat = 0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellData = self.dataForCell
        let msgs = self.dataForCell.messageList
        let msgCount = msgs.count
        let cmts = self.dataForCell.commentList
        let cmtCount = cmts.count
        if row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TopCell") as! TopCell
            cell.dateLbl.text = cellData.date
            cell.timeLbl.text = cellData.time
            cell.nameLbl.text = cellData.userid
            cell.iconBgView.backgroundColor = GREEN_THEME_COLOR
            cell.iconImg.image = UIImage(named: "Two Hearts White")
            
            return cell
        } else if row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("ContentCell") as! ContentCell
            
            getImageById((cellData.imageIdList?.first)!, complete: { (image) in
                cell.coverImg.image = image
            })
            cell.contentContainnerView.backgroundColor = GREEN_THEME_COLOR
            cell.contentTextView.text = cellData.content
            cell.locationBtn.setTitle(cellData.location, forState: .Normal)
            
            cell.initCell(GREEN_THEME_COLOR,
                          imgs: [],
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
                cell.avatarImg.image = UIImage(named: "avatar2")
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        let msgs = self.dataForCell.messageList
        let msgCount = msgs.count
        let cmts = self.dataForCell.commentList
        let cmtCount = cmts.count
        
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
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //        cell.alpha = 0
        //        UIView.animateWithDuration(0.8, delay: 0, options: [.CurveEaseOut], animations: {
        //            cell.alpha = 1
        //            }) { (complete) in
        //        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
