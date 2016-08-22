//
//  BucketListItem.swift
//  CA
//
//  Created by Ant on 16/8/12.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation

class BucketListItem: NSObject {
    var id: String!
    var userId: String!
    var content: String!
    var createAt: String!
    var done: String! {
        didSet {
            isDone = (done == "YES")
        }
    }
    var doneAt: String!
    var timeline: String!
    
    var isDone: Bool!
}