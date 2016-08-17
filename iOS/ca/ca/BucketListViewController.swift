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
    
    var dataForToDo = [BucketListItem]() {
        didSet {
            self.selectedCellIndex = nil
        }
    }
    
    var dataForDone = [BucketListItem]() {
        didSet {
            self.selectedCellIndex = nil
        }
    }
    
    var selectedCellIndex: NSIndexPath?
    
    
    let topView = UIView()
    let topViewLbl = UILabel()
    let bottomView = UIView()
    let bottomViewLbl = UILabel()
    var currentBottomViewY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        topView.frame = CGRectMake(0, -60, self.view.frame.width, 60)
        
        topViewLbl.numberOfLines = 2
        topViewLbl.textColor = THEME().textMainColor(0.8)
        topViewLbl.text = "所有梦想\n都变成了我们的未来"
        topViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
        topViewLbl.frame = CGRectMake(8, 0, topView.frame.width, topView.frame.height)
        
        topView.addSubview(topViewLbl)
        self.tableview.addSubview(topView)
        
        
        let bottomViewY = self.tableview.contentSize.height > self.tableview.frame.height ? self.tableview.contentSize.height : self.tableview.frame.height
        bottomView.frame = CGRectMake(0, bottomViewY, self.view.frame.width, 60)
        
        self.tableview.addSubview(bottomView)
        
        bottomViewLbl.numberOfLines = 1
        bottomViewLbl.textColor = THEME().textMainColor(0.8)
        bottomViewLbl.text = "I ❤️ U~"
        bottomViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
        bottomViewLbl.textAlignment = .Center
        bottomViewLbl.frame = CGRectMake(8, 0, bottomView.frame.width, bottomView.frame.height)
        
        bottomView.addSubview(bottomViewLbl)
    }
    
    override func viewDidAppear(animated: Bool) {
        let sb = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(sb.width * 1, 50, sb.width, sb.height - 100)
    }
    
    func loadData() {
        let ref = Wilddog(url: SERVER+"/BucketList")
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
    
    
    func updateTextDisplayViews() {
        let bottomViewY = self.tableview.contentSize.height > self.tableview.frame.height ? self.tableview.contentSize.height : self.tableview.frame.height
        if bottomViewY != currentBottomViewY {
            bottomView.frame.origin.y = bottomViewY
            currentBottomViewY = bottomViewY
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
            if selectedCellIndex == indexPath {
                let cell = tableview.dequeueReusableCellWithIdentifier("BucketListCellWithButton") as! BucketListCellWithButton
                cell.initCell(dataForToDo[indexPath.row])
                
                return cell
                
            }
            let cell = tableview.dequeueReusableCellWithIdentifier("BucketListCell") as! BucketListCell
            cell.initCell(dataForToDo[indexPath.row])
            
            return cell
        } else if indexPath.section == 1 {
            if selectedCellIndex == indexPath {
                let cell = tableview.dequeueReusableCellWithIdentifier("BucketListCellWithButton") as! BucketListCellWithButton
                cell.initCell(dataForDone[indexPath.row])
                
                return cell
                
            }
            let cell = tableview.dequeueReusableCellWithIdentifier("BucketListCell") as! BucketListCell
            cell.initCell(dataForDone[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedCellIndex == indexPath {
            return 74
        }
        
        return 44
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
            let ref = Wilddog(url: SERVER+"/BucketList/\(temp.id)")
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
            let ref = Wilddog(url: SERVER+"/BucketList/\(temp.id)")
            ref.setValue(nil)
        }
        
        removeAction.backgroundColor = BLUE_THEME_COLOR
        
        return [doneAction, removeAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
        var indexPaths = [NSIndexPath]()
        if selectedCellIndex != nil {
            indexPaths.append(NSIndexPath(forRow: selectedCellIndex!.row, inSection: (selectedCellIndex?.section)!))
        }
        selectedCellIndex = selectedCellIndex == indexPath ? nil : indexPath
        if selectedCellIndex != nil {
            indexPaths.append(NSIndexPath(forRow: selectedCellIndex!.row, inSection: (selectedCellIndex?.section)!))
        }
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row >= tableView.visibleCells.count {
            updateTextDisplayViews()
        }
    }
}