//
//  TopCell.swift
//  ca
//
//  Created by Ant on 16/7/25.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TopCell: UITableViewCell {

    @IBOutlet weak var iconBgView: CircularView!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
