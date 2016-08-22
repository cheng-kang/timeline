//
//  Timeline.swift
//  CA
//
//  Created by Ant on 16/8/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

class Timeline: NSObject {
    var id:String!
    var userId: String = ""
    var type:String = ""
    var subtype:String = ""
    var title: String = ""
    var content: String = ""
    var location: String = ""
    var images: [String: AnyObject]! {
        didSet {
            if let count = images!["count"] {
                imageIdList.removeAll()
                for i in 0..<Int(count as! String)! {
                    imageIdList.append(images!["\(i)"] as! String)
                }
            }
        }
    }
    var imageIdList = [String]()
    var iconIndex: Int = 0 {
        didSet {
            switch self.type {
            case "Life":
                icon = UIImage(named: ICON_NAMES[iconIndex])
            case "Event":
                icon = UIImage(named: ICON_NAMES[27])
            case "Visited":
                icon = UIImage(named: ICON_NAMES[imageIdList.count > 1 ? 20 : 5])
            case "Wish":
                icon = UIImage(named: ICON_NAMES[15])
            default:
                icon = UIImage(named: ICON_NAMES[iconIndex])
            }
        }
    }
    var icon: UIImage!
    
    let randomIndex = Int(arc4random_uniform(UInt32(BG_COLORS.count)))
    var bgColorIndex: Int = 0 {
        didSet {
            switch self.type {
            case "Life":
                bgColor = BG_COLORS[bgColorIndex]
            case "Event":
                bgColor = BG_COLORS[randomIndex]
            case "Visited":
                bgColor = BG_COLORS[randomIndex]
            case "Wish":
                bgColor = BG_COLORS[randomIndex]
            default:
                bgColor = BG_COLORS[randomIndex]
            }
        }
    }
    var bgColor: UIColor!
    var createAt: String = "" {
        didSet {
            
            let date = NSDate(timeIntervalSince1970: Double(createAt)!)
            let df = NSDateFormatter()
            df.dateFormat = "HH:mm"
            self.time = df.stringFromDate(date)
            df.dateFormat = "dd-MM-yyyy"
            self.date = df.stringFromDate(date)
            df.dateFormat = "yyyy-MM-dd HH:mm"
            self.datetime = df.stringFromDate(date)
            df.dateFormat = "EEEE / MMM dd / yyyy"
            self.dateAndWeekday = df.stringFromDate(date)
        }
    }
    var updateAt: String = ""
    var messages: [String:AnyObject]! {
        didSet {
            if messages != nil{
                var tempList = [TimelineComment]()
                for (key, value) in messages! {
                    let data = value as! [String: String]
                    let temp = TimelineComment()
                    temp.id = key
                    temp.userId = data["userId"]
                    temp.content = data["content"]
                    temp.createAt = data["createAt"]
                    tempList.append(temp)
                }
                self.messageList.removeAll()
                self.messageList = tempList
            }
        }
    }
    var comments: [String:AnyObject]! {
        didSet {
            if comments != nil{
                var tempList = [TimelineComment]()
                for (key, value) in comments! {
                    let data = value as! [String: String]
                    let temp = TimelineComment()
                    temp.id = key
                    temp.userId = data["userId"]
                    temp.content = data["content"]
                    temp.createAt = data["createAt"]
                    tempList.append(temp)
                }
                self.commentList.removeAll()
                self.commentList = tempList
            }
        }
    }
    var messageList = [TimelineComment]()
    var commentList = [TimelineComment]()
    
    
    // eg: 17:32
    var time: String = ""
    // eg: 23/May/2016
    var date: String = ""
    // 2016-12-03 13:33
    var datetime: String = ""
    // eg: Mon / Aug 17 / 2016
    var dateAndWeekday: String = ""
    
    var timeToNow: String {
        let date = NSDate(timeIntervalSince1970: Double(createAt)!)
        
        let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: date, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))
        let day = diffDateComponents.day
        let hour = diffDateComponents.hour
        let minute = diffDateComponents.minute
        let second = diffDateComponents.second
        
        if day > 10 {
            let df = NSDateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            return df.stringFromDate(date)
        } else if day > 0 {
            return "\(day)" + (day==1 ? NSLocalizedString("day", comment: "Time Label") : NSLocalizedString("days", comment: "Time Label"))
        } else if hour > 0 {
            return "\(hour)" + (hour==1 ? NSLocalizedString("hr", comment: "Time Label") : NSLocalizedString("hrs", comment: "Time Label"))
        } else if minute > 0 {
            return "\(minute)" + (minute==1 ? NSLocalizedString("min", comment: "Time Label") : NSLocalizedString("mins", comment: "Time Label"))
        } else if second > 10 {
            return "\(second)" + NSLocalizedString("s", comment: "Time Label")
        } else {
            return NSLocalizedString("just now", comment: "Time Label")
        }
    }
    
}