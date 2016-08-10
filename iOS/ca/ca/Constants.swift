//
//  Constants.swift
//  ca
//
//  Created by Ant on 16/7/15.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

let PINK_THEME_COLOR = UIColor(red: 194/255, green: 96/255, blue: 111/255, alpha: 1)
let BLUE_THEME_COLOR = UIColor(red: 93/255, green: 158/255, blue: 161/255, alpha: 1)
let GREY_THEME_COLOR = UIColor(red: 233/255, green: 234/255, blue: 233/255, alpha: 1)
let GREEN_THEME_COLOR = UIColor(red: 93/255, green: 158/255, blue: 161/255, alpha: 1)
let GREEN_THEME_COLOR_SEVENTY = UIColor(red: 93/255, green: 158/255, blue: 161/255, alpha: 0.7)
let GREEN_THEME_COLOR_DARK = UIColor(red: 70/255, green: 127/255, blue: 129/255, alpha: 1)

class THEME: NSObject {
    var BgDarkColor = UIColor(red: 2/255, green: 188/255, blue: 152/255, alpha: 1)
    var BgColor = UIColor(red: 40/255, green: 221/255, blue: 186/255, alpha: 1)
    var BgLightColor = UIColor(red: 107/255, green: 250/255, blue: 222/255, alpha: 1)
    var WhiteColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    var SpecialColor = UIColor(red: 16/255, green: 194/255, blue: 231/255, alpha: 1)
    var TextMainColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    var TextSubColor = UIColor(red: 114/255, green: 114/255, blue: 114/255, alpha: 1)
    var ContainnerBgColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
    
    func textMainColor(alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: alpha)
    }
}