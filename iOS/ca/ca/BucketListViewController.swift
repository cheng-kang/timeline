//
//  BucketListViewController.swift
//  CA
//
//  Created by Ant on 16/7/31.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class BucketListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    var dataForToDo = [
        "一起去看日出",
        "一起开你的车",
        "一起去日本旅行",
        "一起和你的朋友吃饭",
        "一起去迪士尼乐园",
        "go to Universal Theater together"
    ]
    
    var dataForDone = [
        "一起住 Airbnb"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.dataSource = self
        self.tableview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    class func bucketListViewController() -> BucketListViewController {
        
        let sb = UIStoryboard(name: "BucketList", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("BucketListViewController") as! BucketListViewController
        
        return vc
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataForToDo.count
        } else if section == 1 {
            return dataForDone.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableview.dequeueReusableCellWithIdentifier("BucketListCell") as! BucketListCell
            cell.initCell(dataForToDo[indexPath.row])
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableview.dequeueReusableCellWithIdentifier("BucketListCell") as! BucketListCell
            cell.initCell(dataForDone[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do: \(dataForToDo.count)"
        } else if section == 1 {
            return "Done: \(dataForDone.count)"
        }
        
        return ""
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
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
