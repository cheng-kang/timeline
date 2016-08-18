//
//  TDCell1.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDCell1: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var locationLbl: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    
    var content: String! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var contentLblHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
