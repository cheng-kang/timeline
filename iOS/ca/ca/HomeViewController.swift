//
//  ViewController.swift
//  ca
//
//  Created by Ant on 16/7/12.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import CoreLocation
import Wilddog

class HomeViewController: UIViewController {

    @IBOutlet weak var containnerView: UIScrollView!
    @IBOutlet var tabLbls: [UILabel]!
    
    var selectedTab = "L" {
        didSet {
            for item in tabLbls {
                if item.text == selectedTab {
                    UIView.animateWithDuration(0.6, delay: 0, options: [.CurveEaseOut], animations: {
                        
                        item.font = UIFont(name: "FZYANS_JW--GB1-0", size: 22)
                        item.alpha = 1
                        }, completion: { (_) in
                    })
                } else {
                    UIView.animateWithDuration(0.6, delay: 0, options: [.CurveEaseOut], animations: {
                        
                        item.font = UIFont(name: "FZYANS_JW--GB1-0", size: 17)
                        item.alpha = 0.7
                        }, completion: { (_) in
                    })
                }
            }
        }
    }
    
    
    let ipc = ImagePickerController()
    let cl = CLLocationManager()
    let gc = CLGeocoder()
    var location = NSLocalizedString("Unknown", comment: "Location")
    
    let ref = Wilddog(url: SERVER)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get location
        cl.delegate = self
        cl.requestWhenInUseAuthorization()
        cl.desiredAccuracy = kCLLocationAccuracyBest
        cl.distanceFilter = 10
        cl.requestLocation()
        
        ipc.delegate = self
        
