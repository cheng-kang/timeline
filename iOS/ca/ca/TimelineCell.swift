//
//  TimelineCell.swift
//  ca
//
//  Created by Ant on 16/7/14.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    @IBOutlet weak var leftIconView: CircularView!
    @IBOutlet weak var leftIconImg: UIImageView!
    @IBOutlet weak var avatarImg: RoundedCornerImage!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var snippetBgView: UIView!
    @IBOutlet weak var snippetLeftImg: UIImageView!
    @IBOutlet weak var snippetRightView: UIView!
    @IBOutlet weak var snippetRightLocationBtn: UIButton!
    @IBOutlet weak var snippetRightContentLbl: UILabel!
    @IBOutlet weak var snippetRightCommentCountLbl: UILabel!
    @IBOutlet weak var snippetRightTypeLbl: UILabel!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var coverLbl: UILabel!
    
    var shouldFold = false
    
    func checkShouldFold() {
        if !shouldFold {
            self.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0)
            self.snippetBgView.layer.transform = CATransform3DIdentity
            self.snippetBgView.layer.anchorPoint = CGPointMake(0.5,0.5)
        }
    }
    
    var originalFrame: CGRect?
    
    var isFolded = false
    
    func initCell(username: String, avatarImage: UIImage, title: String, content:String, time: String, location: String, coverImage: String, type: String, subtype: String, commentCount: Int, backgroundColor: UIColor, icon: UIImage) {
        
        self.avatarImg.image = avatarImage
        
        var desc = ""
        switch type {
        case "Event":
            desc = "\(username) created an event \"\(title)\".    \(time)"
            break
        case "Wish":
            desc = "\(username) added a wish \"\(title)\".    \(time)"
            break
        case "Life":
            desc = "\(username) posted a \(subtype)\(subtype == "Moment" ? "" : " \""+title+"\"").    \(time)"
            break
        default:
            desc = "Opps!"
        }
        self.descLbl.text = desc
        
        
        // cover image
        self.coverView.hidden = false
        
        self.coverLbl.textColor = backgroundColor
        
        self.coverLbl.text = getTypeLblText(type, subtype: subtype)
        
        if coverImage != "" {
            
            getImageById(coverImage, complete: { (image) in
                if image != nil {
                    self.coverView.hidden = true
                    self.snippetLeftImg.image = image
                }
            })
        }
        
        self.snippetRightLocationBtn.setTitle(location, forState: .Normal)
        self.snippetRightContentLbl.text = content
        self.snippetRightCommentCountLbl.text = "\(commentCount)"
        self.snippetRightTypeLbl.text = type == "Life" ? subtype : type
        
        self.leftIconView.backgroundColor = backgroundColor
        self.snippetBgView.backgroundColor = backgroundColor
        
        self.leftIconImg.image = icon.imageWithRenderingMode(.AlwaysTemplate)
        self.leftIconImg.tintColor = UIColor.whiteColor()
    }
    
    func foldSnippet() {
//        if !isFolded {
            var transform = CATransform3DIdentity
            transform.m34 = -1/500
            transform = CATransform3DRotate(transform, -45 * CGFloat(M_PI) / 180, 1, 0, 0)
            self.snippetBgView.layer.transform = transform
//        }
    }
    
    func unfoldSnippet() {
//        if isFolded {
            self.snippetBgView.layer.transform = CATransform3DIdentity
//        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.snippetLeftImg.clipsToBounds = true
        self.snippetRightContentLbl.sizeToFit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
