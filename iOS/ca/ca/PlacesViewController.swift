//
//  PlacesViewController.swift
//  ca
//
//  Created by Ant on 16/7/16.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    var places = [Place]() {
        didSet {
            var count = 0
            for i in 0..<places.count {
                count += places[i].photoList.count
            }
            photoCount = count
        }
    }
    var photoCount = 0 {
        didSet {
            topViewLbl.text = "我们一起去过 \(places.count) 个地方\n拍了 \(photoCount) 张照片"
        }
    }
    
    let topView = UIView()
    let topViewLbl = UILabel()
    let bottomView = UIView()
    let bottomViewLbl = UILabel()
    var currentBottomViewY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        let ref = Wilddog(url: SERVER+"/Photos")
        ref.observeEventType(.Value) { (snapshot: WDataSnapshot) in
            if snapshot.value != nil {
                var tempPlaceList = [Place]()
                for (key,value) in (snapshot.value as! [String:AnyObject]) {
                    let placeData = value as! [String:AnyObject]
                    
                    let tempPlace = Place()
                    tempPlace.id = key
                    
                    var tempPhotoList = [Photo]()
                    for (key,value) in placeData {
                        let photoData = value as! [String: AnyObject]
                        
                        let tempPhoto = Photo()
                        tempPhoto.id = key
                        tempPhoto.createAt = String(photoData["createAt"] as! Double)
                        if let tl = photoData["timeline"] {
                            tempPhoto.timeline = tl as! String
                        }
                        tempPhotoList.append(tempPhoto)
                    }
                    
                    tempPlace.photoList = tempPhotoList
                    tempPlaceList.append(tempPlace)
                }
                
                self.places.removeAll()
                self.places = tempPlaceList
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        topView.frame = CGRectMake(0, -60, self.view.frame.width, 60)
        
        topViewLbl.numberOfLines = 2
        topViewLbl.textColor = THEME().textMainColor(0.8)
        topViewLbl.text = "我们一起去过 \(places.count) 个地方\n拍了 \(photoCount) 张照片"
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
        self.view.frame = CGRectMake(sb.width * 2, 50, sb.width, sb.height - 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    class func placesViewController() -> PlacesViewController {
        
        let sb = UIStoryboard(name: "Places", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("PlacesViewController") as! PlacesViewController
        
        return vc
    }
    
    func updateTextDisplayViews() {
        let bottomViewY = self.tableview.contentSize.height > self.tableview.frame.height ? self.tableview.contentSize.height : self.tableview.frame.height
        if bottomViewY != currentBottomViewY {
            bottomView.frame.origin.y = bottomViewY
            currentBottomViewY = bottomViewY
        }
    }
    
    @IBAction func menuBtnClick(sender: UIButton) {
        //        let menu = SideMenuView.sideMenuView(UIImage(named: "avatar1")!)
//        LEFTMENU.show()
//        LEFTMENU.menuDismissing = {
        
            //            self.contentView.layer.anchorPoint = CGPointMake(1,1)
            //            UIView.animateWithDuration(0.5) {
            ////                self.contentView.layer.anchorPoint = CGPointMake(1,1)
            //                self.contentView.layer.transform = CATransform3DIdentity
            //            }
            
//            UIView.animateWithDuration(0.3, animations: {
//                
//                self.contentView.layer.transform = CATransform3DIdentity
//                }, completion: { (complete) in
//                    if complete {
//                        
//                        self.setAnchorPoint(CGPointMake(0.5,0.5), forView: self.contentView)
//                    }
//            })
//        }
        
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
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as! PlaceCell
        
        let cellData = self.places[indexPath.row]
        
        cell.initCell((cellData.photoList.count > 0 ? (cellData.photoList.first?.id)! : ""), location: cellData.id, photoCount: cellData.photoList.count)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = PlaceViewController.placeViewController(self.places[indexPath.row])
        self.presentViewController(vc, animated: true) {
            
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row >= tableView.visibleCells.count {
            updateTextDisplayViews()
        }
    }

}