        ref.observeAuthEventWithBlock { (authdata) in
            if authdata != nil {
                self.setUpUI()
            } else {
                let vc = LoginViewController.vc()
                self.presentViewController(vc, animated: true, completion: { 
                })
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    let mainContent1 = TimelineViewController.timelineViewController()
    let mainContent2 = BucketListViewController.bucketListViewController()
    let mainContent3 = PlacesViewController.placesViewController()
    let mainContent4 = EventsViewController.eventsViewController()
    
    func setUpUI() {
        self.selectedTab = "L"
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        
        let topBarAlpha: CGFloat = 1
        let topBarTitleFont = UIFont(name: "Didot", size: 22)
        
        // TimelineViewController
        let topBar1 = UIView()
        topBar1.backgroundColor = GREEN_THEME_COLOR
        topBar1.alpha = topBarAlpha
        topBar1.frame = CGRectMake(0, 0, screenWidth, 50)
        
        let topBarTitle1 = UILabel()
        topBarTitle1.text = NSLocalizedString("Life - timeline", comment: "Nav Title")
        topBarTitle1.textColor = UIColor.whiteColor()
        topBarTitle1.font = topBarTitleFont
        topBarTitle1.sizeToFit()
        topBarTitle1.frame = CGRectMake(8, 42 - topBarTitle1.frame.height, topBarTitle1.frame.width, topBarTitle1.frame.height)
        
        topBar1.addSubview(topBarTitle1)
        
        let topBarBtn1 = UIButton()
        topBarBtn1.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn1.setTitle("", forState: .Normal)
        topBarBtn1.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn1.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar1.addSubview(topBarBtn1)
        
        topBarBtn1.addTarget(self, action: #selector(HomeViewController.topBarBtn1Click(_:)), forControlEvents: .TouchUpInside)
        
        mainContent1.view.frame = CGRectMake(0, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent1)
        self.containnerView.addSubview(topBar1)
        self.containnerView.addSubview(mainContent1.view)
        mainContent1.didMoveToParentViewController(self)
        
        // BucketListViewController
        let topBar2 = UIView()
        topBar2.backgroundColor = GREEN_THEME_COLOR
        topBar2.alpha = topBarAlpha
        topBar2.frame = CGRectMake(screenWidth, 0, screenWidth, 50)
        
        let topBarTitle2 = UILabel()
        topBarTitle2.text = NSLocalizedString("Oh!!! - bucket list", comment: "Nav Title")
        topBarTitle2.textColor = UIColor.whiteColor()
        topBarTitle2.font = topBarTitleFont
        topBarTitle2.sizeToFit()
        topBarTitle2.frame = CGRectMake(8, 42 - topBarTitle2.frame.height, topBarTitle2.frame.width, topBarTitle2.frame.height)
        
        topBar2.addSubview(topBarTitle2)
        
        let topBarBtn2 = UIButton()
        topBarBtn2.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn2.setTitle("", forState: .Normal)
        topBarBtn2.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn2.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar2.addSubview(topBarBtn2)
        
        topBarBtn2.addTarget(self, action: #selector(HomeViewController.topBarBtn2Click(_:)), forControlEvents: .TouchUpInside)
        
        mainContent2.view.frame = CGRectMake(screenWidth, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent2)
        self.containnerView.addSubview(topBar2)
        self.containnerView.addSubview(mainContent2.view)
        mainContent2.didMoveToParentViewController(self)
        
        // PlacesViewController
        let topBar3 = UIView()
        topBar3.backgroundColor = GREEN_THEME_COLOR
        topBar3.alpha = topBarAlpha
        topBar3.frame = CGRectMake(screenWidth*2, 0, screenWidth, 50)
        
        let topBarTitle3 = UILabel()
        topBarTitle3.text = NSLocalizedString("Visited - photos", comment: "Nav Title")
        topBarTitle3.textColor = UIColor.whiteColor()
        topBarTitle3.font = topBarTitleFont
        topBarTitle3.sizeToFit()
        topBarTitle3.frame = CGRectMake(8, 42 - topBarTitle3.frame.height, topBarTitle3.frame.width, topBarTitle3.frame.height)
        
        topBar3.addSubview(topBarTitle3)
        
        let topBarBtn3 = UIButton()
        topBarBtn3.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn3.setTitle("", forState: .Normal)
        topBarBtn3.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn3.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar3.addSubview(topBarBtn3)
        
        topBarBtn3.addTarget(self, action: #selector(HomeViewController.topBarBtn3Click(_:)), forControlEvents: .TouchUpInside)
        
        mainContent3.view.frame = CGRectMake(screenWidth*2, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent3)
        self.containnerView.addSubview(topBar3)
        self.containnerView.addSubview(mainContent3.view)
        mainContent3.didMoveToParentViewController(self)
        
        // EventsViewController
        let topBar4 = UIView()
        topBar4.backgroundColor = GREEN_THEME_COLOR
        topBar4.alpha = topBarAlpha
        topBar4.frame = CGRectMake(screenWidth*3, 0, screenWidth, 50)
        
        let topBarTitle4 = UILabel()
        topBarTitle4.text = NSLocalizedString("Events - alerts", comment: "Nav Title")
        topBarTitle4.textColor = UIColor.whiteColor()
        topBarTitle4.font = topBarTitleFont
        topBarTitle4.sizeToFit()
        topBarTitle4.frame = CGRectMake(8, 42 - topBarTitle4.frame.height, topBarTitle4.frame.width, topBarTitle4.frame.height)
        
        topBar4.addSubview(topBarTitle4)
        
        let topBarBtn4 = UIButton()
        topBarBtn4.setImage(UIImage(named: "Plus"), forState: .Normal)
        topBarBtn4.setTitle("", forState: .Normal)
        topBarBtn4.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        topBarBtn4.frame = CGRectMake(self.view.frame.width - 50, 0, 50, 50)
        
        topBar4.addSubview(topBarBtn4)
        topBarBtn4.addTarget(self, action: #selector(HomeViewController.topBarBtn4Click(_:)), forControlEvents: .TouchUpInside)
        
        mainContent4.view.frame = CGRectMake(screenWidth*3, 50, screenWidth, screenHeight - 100)
        
        self.addChildViewController(mainContent4)
        self.containnerView.addSubview(topBar4)
        self.containnerView.addSubview(mainContent4.view)
        mainContent4.didMoveToParentViewController(self)
        
        self.containnerView.delegate = self
        self.containnerView.contentSize = CGSize(width: screenWidth*4, height: screenHeight-50)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    func topBarBtn1Click(sender: UIButton) {
        let vc = NewTimelineViewController.newTimelineViewController()
        self.presentViewController(vc, animated: true) {
        }
    }
    
    func topBarBtn2Click(sender: UIButton) {
        let view = NewBucketListItem.newBucketListItem()
        view.show()
    }
    
    func topBarBtn3Click(sender: UIButton) {
        self.presentViewController(ipc, animated: true) {
        }
    }
    
    func topBarBtn4Click(sender: UIButton) {
        let vc = NewEventViewController.newEventViewController()
        self.presentViewController(vc, animated: true) {
        }
    }
    
    let switchTabDuration = 0.3
    @IBAction func firstTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = 0
            }) { (_) in
        }
    }
    
    @IBAction func secondTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = self.view.frame.width
        }) { (_) in
        }
    }
    
    @IBAction func thirdTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = self.view.frame.width * 2
        }) { (_) in
        }
    }

    @IBAction func fourthTabClick(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(switchTabDuration, delay: 0, options: [.CurveEaseOut], animations: {
            self.containnerView.contentOffset.x = self.view.frame.width * 3
        }) { (_) in
        }
    }
}

