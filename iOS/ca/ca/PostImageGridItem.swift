//
//  PostImageGridItem.swift
//  ca
//
//  Created by Ant on 16/7/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PostImageGridItem: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    var index = 0
    
    var plusBtnClickClosure: (()->())?
    var deleteBtnClickClosure: ((index: Int)->())?
    
    var hasImg = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.borderColor = GREY_THEME_COLOR.CGColor
        img.layer.borderWidth = 1
        img.clipsToBounds = true
        self.clipsToBounds = true
    }
    
    class func postImageGridItem() -> PostImageGridItem {
        
        let postImageGridItem = NSBundle.mainBundle().loadNibNamed("PostImageGridItem", owner: nil, options: nil).first as! PostImageGridItem
        
        return postImageGridItem
    }
    
    func setImage(img: UIImage) {
        self.img.image = img
        hasImg = true
    }
    
    func show() {
        self.alpha = 1
        
        if hasImg {
            plusBtn.hidden = true
            cancelBtn.hidden = false
        } else {
            plusBtn.hidden = false
            cancelBtn.hidden = true
        }
    }
    
    func hide() {
        self.alpha = 0
        
        self.hasImg = false
    }
    
    @IBAction func plusBtnClick(sender: UIButton) {
        plusBtnClickClosure!()
    }
    
    @IBAction func deleteBtnClick(sender: UIButton) {
        self.img.image = nil
        deleteBtnClickClosure!(index: index)
    }

}
