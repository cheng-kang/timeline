//
//  EventsViewController.swift
//  CA
//
//  Created by Ant on 16/7/28.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    let topViewLbl = UILabel()
    
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    
    var dataForCell: [Dictionary<String, AnyObject>] = [
        [
            "datetime": "2029-09-28 13:00:00",
            "weekday": "THU",
            "day": "28",
            "time": "13:30",
            "content": "吃胃药！！记得吃啊！！！我爱你~"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "FRI",
            "day": "29",
            "time": "18:30",
            "content": "周五啦！！"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "SAT",
            "day": "30",
            "time": "08:30",
            "content": "远程教学"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "THU",
            "day": "28",
            "time": "13:30",
            "content": "吃胃药！！记得吃啊！！！我爱你~"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "FRI",
            "day": "29",
            "time": "18:30",
            "content": "周五啦！！"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "SAT",
            "day": "30",
            "time": "08:30",
            "content": "远程教学"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "THU",
            "day": "28",
            "time": "13:30",
            "content": "吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~吃胃药！！记得吃啊！！！我爱你~"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "FRI",
            "day": "29",
            "time": "18:30",
            "content": "周五啦！！"
        ],
        [
            "datetime": "2016-07-29 18:30:00",
            "weekday": "SAT",
            "day": "30",
            "time": "08:30",
            "content": "远程教学"
        ],
    ]
    
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var years = ["2013", "2014", "2015", "2016", "2017", "2018", "2019", ]
    
    var isMonth = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.collectionview.dataSource = self
        self.collectionview.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        
        let topView = UIView()
        topView.frame = CGRectMake(0, -60, self.view.frame.width, 60)
        
        self.tableview.addSubview(topView)
        
        topViewLbl.numberOfLines = 2
        topViewLbl.textColor = THEME().textMainColor(0.8)
        topViewLbl.text = getCustomizedCurrentDatetimeString()
        topViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
        topViewLbl.frame = CGRectMake(8, 0, topView.frame.width, topView.frame.height)
        //\nJuly 29 | 00:51:59
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(EventsViewController.updateDatetimeLbl(_:)), userInfo: nil, repeats: true)
        
        
        
        topView.addSubview(topViewLbl)
        
        let bottomView = UIView()
        let bottomViewY = self.tableview.contentSize.height > self.tableview.frame.height ? self.tableview.contentSize.height : self.tableview.frame.height
        bottomView.frame = CGRectMake(0, bottomViewY, self.view.frame.width, 60)
        
        self.tableview.addSubview(bottomView)
        
        let bottomViewLbl = UILabel()
        bottomViewLbl.numberOfLines = 2
        bottomViewLbl.textColor = THEME().textMainColor(0.8)
        bottomViewLbl.text = "I ❤️ U~"
        bottomViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
        bottomViewLbl.frame = CGRectMake(8, 0, topView.frame.width, topView.frame.height)
        
        bottomView.addSubview(bottomViewLbl)
    }
    
    class func eventsViewController() -> EventsViewController {
        
        let sb = UIStoryboard(name: "Events", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("EventsViewController") as! EventsViewController
        
        return vc
    }
    
    func updateDatetimeLbl(sender: UILabel) {
        topViewLbl.text = getCustomizedCurrentDatetimeString()
    }
    
    @IBAction func monthBtnClick(sender: UIButton) {
        isMonth = true
        self.collectionview.reloadData()
        collectionview.hidden = false
    }
    
    @IBAction func yearBtnClick(sender: UIButton) {
        isMonth = false
        self.collectionview.reloadData()
        collectionview.hidden = false
    }
    
    @IBAction func addBtnClick(sender: UIButton) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForCell.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCell
        let cellData = dataForCell[indexPath.row]
        cell.initCell(cellData["weekday"] as! String, day: cellData["day"] as! String, time: cellData["time"] as! String, content: cellData["content"] as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cellData = self.dataForCell[indexPath.row]
        let vc = EventDetailView.eventDetailView(cellData["datetime"] as! String, content: cellData["content"] as! String)
        vc.show()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isMonth ? months.count : years.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if isMonth {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MonthCell", forIndexPath: indexPath) as! MonthCell
            cell.initCell(months[indexPath.row])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("YearCell", forIndexPath: indexPath) as! YearCell
        cell.initCell(years[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        self.collectionview.hidden = true
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