extension HomeViewController: ImagePickerDelegate {
    
    func wrapperDidPress(imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(imagePicker: ImagePickerController, images: [UIImage]) {
        let timelineRef = Wilddog(url: SERVER+"/Timeline")
        let photosRef = Wilddog(url: SERVER+"/Photos/\(self.location)")
        
        print("Creating timeline...")
        let newTimelineRef = timelineRef.childByAutoId()
        
        var timelineDataImages = [String: String]()
        timelineDataImages["count"] = "\(images.count)"
        for i in 0..<images.count {
            timelineDataImages["\(i)"] = ""
        }
        
        let timelineData = [
            "userId": "husband",
            "type": "Visited",
            "subtype": "",
            "title": "",
            "content": "\(images.count) "+(images.count > 1 ? NSLocalizedString("Photo", comment: "Timeline") :NSLocalizedString("Photos", comment: "Timeline")),
            "images": timelineDataImages,
            "location": self.location,
            "icon": 0,
            "bgColor": 0,
            "createAt": "\(NSDate().timeIntervalSince1970)",
            "updateAt": "\(NSDate().timeIntervalSince1970)",
            "messages": "",
            "comments": "",
            ]
        
        newTimelineRef.setValue(timelineData) { (error, ntRef) in
            if error != nil {
                print(error)
                return
            }
            
            print("Start uploading images...")
            
            if images.count == 0 {
                print("No image.")
                return
            }
            
            for i in 0..<images.count {
                
                print("Uploading image-\(i+1)...")
                
                let imageData = images[i].mediumQualityJPEGNSData
                
                let newPhotoRef = photosRef.childByAutoId()
                let newPhotoData = [
                    "createAt": NSDate().timeIntervalSince1970,
                    "timeline": ntRef.key
                ]
                newPhotoRef.setValue(newPhotoData, withCompletionBlock: { (error, npRef) in
                    
                    print("Image-\(i+1)(id: \(npRef.key)) Created.")
                    
                    let length = imageData.length
                    let chunkSize = 600000      // 1mb chunk sizes 1048576
                    print("Image chunk size is \(chunkSize) bytes.")
                    var offset = 0
                    var count = 0
                    
                    repeat {
                        
                        print("Uploading image-\(i+1)-chunk-\(count+1)...")
                        
                        // get the length of the chunk
                        let thisChunkSize = ((length - offset) > chunkSize) ? chunkSize : (length - offset)
                        
                        // get the chunk
                        let chunk = imageData.subdataWithRange(NSMakeRange(offset, thisChunkSize))
                        
                        // -----------------------------------------------
                        // do something with that chunk of data...
                        // -----------------------------------------------
                        npRef.updateChildValues(["\(count)": chunk.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)], withCompletionBlock: { (error, countRef) in
                            if error != nil {
                                print(error)
                                return
                            }
                            print("Finished uploading image-\(i+1)-chunk-\(count+1).")
                        })
                        
                        // update the offset
                        offset += thisChunkSize
                        count += 1
                    } while (offset < length);
                    
                    print("Finished uploading image-\(i+1)(\(count) chunk(s)).")
                    
                    npRef.updateChildValues(["count": count])
                    ntRef.childByAppendingPath("images").updateChildValues(["\(i)":npRef.key])
                })
            }
        }
        
        imagePicker.dismissViewControllerAnimated(true) {
        }
    }
    
    func cancelButtonDidPress(imagePicker: ImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true) {
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        gc.reverseGeocodeLocation(locations.first!) { (placemark, error) in
            if error != nil {
                print(error)
                return
            }
            
            let address = (placemark?.first?.addressDictionary)!
            
            self.location = (address["State"] as! String) + ", " + (address["Country"] as! String)
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.containnerView {
            let index = Int(round(scrollView.contentOffset.x / self.view.frame.width))
            self.selectedTab = self.tabLbls[index].text!
        }
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
}