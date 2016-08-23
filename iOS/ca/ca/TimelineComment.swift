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
            df.dateFormat = "yyyy-MM-dd HH:mm"
            self.datetime = df.stringFromDate(date)
        }
    }
    
    // eg: 17:32
    var time: String?
    // eg: 23/May/2016
    var date: String?
    // eg: 2016-08-12 12:33
    var datetime: String?
    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(self.id, forKey: "id")
//        aCoder.encodeObject(self.userId, forKey: "userId")
//        aCoder.encodeObject(self.content, forKey: "content")
//        aCoder.encodeObject(self.createAt, forKey: "createAt")
//    }
//    
//    override init() {
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        self.id = aDecoder.decodeObjectForKey("id") as! String
//        self.userId = aDecoder.decodeObjectForKey("userId") as! String
//        self.content = aDecoder.decodeObjectForKey("content") as! String
//        self.createAt = aDecoder.decodeObjectForKey("createAt") as! String
//    }
    
}