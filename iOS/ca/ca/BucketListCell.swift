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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if NSLocalizedString("MUST", comment: "BucketList") == "MUST" {
            mustLbl.text = "MUST"
            mustLbl.font = UIFont(name: "FZQKBYSJW--GB1-0", size: 15)
        }
    }
    
    func initCell(content: String) {
        contentLbl.text = content
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
