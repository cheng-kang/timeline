//
//  PhotoCell.swift
//  ca
//
//  Created by Ant on 16/7/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var datetimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initCell(imageId: String, location: String, datetime: String) {
        getImageByIdAndLocation(imageId, location: location) { (image) in
            self.photoImg.image = image
        }
        
        self.datetimeLbl.text = datetime
    }
}
