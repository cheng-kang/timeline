//
//  NewEventViewController.swift
//  CA
//
//  Created by Ant on 16/8/13.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class NewEventViewController: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var datetimeLbl: UILabel!
    @IBOutlet weak var datetimeBtn: UIButton!
    @IBOutlet weak var eventinfoLbl: UILabel!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var eventinfoTextview: UITextView!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
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
        let ref = Wilddog(url: SERVER+"/Events")
        let newRef = ref.childByAutoId()
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date = dateFormatter.dateFromString((self.datetimeBtn.titleLabel?.text)!)
        
        let newData: [String:AnyObject] = [
            "userId": "husband",
            "content": self.eventinfoTextview.text!,
            "createAt": "\(NSDate().timeIntervalSince1970)",
            "alarmAt": "\(date!.timeIntervalSince1970)",
        ]
        newRef.setValue(newData)
        
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
