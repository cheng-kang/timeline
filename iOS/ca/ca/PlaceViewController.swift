//
//  PlaceViewController.swift
//  ca
//
//  Created by Ant on 16/7/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var photoCountLbl: UILabel!
    @IBOutlet weak var latestLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    
    let transition = PopAnimation()
    
    var place: Place!
    
    var popUpImageInitBounds: CGRect?
    var popUpImageInitCenter: CGPoint?
    var popUpImage = UIImageView()
    var popUpBackgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    func setupUI() {
        self.backgroundImage.clipsToBounds = true
        
        locationLbl.text = self.place.id
        
        if self.place.photoList.count > 1 {
            photoCountLbl.text = "\(self.place.photoList.count) " + NSLocalizedString("Photos", comment: "Places")
        } else {
            photoCountLbl.text = "\(self.place.photoList.count) " + NSLocalizedString("Photo", comment: "Places")
        }
        
        
        if self.place.photoList.count > 0 {
            self.fromLbl.text = NSLocalizedString("From", comment: "Place") + (self.place.photoList.first?.date)!
            self.latestLbl.text = NSLocalizedString("Lastest", comment: "Place") + (self.place.photoList.last?.date)!
            getImageByIdAndLocation((self.place.photoList.first?.id)!, location: self.place.id, complete: { (image) in
                self.place.photoList.first?.image = image
                self.backgroundImage.image = image
            })
        } else {
            self.backgroundImage.image = nil
            self.fromLbl.text = ""
            self.latestLbl.text = ""
        }
        
        
        
        popUpImage.clipsToBounds = true
        popUpBackgroundView.backgroundColor = UIColor.blackColor()
        popUpBackgroundView.alpha = 0
        popUpBackgroundView.frame = self.view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func placeViewController(place: Place) -> PlaceViewController {
        
        let sb = UIStoryboard(name: "Places", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("PlaceViewController") as! PlaceViewController
        
        vc.place = place
        
        return vc
    }
    
    @IBAction func backBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.place.photoList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let cellData = self.place.photoList[indexPath.row]
        cell.initCell(cellData.id, location: place.id, datetime: cellData.time+cellData.date)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionview.frame.width - 2) / 3
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        let cell = (collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCell)
        
        let cellData = self.place.photoList[indexPath.row]
        
        let distanceToTopElement: CGFloat = 182
        
        self.view.addSubview(popUpBackgroundView)
        
        popUpImage.contentMode = .ScaleAspectFit
        if cellData.image != nil {
            popUpImage.image = cellData.image
        } else {
            getImageByIdAndLocation(cellData.id, location: place.id, complete: { (image) in
                cellData.image = image
                self.popUpImage.image = image
            })
        }
        popUpImage.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y + distanceToTopElement, cell.frame.width, cell.frame.height)
        popUpImage.alpha = 0
        self.view.addSubview(popUpImage)
        
        self.popUpImageInitBounds = cell.bounds
        self.popUpImageInitCenter = CGPointMake(cell.center.x, cell.center.y + distanceToTopElement)
        print(popUpImageInitBounds)
        
        UIView.animateWithDuration(0.8, delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    self.popUpImage.bounds = self.view.bounds
                                    self.popUpImage.center = self.view.center
                                    
            }, completion:{_ in
        })
        UIView.animateWithDuration(0.6) {
            self.popUpImage.alpha = 1
            self.popUpBackgroundView.alpha = 0.3
        }
        
        let modalButton = UIButton()
        modalButton.frame = self.view.frame
        modalButton.backgroundColor = UIColor.clearColor()
        modalButton.addTarget(self, action: #selector(PlaceViewController.dismissPopUp), forControlEvents: .TouchUpInside)
        self.view.addSubview(modalButton)
        
    }
    
    func dismissPopUp(sender: UIButton) {
        sender.removeFromSuperview()
        
        popUpImage.contentMode = .ScaleAspectFill
        UIView.animateWithDuration(0.8, delay:0.0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    self.popUpImage.bounds = self.popUpImageInitBounds!
                                    self.popUpImage.center = self.popUpImageInitCenter!
            }, completion:{_ in
        })
        UIView.animateWithDuration(0.8) {
            self.popUpImage.alpha = 0
            self.popUpBackgroundView.alpha = 0
        }
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
