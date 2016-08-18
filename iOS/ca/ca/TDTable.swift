//
//  TDTable.swift
//  CA
//
//  Created by Ant on 16/8/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TDTable: UITableView {
    
    let tableViewController = TDTableViewController()
    var data: Timeline! {
        didSet {
            tableViewController.data = data
        }
    }
    
    class func tableview(data: Timeline) -> TDTable {
        
        let vc = NSBundle.mainBundle().loadNibNamed("TDTable", owner: nil, options: nil).first as! TDTable
        vc.data = data
        return vc
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = tableViewController
        self.dataSource = tableViewController
        
        self.registerNib(UINib(nibName: "TDCell0", bundle: nil), forCellReuseIdentifier: "TDCell0")
        self.registerNib(UINib(nibName: "TDCell1", bundle: nil), forCellReuseIdentifier: "TDCell1")
        self.registerNib(UINib(nibName: "TDCell3", bundle: nil), forCellReuseIdentifier: "TDCell3")
    }

}
