//
//  NewEventViewController.swift
//  CA
//
//  Created by Ant on 16/8/13.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import CoreLocation
import Wilddog

class NewEventViewController: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var datetimeLbl: UILabel!
    @IBOutlet weak var datetimeBtn: UIButton!
    @IBOutlet weak var eventinfoLbl: UILabel!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var eventinfoTextview: UITextView!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    let cl = CLLocationManager()
    let gc = CLGeocoder()
    var location = NSLocalizedString("Unknown", comment: "Location")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.datepicker.addTarget(self, action: #selector(NewEventViewController.datepickerValueChanged(_:)), forControlEvents: .ValueChanged)
        
        setupUI() 
    }
    
    func setupUI() {
        self.titleLbl.text = NSLocalizedString("New Event", comment: "Event")
        self.datetimeLbl.text = NSLocalizedString("Date & Time:", comment: "Event")
        self.eventinfoLbl.text = NSLocalizedString("Event Info:", comment: "Event")
        self.postBtn.setTitle(NSLocalizedString("Post", comment: "Event"), forState: .Normal)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        let strDate = dateFormatter.stringFromDate(NSDate())
//        self.datetimeBtn.setTitle(NSLocalizedString(strDate, comment: "Event"), forState: .Normal)
        
        self.postBtn.enabled = false
        self.datepicker.hidden = true
        
        datepickerValueChanged(datepicker)
    }
    
    class func newEventViewController() -> NewEventViewController {
        
        let sb = UIStoryboard(name: "Events", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("NewEventViewController") as! NewEventViewController
        
        return vc
    }

}

// MARK: - Click Events
extension NewEventViewController {
    
    @IBAction func postBtnClick(sender: UIButton) {
        let timelineRef = Wilddog(url: SERVER+"/Timeline")
        let ref = Wilddog(url: SERVER+"/Events")
        let newRef = ref.childByAutoId()
        
        print("Creating timeline...")
        let newTimelineRef = timelineRef.childByAutoId()
        
        var timelineDataImages = [String: String]()
        timelineDataImages["count"] = "0"
        let timelineData = [
            "userId": "husband",
            "type": "Event",
            "subtype": "",
            "title": "",
            "content": "",
            "images": timelineDataImages,
            "location": self.location,
            "icon": 0,//27
            "bgColor": 0,//Int(arc4random_uniform(UInt32(BG_COLORS.count)))
            "createAt": "\(NSDate().timeIntervalSince1970)",
            "updateAt": "\(NSDate().timeIntervalSince1970)",
            "messages": "",
            "comments": "",
            ]
        newTimelineRef.setValue(timelineData) { (error, ntlRef) in
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let date = dateFormatter.dateFromString((self.datetimeBtn.titleLabel?.text)!)
            
            let newData: [String:AnyObject] = [
                "userId": "husband",
                "content": self.eventinfoTextview.text!,
                "createAt": "\(NSDate().timeIntervalSince1970)",
                "alarmAt": "\(date!.timeIntervalSince1970)",
                "timeline": ntlRef.key
                ]
            newRef.setValue(newData)
            ntlRef.updateChildValues(["title":newRef.key])
        }
        
        self.dismissViewControllerAnimated(true) {
        }
    }
    
    @IBAction func cancelBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true) {
        }
    }
    
    @IBAction func datetimeBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        self.datepicker.hidden = false
    }
    
    func datepickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(sender.date)
        
        self.datetimeBtn.setTitle(strDate, forState: .Normal)
        self.postBtn.enabled = true
        self.datepicker.hidden = true
    }
}

extension NewEventViewController: CLLocationManagerDelegate {
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
