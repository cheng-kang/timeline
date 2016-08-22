//
//  NewBucketListItem.swift
//  CA
//
//  Created by Ant on 16/8/12.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import CoreLocation
import Wilddog

class NewBucketListItem: UIView {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var editingLbl: UILabel!
    
    let cl = CLLocationManager()
    let gc = CLGeocoder()
    var location = NSLocalizedString("Unknown", comment: "Location")
    
    var data: BucketListItem? {
        didSet {
            self.textfield.text = self.data?.content
            
            self.editingLbl.text = NSLocalizedString("editing", comment: "Bucket List")
            self.editingLbl.hidden = false
        }
    }
    var selfY: CGFloat = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // get location
        cl.delegate = self
        cl.requestWhenInUseAuthorization()
        cl.desiredAccuracy = kCLLocationAccuracyBest
        cl.distanceFilter = 10
        cl.requestLocation()
        
        self.titleLbl.text = NSLocalizedString("MUST", comment: "Bucket List")
        self.cancelBtn.setTitle(NSLocalizedString("Cancel", comment: "Bucket List"), forState: .Normal)
        self.confirmBtn.setTitle(NSLocalizedString("Confirm", comment: "Bucket List"), forState: .Normal)
        self.textfield.placeholder = NSLocalizedString("DO THIS WITH MY DARLING!~", comment: "Bucket List")
        
        self.textfield.delegate = self
        
        self.confirmBtn.enabled = false
        
        shadowBtn = UIButton(type: .Custom)
        shadowBtn.addTarget(self, action: #selector(NewBucketListItem.shadowBtnClick), forControlEvents: .TouchUpInside)
        shadowBtn.backgroundColor = UIColor.blackColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    class func newBucketListItem() -> NewBucketListItem {
        let view = NSBundle.mainBundle().loadNibNamed("NewBucketListItem", owner: nil, options: nil).first as! NewBucketListItem
        
        return view
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func cancelBtnClick() {
        shadowBtnClick()
    }
    @IBAction func confirmBtnClick() {
        let timelineRef = Wilddog(url: SERVER+"/Timeline")
        let bucketListRef = Wilddog(url: SERVER+"/BucketList")
        
        if data == nil {
            print("Creating timeline...")
            let newTimelineRef = timelineRef.childByAutoId()
            
            var timelineDataImages = [String: String]()
            timelineDataImages["count"] = "0"
            let timelineData = [
                "userId": "husband",
                "type": "Wish",
                "subtype": "",
                "title": "",
                "content": "",
                "images": timelineDataImages,
                "location": self.location,
                "icon": 0,//15
                "bgColor": 0,//Int(arc4random_uniform(UInt32(BG_COLORS.count)))
                "createAt": "\(NSDate().timeIntervalSince1970)",
                "updateAt": "\(NSDate().timeIntervalSince1970)",
                "messages": "",
                "comments": "",
                ]
        
            newTimelineRef.setValue(timelineData, withCompletionBlock: { (error, ntRef) in
                
                let newRef = bucketListRef.childByAutoId()
                let newData: [String:AnyObject] = [
                    "userId": "husband",
                    "content": self.textfield.text!,
                    "createAt": "\(NSDate().timeIntervalSince1970)",
                    "done": "NO",
                    "doneAt": "",
                    "timeline": ntRef.key
                ]
                newRef.setValue(newData, withCompletionBlock: { (error, nblRef) in
                    
                    ntRef.updateChildValues(["title":nblRef.key])
                })
            })
        } else {
            let updateRef = bucketListRef.childByAppendingPath(data!.id)
            let updateData: [String:AnyObject] = [
                "content": self.textfield.text!
            ]
            updateRef.updateChildValues(updateData)
        }
        shadowBtnClick()
    }
    
    
    
    let ApplicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var showView: UIView {
        return ApplicationDelegate.window!
    }
    
    private var shadowBtn: UIButton!
    func show() {
        
        let size = UIScreen.mainScreen().bounds.size
        self.shadowBtn.center = CGPoint(x: size.width/2, y: size.height/2)
        self.shadowBtn.frame = self.showView.bounds
        self.shadowBtn.alpha = 0
        self.alpha = 0
        
        let width = size.width - 40
        self.frame.size = CGSizeMake(width, width/1.8)
        self.center = self.shadowBtn.center
        
        self.selfY = self.frame.origin.y
        
        self.transform = CGAffineTransformMakeScale(1.2, 1.2)
        
        
        UIView.animateWithDuration(0.25) {
            
            self.shadowBtn.alpha = 0.4
            self.showView.addSubview(self.shadowBtn)
            
            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .CurveEaseInOut, animations: {
                self.showView.addSubview(self)
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                
                self.alpha = 1
                }, completion: { (_) in
                    self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.showView.addSubview(self)
                    self.alpha = 1
            })
        }
    }
    
    @objc private func shadowBtnClick() {
        
        UIView.animateWithDuration(0.15, animations: {
            self.shadowBtn.alpha = 0
            self.alpha = 0
        }) { (success) in
            self.shadowBtn.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

}

extension NewBucketListItem: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newText = textField.text!.stringByReplacingCharactersInRange(
            range.toRange(textField.text!), withString: string)
        self.confirmBtn.enabled = newText.characters.count > 0
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// keyboard events
extension NewBucketListItem {
    func keyboardWillShow(notification: NSNotification) {
        
        self.frame = CGRectMake(20, self.selfY - 60, self.frame.width, self.frame.height)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        
        UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseOut], animations: {
            self.frame = CGRectMake(20, self.selfY - 60, self.frame.width, self.frame.height)
        }) { (complete) in
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            self.frame = CGRectMake(20, self.selfY, self.frame.width, self.frame.height)
        }) { (complete) in
        }
    }
}

extension NewBucketListItem: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        gc.reverseGeocodeLocation(locations.first!) { (placemark, error) in
            if error != nil {
                print(error)
                return
            }
            
            let address = (placemark?.first?.addressDictionary)!
            
            self.location = (address["State"] as! String) + ", " + (address["Country"] as! String)
        }
    }
}

