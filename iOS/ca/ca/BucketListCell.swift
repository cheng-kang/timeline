//
//  BucketListCell.swift
//  CA
//
//  Created by Ant on 16/7/31.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class BucketListCell: UITableViewCell {

    @IBOutlet weak var mustLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    var data: BucketListItem!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func initCell(data: BucketListItem) {
        self.data = data
        contentLbl.text = data.content
        
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
