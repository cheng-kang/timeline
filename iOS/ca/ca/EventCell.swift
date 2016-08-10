//
//  EventCell.swift
//  CA
//
//  Created by Ant on 16/7/28.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var weekdayLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.cardView.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.cardView.layer.borderColor = THEME().textMainColor(0.8).CGColor
        self.cardView.layer.borderWidth = 1
        
//        self.weekdayLbl.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.weekdayLbl.layer.borderColor = THEME().textMainColor(0.8).CGColor
        self.weekdayLbl.layer.borderWidth = 1
        self.weekdayLbl.backgroundColor = THEME().ContainnerBgColor
        
//        self.dayLbl.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.dayLbl.layer.borderColor = THEME().textMainColor(0.8).CGColor
        self.dayLbl.layer.borderWidth = 1
    }
    
    func initCell(weekday: String, day: String, time: String, content: String) {
        self.weekdayLbl.text = weekday
        self.dayLbl.text = day
        self.contentLbl.text = "\(time) \(content)"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
