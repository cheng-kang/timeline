//
//  BucketListViewController.swift
//  CA
//
//  Created by Ant on 16/7/31.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class BucketListViewController: UIViewController{

    @IBOutlet weak var tableview: UITableView!
    
    var dataForToDo = [BucketListItem]()
//        [
//        "一起去看日出",
//        "一起开你的车",
//        "一起去日本旅行",
//        "一起和你的朋友吃饭",
//        "一起去迪士尼乐园",
//        "go to Universal Theater together"
//    ]
//    
    var dataForDone = [BucketListItem]()
//        [
//        "一起住 Airbnb"
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        let ref = Wilddog(url: "https://catherinewei.wilddogio.com/BucketList")
        ref.observeEventType(.Value) { (snapshot: WDataSnapshot) in
            if snapshot.value != nil {
                var tempListForToDo = [BucketListItem]()
                var tempListForDone = [BucketListItem]()
                for (key,value) in (snapshot.value as! [String:AnyObject]) {
                    let data = value as! [String:String]
                    
                    let temp = BucketListItem()
                    temp.id = key
                    temp.userId = data["userId"]
                    temp.content = data["content"]
                    temp.createAt = data["createAt"]
                    temp.done = data["done"]
                    temp.doneAt = data["doneAt"]
                    
                    if temp.isDone! {
                        tempListForDone.append(temp)
                    } else {
                        tempListForToDo.append(temp)
                    }
                }
                
                self.dataForToDo.removeAll()
                self.dataForToDo = tempListForToDo
                self.dataForDone.removeAll()
                self.dataForDone = tempListForDone
                self.tableview.reloadData()
            }
        }
    }
    
    class func bucketListViewController() -> BucketListViewController {
        
        let sb = UIStoryboard(name: "BucketList", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("BucketListViewController") as! BucketListViewController
        
        return vc
    }
}

extension BucketListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let doneAction = UITableViewRowAction(style: .Default, title: "Done") { (action, indexPath) in
            let temp:BucketListItem!
            if indexPath.section == 0 {
                temp = self.dataForToDo[indexPath.row]
            } else {
                temp = self.dataForDone[indexPath.row]
            }
            let ref = Wilddog(url: "https://catherinewei.wilddogio.com/BucketList/\(temp.id)")
            ref.updateChildValues([
                "done": "YES",
                "doneAt": "\(Int(NSDate().timeIntervalSince1970))"
                ]
            )
        }
        
        doneAction.backgroundColor = GREEN_THEME_COLOR
        
        let removeAction = UITableViewRowAction(style: .Default, title: "Remove") { (action, indexPath) in
            let temp:BucketListItem!
            if indexPath.section == 0 {
                temp = self.dataForToDo[indexPath.row]
            } else {
                temp = self.dataForDone[indexPath.row]
            }
            let ref = Wilddog(url: "https://catherinewei.wilddogio.com/BucketList/\(temp.id)")
            ref.setValue(nil)
        }
        
        removeAction.backgroundColor = BLUE_THEME_COLOR
        
        return [doneAction, removeAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
        let temp:BucketListItem!
        if indexPath.section == 0 {
            temp = self.dataForToDo[indexPath.row]
        } else {
            temp = self.dataForDone[indexPath.row]
        }
        let ref = Wilddog(url: "https://catherinewei.wilddogio.com/BucketList/\(temp.id)")
        ref.updateChildValues([
            "done": "YES",
            "doneAt": "\(Int(NSDate().timeIntervalSince1970))"
            ]
        )
    }
}