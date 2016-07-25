//
//  PopUpImageViewController.swift
//  ca
//
//  Created by Ant on 16/7/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PopUpImageViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    var imageToShow: UIImage!
    var initFrame: CGRect!
    var initBounds: CGRect!
    var initCenter: CGPoint!
    let distanceToTopElement: CGFloat = 120

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.img.image = self.imageToShow
    }
    
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(1, delay: 0, options: [.CurveEaseInOut], animations: {
//            self.img.frame = self.view.frame
//            }) { (complete) in
//        }
        
        self.img.frame = initFrame
        self.img.hidden = false
        
        UIView.animateWithDuration(0.8, delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    self.img.bounds = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                                    self.img.center = CGPointMake(self.view.frame.width / 2, self.view.frame.height / 2)
                                    
            }, completion:{_ in
        })
        
        
//        let initialFrame = originalFrame!
//        let finalFrame = self.view.frame
//        
//        let xScaleFactor = finalFrame.width / initialFrame.width
//        
//        let yScaleFactor = finalFrame.height / initialFrame.height
//        
//        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
//        
////            self.img.transform = scaleTransform
//            self.img.center = CGPoint(
//                x: CGRectGetMidX(initialFrame),
//                y: CGRectGetMidY(initialFrame))
//            self.img.clipsToBounds = true
//        
//        UIView.animateWithDuration(1, delay:0.0,
//                                   usingSpringWithDamping: 0.4,
//                                   initialSpringVelocity: 0.0,
//                                   options: [],
//                                   animations: {
//                                    self.img.transform = scaleTransform
//                                    
//                                    self.img.center = CGPoint(x: CGRectGetMidX(finalFrame),
//                                        y: CGRectGetMidY(finalFrame))
//                                    
//            }, completion:{_ in
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    class func popUpImageViewController(image: UIImage, initFrame: CGRect, initBounds: CGRect, initCenter: CGPoint) -> PopUpImageViewController {
        
        let sb = UIStoryboard(name: "Places", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("PopUpImageViewController") as! PopUpImageViewController
        
        vc.imageToShow = image
        vc.initFrame = CGRectMake(initFrame.origin.x, initFrame.origin.y + vc.distanceToTopElement, initFrame.width, initFrame.height)
        vc.initBounds = initBounds
        vc.initCenter = CGPointMake(initCenter.x, initCenter.y + vc.distanceToTopElement)
        
        return vc
    }
    
    @IBAction func dismissBtnClick(sender: UIButton) {
        
//        self.img.frame = originalFrame!
//        self.img.hidden = false
        
        UIView.animateWithDuration(0.8, delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    self.img.bounds = self.initBounds
                                    self.img.center = self.initCenter
                                    self.view.alpha = 0
                                    
            }, completion:{_ in
                self.dismissViewControllerAnimated(true) {
                    self.img.image = nil
                }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
