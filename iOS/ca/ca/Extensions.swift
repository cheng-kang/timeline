//
//  Extensions.swift
//  CA
//
//  Created by Ant on 16/7/28.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func heightThatFitsContent() -> CGFloat {
        let fixedWidth = self.frame.width
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        
        return newSize.height
    }
}

extension String {
    func dateString() -> String {
        // eg: 2018-03-05 08:12:13
        
        let df1 = NSDateFormatter()
        df1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = df1.dateFromString(self) {
            let df2 = NSDateFormatter()
            df2.dateFormat = "EEEE / MMM dd / yyyy"
            
            return df2.stringFromDate(date)
        }
        
        return ""
    }
    
    func timeString() -> String {
        let df1 = NSDateFormatter()
        df1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = df1.dateFromString(self) {
            let df2 = NSDateFormatter()
            df2.dateFormat = "HH:mm"
            
            return df2.stringFromDate(date)
        }
        
        return ""
    }
    
    func countDownSinceNowString() -> String {
        
        let df1 = NSDateFormatter()
        df1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = df1.dateFromString(self) {
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
        
        return ""
        
    }
    
    func dataFromHexadecimalString() -> NSData? {
        let data = NSMutableData(capacity: characters.count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .CaseInsensitive)
        regex.enumerateMatchesInString(self, options: [], range: NSMakeRange(0, characters.count)) { match, flags, stop in
            let byteString = (self as NSString).substringWithRange(match!.range)
            var num = UInt8(byteString, radix: 16)
            data?.appendBytes(&num, length: 1)
        }
        
        return data
    }
    
    func heightThatFitsContentByWidth(width: CGFloat) -> CGFloat {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = self
        let newSize = lbl.sizeThatFits(CGSize(width: width, height: CGFloat(MAXFLOAT)))
        
        return newSize.height
    }
}

extension UIImage {
    var uncompressedPNGData: NSData      { return UIImagePNGRepresentation(self)!        }
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:NSData   { return UIImageJPEGRepresentation(self, 0.0)!  }
}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.startIndex.advancedBy(self.location)
        let endIndex = startIndex.advancedBy(self.length)
        return startIndex..<endIndex
    }
}