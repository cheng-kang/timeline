//
//  BucketListCellWithButton.swift
//  CA
//
//  Created by Ant on 16/8/17.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog

class BucketListCellWithButton: UITableViewCell {

    @IBOutlet weak var mustLbl: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var data: BucketListItem!
    var isFold = true {
        didSet {
            if isFold {
                self.doneBtn.hidden = true
                self.editBtn.hidden = true
                self.deleteBtn.hidden = true
                self.cancelBtn.hidden = true
                self.finishBtn.hidden = true
                self.textfield.hidden = true
            } else {
                self.doneBtn.hidden = false
                self.editBtn.hidden = false
                self.deleteBtn.hidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.doneBtn.hidden = false
        self.editBtn.hidden = false
        self.deleteBtn.hidden = false
        self.cancelBtn.hidden = true
        self.finishBtn.hidden = true
        self.textfield.hidden = true
    }
    
    func initCell(data: BucketListItem) {
        self.data = data
        contentLbl.text = data.content
        textfield.text = data.content
        
        if self.data.isDone! {
            mustLbl.text = NSLocalizedString("DONE", comment: "BucketList")
            if NSLocalizedString("DONE", comment: "BucketList") == "DONE" {
                mustLbl.font = UIFont(name: "FZQKBYSJW--GB1-0", size: 15)
            }
        } else {
            mustLbl.text = NSLocalizedString("MUST", comment: "BucketList")
            if NSLocalizedString("MUST", comment: "BucketList") == "MUST" {
                mustLbl.text = "MUST"
                mustLbl.font = UIFont(name: "FZQKBYSJW--GB1-0", size: 15)
            }
        }
    }
    
    @IBAction func doneBtnClick() {
        
        let ref = Wilddog(url: SERVER+"/BucketList/\(data.id)")
        ref.updateChildValues([
            "done": "YES",
            "doneAt": "\(Int(NSDate().timeIntervalSince1970))"
            ]
        )
    }
    
    @IBAction func editBtnClick() {
//        self.contentLbl.hidden = true
//        self.textfield.hidden = false
//        
//        self.doneBtn.hidden = true
//        self.editBtn.hidden = true
//        self.deleteBtn.hidden = true
//        
//        self.cancelBtn.hidden = false
//        self.finishBtn.hidden = false
        let v = NewBucketListItem.newBucketListItem()
        v.data = data
        v.show()
    }
    
    @IBAction func deleteBtnClick() {
        
        let ref = Wilddog(url: SERVER+"/BucketList/\(data.id)")
        ref.setValue([])
    }
    
    @IBAction func finishBtnClick() {
        
    }
    
    @IBAction func cancelBtnClick() {
        self.contentLbl.hidden = false
        self.textfield.hidden = true
        
        self.doneBtn.hidden = false
        self.editBtn.hidden = false
        self.deleteBtn.hidden = false
        
        self.cancelBtn.hidden = true
        self.finishBtn.hidden = true
    }
}
