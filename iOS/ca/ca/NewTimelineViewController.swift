//
//  NewTimelineViewController.swift
//  ca
//
//  Created by Ant on 16/7/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import CoreLocation
import Wilddog

class NewTimelineViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var textviewPlaveholderLbel: UILabel!
    @IBOutlet weak var postImageGrid: PostImageGrid!
    
    
    @IBOutlet weak var btnBar: UIView!
    var btnBarY: CGFloat = 0
    @IBOutlet weak var emojiBtn: UIButton!
    @IBOutlet weak var hideKeyboardBtn: UIButton!
    @IBOutlet weak var bgColorBtn: UIButton!
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var modalBtn: UIButton!
    @IBOutlet weak var selectPanel: UICollectionView!
    
    // false: is selecting bgcolor
    var isSelectingIcon = false
    var selectedBgColorIndex = 0 {
        didSet {
            self.bgColorBtn.setTitleColor(BG_COLORS[selectedBgColorIndex], forState: .Normal)
        }
    }
    var selectedIconIndex = 0 {
        didSet {
            self.iconBtn.setImage(UIImage(named: ICON_NAMES[selectedIconIndex]), forState: .Normal)
        }
    }
    
    
    let ipc = ImagePickerController()
    let cl = CLLocationManager()
    let gc = CLGeocoder()
    var location = NSLocalizedString("Unknown", comment: "Location")
    
    var pickedImages = [UIImage]() {
        didSet {
            if pickedImages != oldValue {
                self.postImageGrid.imgs = pickedImages
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textview.layer.borderWidth = 1
        textview.layer.borderColor = GREY_THEME_COLOR.CGColor
        textview.delegate = self
        
        selectPanel.delegate = self
        selectPanel.dataSource = self
        
        selectedBgColorIndex = 0
        selectedIconIndex = 0
        // Do any additional setup after loading the view.
        
        // get location
        cl.delegate = self
        cl.requestWhenInUseAuthorization()
        cl.desiredAccuracy = kCLLocationAccuracyBest
        cl.distanceFilter = 10
        cl.requestLocation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewTimelineViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        setUpUI()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.btnBarY = self.btnBar.frame.origin.y
        
//        postImageGrid.gridItems[0].frame = CGRectMake(0,0,106,106)
        for item in postImageGrid.gridItems {
            item.deleteBtnClickClosure = { index in
                self.ipc.stack.dropAsset(self.ipc.stack.assets[index])
                self.postImageGrid.imgs.removeAtIndex(index)
            }
        }
    }
    class func newTimelineViewController() -> NewTimelineViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("NewTimelineViewController") as! NewTimelineViewController
        
        return vc
    }
    
    func setUpUI() {
    }
    
    
}

// Btn Click
extension NewTimelineViewController {
    
