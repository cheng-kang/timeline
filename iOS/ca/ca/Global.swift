//
//  Global.swift
//  ca
//
//  Created by Ant on 16/7/24.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

var TIMELINE = TimelineViewController.timelineViewController()
var BUCKETLIST = BucketListViewController.bucketListViewController()
var PLACES = PlacesViewController.placesViewController()
var EVENTS = EventsViewController.eventsViewController()

let LEFTMENU = SideMenuView.sideMenuView(UIImage(named: "avatar2")!)
let LISTMENU = CircularItemListMenu.circularItemListMenu()