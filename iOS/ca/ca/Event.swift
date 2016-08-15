//
//  Event.swift
//  CA
//
//  Created by Ant on 16/8/15.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation

class Event: NSObject {
    var id: String!
    var userId: String!
    var content: String!
    var createAt: String!
    var alarmAt: String! {
        didSet {
            let date = NSDate(timeIntervalSince1970: Double(alarmAt!)!)
            let df = NSDateFormatter()
            df.dateFormat = "EEEE / MMM dd / yyyy"
            alarmDate = df.stringFromDate(date)
            df.dateFormat = "EEEE"
            alarmWeekday = df.stringFromDate(date)
            df.dateFormat = "dd"
            alarmDay = df.stringFromDate(date)
            df.dateFormat = "HH:mm"
            alarmTime = df.stringFromDate(date)
        }
    }
    
    var alarmWeekday: String!
    var alarmDay: String!
    var alarmTime: String!
    var alarmDate: String!
    var alarmCountDown: String! {
        let date = NSDate(timeIntervalSince1970: Double(alarmAt!)!)
        
        let interval = date.timeIntervalSinceNow
        if interval <= 0 {
            return "OVER"
        } else {
            let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: NSDate(), toDate: date, options: NSCalendarOptions.init(rawValue: 0))
            
            let day = diffDateComponents.day == 0 ?  "" : "\(diffDateComponents.day)days "
            let hour = diffDateComponents.hour < 10 ? "0\(diffDateComponents.hour)" : "\(diffDateComponents.hour)"
            let minute = diffDateComponents.minute < 10 ? "0\(diffDateComponents.minute)" : "\(diffDateComponents.minute)"
            let second = diffDateComponents.second < 10 ? "0\(diffDateComponents.second)" : "\(diffDateComponents.second)"
            
            return "\(day)\(hour):\(minute):\(second)"
        }
    }
    
}