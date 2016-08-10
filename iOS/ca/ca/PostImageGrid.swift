//
//  PostImageGrid.swift
//  ca
//
//  Created by Ant on 16/7/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PostImageGrid: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var gridItems: [PostImageGridItem]!
    
    var imgs = [UIImage]() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        imgs.append(UIImage(named: "avatar1")!)
//        imgs.append(UIImage(named: "avatar1")!)
//        imgs.append(UIImage(named: "avatar1")!)
        updateView()
        
    }
    
    class func postImageGrid() -> PostImageGrid {
        
        let postImageGrid = NSBundle.mainBundle().loadNibNamed("PostImageGrid", owner: nil, options: nil).first as! PostImageGrid
        
        return postImageGrid
    }
    
    func updateView() {
        for i in 0..<9 {
            gridItems[i].img.image = nil
        }
        
        for i in 0..<imgs.count {
            gridItems[i].index = i
            gridItems[i].setImage(imgs[i])
            gridItems[i].show()
        }
        
        for i in imgs.count..<9 {
            gridItems[i].hide()
        }
        
        if imgs.count < 9 {
            gridItems[imgs.count].show()
        }
    }

}
