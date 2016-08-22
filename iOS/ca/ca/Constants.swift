//
//  Constants.swift
//  ca
//
//  Created by Ant on 16/7/15.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

let SERVER = "https://weizhimiao.wilddogio.com"

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

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

class FLAT_UI_COLOR: NSObject {
    var TURQUOISE = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
    var GREEN_SEA = UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 1)
    var EMERALD = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    var NEPHRITIS = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
    var PETER_RIVER = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    var BELIZE_HOLE = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
    var AMETHYST = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1)
    var WISTERIA = UIColor(red: 142/255, green: 68/255, blue: 173/255, alpha: 1)
    var WET_ASPHALT = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
    var MIDNIGHT_BULE = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
    var SUN_FLOWER = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
    var ORANGE = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1)
    var CARROT = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)
    var PUMPKIN = UIColor(red: 211/255, green: 84/255, blue: 0/255, alpha: 1)
    var ALIZARIN = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
    var POMEGRANATE = UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1)
    var CLOUDS = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
    var SILVER = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    var CONCRETE = UIColor(red: 149/255, green: 165/255, blue: 166/255, alpha: 1)
    var ASBESTOS = UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 1)
}

class J_GREEN: NSObject {
    var SEIHEKI = UIColor(red: 38/255, green: 135/255, blue: 133/255, alpha: 1)
    var ASAGI = UIColor(red: 51/255, green: 166/255, blue: 184/255, alpha: 1)
    var TSUYUKUSA = UIColor(red: 46/255, green: 169/255, blue: 223/255, alpha: 1)
    var SORA = UIColor(red: 88/255, green: 178/255, blue: 220/255, alpha: 1)
    var SEIJI = UIColor(red: 105/255, green: 176/255, blue: 172/255, alpha: 1)
    var MIZUASAGI = UIColor(red: 102/255, green: 186/255, blue: 183/255, alpha: 1)
    var BAYAKUGUN = UIColor(red: 120/255, green: 194/255, blue: 196/255, alpha: 1)
    var MIZU = UIColor(red: 129/255, green: 199/255, blue: 212/255, alpha: 1)
    var KAMENOZOKI = UIColor(red: 165/255, green: 222/255, blue: 228/255, alpha: 1)
}



let BG_COLORS: [UIColor] = [J_GREEN().SEIHEKI,
                            J_GREEN().ASAGI,
                            J_GREEN().TSUYUKUSA,
                            J_GREEN().SORA,
                            J_GREEN().SEIJI,
                            J_GREEN().MIZUASAGI,
                            J_GREEN().BAYAKUGUN,
                            J_GREEN().MIZU,
                            J_GREEN().KAMENOZOKI
]
//let BG_COLORS: [UIColor] = [FLAT_UI_COLOR().TURQUOISE,
//                           FLAT_UI_COLOR().GREEN_SEA,
//                           FLAT_UI_COLOR().EMERALD,
//                           FLAT_UI_COLOR().NEPHRITIS,
//                           FLAT_UI_COLOR().PETER_RIVER,
//                           FLAT_UI_COLOR().BELIZE_HOLE,
//                           FLAT_UI_COLOR().AMETHYST,
//                           FLAT_UI_COLOR().WISTERIA,
//                           FLAT_UI_COLOR().WET_ASPHALT,
//                           FLAT_UI_COLOR().MIDNIGHT_BULE,
//                           FLAT_UI_COLOR().SUN_FLOWER,
//                           FLAT_UI_COLOR().ORANGE,
//                           FLAT_UI_COLOR().CARROT,
//                           FLAT_UI_COLOR().PUMPKIN,
//                           FLAT_UI_COLOR().ALIZARIN,
//                           FLAT_UI_COLOR().POMEGRANATE,
//                           FLAT_UI_COLOR().CLOUDS,
//                           FLAT_UI_COLOR().SILVER,
//                           FLAT_UI_COLOR().CONCRETE,
//                           FLAT_UI_COLOR().ASBESTOS,
//]

let ICON_NAMES: [String] = ["Bicycle Green", "Birthday Green", "Bridal Bouquet Green", "Bride Filled Green", "Butterfly Green", "Camera Green", "Cards Green", "Champagne Green", "Christmas Gift Green", "Christmas Star Green", "Christmas Tree Green", "Cool Green", "Date Man Woman Green", "Double Bed Green", "Groom Green", "Heart Balloon Green", "Heart With Arrow Green", "In Love Green", "Kiss Green", "Sad Green", "Stack of Photos Green", "Tie Green", "Two Hearts Green", "Wedding Cake Green", "Wedding Day Green", "Wedding Gift Green", "Women`s Shoe Green", "Alarm Clock Green"]
















