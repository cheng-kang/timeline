//
//  YearCell.swift
//  CA
//
//  Created by Ant on 16/7/29.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class YearCell: UICollectionViewCell {
    
    @IBOutlet weak var yearLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func initCell(year: String) {
        self.yearLbl.text = year
    }
}
