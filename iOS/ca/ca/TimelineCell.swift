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
    
    func initCell(timeline: Timeline) {
        
        let coverImage = (timeline.imageIdList.count) == 0 ? "" : (timeline.imageIdList.first)!
        
        self.avatarImg.image = UIImage(named: "avatar1")!
        let username = "Kang Cheng"
        
        var desc = ""
        switch timeline.type {
        case "Event":
            desc = "\(username) \(NSLocalizedString("created an event", comment: "Timeline")).    \(timeline.time)"
            break
        case "Visited":
            desc = "\(username) \(NSLocalizedString("posted", comment: "Timeline")) \(timeline.imageIdList.count > 1 ? "1 "+NSLocalizedString("Photo", comment: "Timeline") : "\(timeline.imageIdList.count) "+NSLocalizedString("Photos", comment: "Timeline")).    \(timeline.time)"
            break
        case "Wish":
            desc = "\(username) \(NSLocalizedString("added a wish", comment: "Timeline")).    \(timeline.time)"
            break
        case "Life":
            desc = "\(username) \(NSLocalizedString("posted", comment: "Timeline")) \(timeline.subtype == "Moment" ? NSLocalizedString("a Moment", comment: "Timeline") : NSLocalizedString("a Diary", comment: "Timeline")).    \(timeline.time)"
            break
        default:
            desc = NSLocalizedString("Opps!", comment: "Timeline")
        }
        self.descLbl.text = desc
        
        
        // cover image
        self.coverView.hidden = false
        
        self.coverLbl.textColor = timeline.bgColor
        
        self.coverLbl.text = getTypeLblText(timeline.type, subtype: timeline.subtype)
        
        if coverImage != "" {
            
            getImageByIdAndLocation(coverImage, location:timeline.location, complete: { (image) in
                if image != nil {
                    self.coverView.hidden = true
                    self.snippetLeftImg.image = image
                }
            })
        }  else {
            self.snippetLeftImg.image = nil
        }
        
        self.snippetRightLocationBtn.setTitle(timeline.location, forState: .Normal)
        self.snippetRightContentLbl.text = timeline.content
        self.snippetRightCommentCountLbl.text = "\(timeline.messageList.count)"
        self.snippetRightTypeLbl.text = timeline.type == "Life" ? timeline.subtype : timeline.type
        
        self.leftIconView.backgroundColor = timeline.bgColor
        self.snippetBgView.backgroundColor = timeline.bgColor
        
        self.leftIconImg.image = timeline.icon.imageWithRenderingMode(.AlwaysTemplate)
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
