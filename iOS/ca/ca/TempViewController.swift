//
//  TempViewController.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class TempViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var timelineList: [Timeline]!
    var currentIndex = 0
    var isMessage = true
    
    var currentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        // Do any additional setup after loading the view.
        
        
//        let ref = Wilddog(url: SERVER+"/Timeline/\(timelineList[currentIndex].id ?? "")/messages")
//        ref.setValue([], withCompletionBlock: { (error, completeRef) in
//            
//            let newMsgRef = completeRef.childByAutoId()
//            let newMsg: [String:AnyObject] = [
//                "userId": "husband",
//                "content": "test",
//                "createAt": "\(NSDate().timeIntervalSince1970)"
//            ]
//            
//            newMsgRef.setValue(newMsg)
//            
//        })
    }
    
    class func tempViewController(timelineList: [Timeline],index: Int) -> TempViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TempViewController") as! TempViewController
        
        vc.timelineList = timelineList
        vc.currentIndex = index
        //        vc.currentData = vc.dataForCell
        
        return vc
    }
    
    
    func initTableView() {
        
        let newTableView = TDTable.tableview(self.timelineList[currentIndex])
        newTableView.tag = 1
        
        newTableView.frame = CGRectMake(20, 50, self.view.frame.width - 40, self.view.frame.height - 50)
        
        self.view.addSubview(newTableView)
//        self.view.sendSubviewToBack(newTableView)
        
        self.currentTableView = newTableView
        self.currentTableView.reloadData()
    }

}

extension TempViewController {
    
    @IBAction func dismissBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { 
        }
    }
}