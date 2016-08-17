//
//  Photo.swift
//  CA
//
//  Created by Ant on 16/8/12.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

class Photo: NSObject {
    var id: String!
    var image: UIImage?
    var createAt: String!{
        didSet {
            let date = NSDate(timeIntervalSince1970: Double(createAt!)!)
            let df = NSDateFormatter()
            df.dateFormat = "HH:mm"
            self.time = df.stringFromDate(date)
            df.dateFormat = "dd-MM-yyyy"
            self.date = df.stringFromDate(date)
            df.dateFormat = "yyyy.MM.dd"
            self.formattedDatetime = df.stringFromDate(date)
        }
    }
    
    var time: String!
    var date: String!
    var formattedDatetime: String!
}
