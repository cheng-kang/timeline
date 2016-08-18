//
//  TDCell0.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDCell0: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var imgCountLbl: UILabel!
    
    var displayView = UIScrollView()
    
    var location: String?
    var photos: [String]? {
        didSet {
            if photos?.count > 0 {
                let width = UIScreen.mainScreen().bounds.width - 40
                
                for i in 0..<photos!.count {
                    let temp = UIImageView()
                    getImageByIdAndLocation(photos![i], location: location!, complete: { (image) in
                        temp.image = image
                    })
                    temp.contentMode = .ScaleAspectFill
                    temp.clipsToBounds = true
                    temp.frame = CGRectMake(width * CGFloat(i) , 0, width, 160)
                    temp.backgroundColor = UIColor.clearColor()
                    
                    self.displayView.addSubview(temp)
                }
                self.displayView.contentSize = CGSizeMake(width * CGFloat(photos!.count), 160)
                self.displayView.pagingEnabled = true
                self.displayView.showsHorizontalScrollIndicator = false
                self.displayView.showsVerticalScrollIndicator = false
                self.displayView.bounces = false
                self.displayView.frame = CGRectMake(0, 85 + 1, width, 160)
                self.displayView.alpha = 1
                
                self.addSubview(displayView)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.displayView.backgroundColor = UIColor.clearColor()
    }

}
