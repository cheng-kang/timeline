//
//  TimelineComment.swift
//  CA
//
//  Created by Ant on 16/8/9.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation

class TimelineComment: NSObject {
    var id: String?
    var userId: String?
    var content: String?
    var createAt: String? {
        didSet {
            
            let date = NSDate(timeIntervalSince1970: Double(createAt!)!)
            let df = NSDateFormatter()
            df.dateFormat = "HH:mm"
            self.time = df.stringFromDate(date)
            df.dateFormat = "dd-MM-yyyy"
            self.date = df.stringFromDate(date)
        }
    }
    
    // eg: 17:32
    var time: String?
    // eg: 23/May/2016
    var date: String?
    
    
}