    @IBAction func postBtnClick() {
        let timelineRef = Wilddog(url: SERVER+"/Timeline")
        let photosRef = Wilddog(url: SERVER+"/Photos/\(self.location)")
        
//                timelineRef.removeValue()
//                photosRef.removeValue()
        
        let images = self.postImageGrid.imgs
        
        var timelineDataImages = [String: String]()
        timelineDataImages["count"] = "\(images.count)"
        for i in 0..<images.count {
            timelineDataImages["\(i)"] = ""
        }
        
        let timelineData = [
            "userId": "husband",
            "type": "Life",
            "subtype": "Moment",
            "title": "Moment",
            "content": self.textview.text,
            "images": timelineDataImages,
            "location": self.location,
            "icon": self.selectedIconIndex,
            "bgColor": self.selectedBgColorIndex,
            "createAt": "\(NSDate().timeIntervalSince1970)",
            "updateAt": "\(NSDate().timeIntervalSince1970)",
            "messages": "",
            "comments": "",
            ]
        
        let newTimelineRef = timelineRef.childByAutoId()
        newTimelineRef.setValue(timelineData) { (error, ntlRef) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            print("Post(id: \(ntlRef.key)) Created.")
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
                    "createAt": NSDate().timeIntervalSince1970
                ]
                newPhotoRef.setValue(newPhotoData, withCompletionBlock: { (error, npRef) in
                    
                    print("Image-\(i+1)(id: \(npRef.key)) Created.")
                    
                    let ntlImagesRef = ntlRef.childByAppendingPath("images")
                    ntlImagesRef.updateChildValues(["\(i)": npRef.key])
                    
                    print("Post(id: \(ntlRef.key)) image-\(i) info updated.")
                    
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
                })
                
                
            }
        }
        
        self.dismissViewControllerAnimated(true) { 
            
        }
        
    }
    
    @IBAction func cancelBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func plusBtnClick() {
        //        let vc = UIImagePickerController()
        //        self.presentViewController(vc, animated: true, completion: {
        //        })
        ipc.delegate = self
        ipc.imageLimit = 9
        ipc.delegate?.wrapperDidPress(ipc, images: AssetManager.resolveAssets(ipc.stack.assets))
        
        self.presentViewController(ipc, animated: true) {
        }
    }
    
    @IBAction func emojiBtnClick() {
        emojiBtn.selected = !emojiBtn.selected
    }
    
    @IBAction func hideKeyboardBtnClick() {
        if hideKeyboardBtn.selected {
            self.view.endEditing(true)
        } else {
            self.textview.becomeFirstResponder()
        }
        //        hideKeyboardBtn.selected = !hideKeyboardBtn.selected
    }
    
    @IBAction func bgColorBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        self.modalBtn.hidden = false
        self.isSelectingIcon = false
        self.selectPanel.reloadData()
        self.selectPanel.hidden = false
    }
    
    @IBAction func iconBtnClcik(sender: UIButton) {
        self.view.endEditing(true)
        self.modalBtn.hidden = false
        self.isSelectingIcon = true
        self.selectPanel.reloadData()
        self.selectPanel.hidden = false
    }
    @IBAction func modalBtnClick(sender: UIButton) {
        self.modalBtn.hidden = true
        
        self.selectPanel.hidden = true
        
    }
}

// keyboard events
extension NewTimelineViewController {
    
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(keyboardHeight)
        
        self.hideKeyboardBtn.selected = true
        self.btnBar.frame = CGRectMake(0, self.btnBarY - keyboardHeight, self.btnBar.frame.width, self.btnBar.frame.height)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(keyboardHeight)
        
        UIView.animateWithDuration(0.1, delay: 0, options: [.CurveEaseOut], animations: {
            self.btnBar.frame = CGRectMake(0, self.btnBarY - keyboardHeight, self.btnBar.frame.width, self.btnBar.frame.height)
        }) { (complete) in
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(keyboardHeight)
        
        UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
            self.btnBar.frame = CGRectMake(0, self.btnBarY, self.btnBar.frame.width, self.btnBar.frame.height)
        }) { (complete) in
            self.hideKeyboardBtn.selected = false
        }
    }
}

extension NewTimelineViewController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if textView.hasText() {
            self.textviewPlaveholderLbel.hidden = true
        } else {
            self.textviewPlaveholderLbel.hidden = false
        }
    }
}

extension NewTimelineViewController: ImagePickerDelegate {
    
    func wrapperDidPress(imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(imagePicker: ImagePickerController, images: [UIImage]) {
        pickedImages.removeAll()
        for image in images {
            if !pickedImages.contains(image) {
                pickedImages.append(image)
            }
        }
        imagePicker.dismissViewControllerAnimated(true) {
        }
    }
    
    func cancelButtonDidPress(imagePicker: ImagePickerController) {
        
    }
}

extension NewTimelineViewController: CLLocationManagerDelegate {
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

extension NewTimelineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSelectingIcon {
            return ICON_NAMES.count
        } else {
            return BG_COLORS.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if isSelectingIcon {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IconPanelCell", forIndexPath: indexPath) as! IconPanelCell
            cell.iconImg.image = UIImage(named: ICON_NAMES[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BgColorPanelCell", forIndexPath: indexPath) as! BgColorPanelCell
            cell.bgColorView.backgroundColor = BG_COLORS[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        if isSelectingIcon {
            self.selectedIconIndex = indexPath.row
        } else {
            self.selectedBgColorIndex = indexPath.row
        }
        
        self.modalBtn.hidden = true
        self.selectPanel.hidden = true
    }
}