//
//  PlaceCell.swift
//  ca
//
//  Created by Ant on 16/7/16.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    @IBOutlet weak var descTagView: UIView!
    @IBOutlet weak var descTagLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.descTagView.layer.cornerRadius = self.descTagView.frame.height / 2
//        self.descTagView.alpha = 0.3
        self.descTagView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.descTagLbl.alpha = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(imageId: String, location: String, photoCount: Int) {
        
        getImageByIdAndLocation(imageId, location: location, complete: { (image) in
            self.img.image = image
        })
        self.locationLbl.text = location
        self.descTagLbl.text = "\(photoCount) photos"
    }

}
