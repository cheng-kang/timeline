//
//  MonthCell.swift
//  CA
//
//  Created by Ant on 16/7/29.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class MonthCell: UICollectionViewCell {
    
    @IBOutlet weak var monthLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.monthLbl.layer.cornerRadius = self.monthLbl.frame.width / 2
        self.monthLbl.clipsToBounds = true
    }
    
    func initCell(month: String) {
        self.monthLbl.text = month
    }
}
