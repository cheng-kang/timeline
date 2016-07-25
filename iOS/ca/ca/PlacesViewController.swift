//
//  PlacesViewController.swift
//  ca
//
//  Created by Ant on 16/7/16.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    var places: [Dictionary<String, AnyObject>] = [
        [
            "backgroundImage": UIImage(named: "infrontofstone")!,
            "location": "Beijing, China",
            "photosCount": 5
        ],
        [
            "backgroundImage": UIImage(named: "disney")!,
            "location": "Los Angeles, USA",
            "photosCount": 1
        ],
        [
            "backgroundImage": UIImage(named: "kiss")!,
            "location": "Beijing, China",
            "photosCount": 13
        ],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self

        // Do any additional setup after loading the view.
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
    
    
    @IBAction func menuBtnClick(sender: UIButton) {
        //        let menu = SideMenuView.sideMenuView(UIImage(named: "avatar1")!)
        LEFTMENU.show()
        LEFTMENU.menuDismissing = {
            
            //            self.contentView.layer.anchorPoint = CGPointMake(1,1)
            //            UIView.animateWithDuration(0.5) {
            ////                self.contentView.layer.anchorPoint = CGPointMake(1,1)
            //                self.contentView.layer.transform = CATransform3DIdentity
            //            }
            
            UIView.animateWithDuration(0.3, animations: {
                
                self.contentView.layer.transform = CATransform3DIdentity
                }, completion: { (complete) in
                    if complete {
                        
                        self.setAnchorPoint(CGPointMake(0.5,0.5), forView: self.contentView)
                    }
            })
        }
        
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
        
        cell.initCell(cellData["backgroundImage"] as! UIImage, location: cellData["location"] as! String, photoCount: cellData["photosCount"] as! Int)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let vc = PlaceViewController.placeViewController(1)
//        self.presentViewController(vc, animated: true) {
//            
//        }
        
        self.performSegueWithIdentifier("PlacesToPlace", sender: [
            "id": 1
            ])
        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let data = sender as! Dictionary<String, AnyObject>
        
        if segue.identifier == "PlacesToPlace"{
            let vc = segue.destinationViewController as! PlaceViewController
            vc.locationId = (data["id"] as! Int)
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
