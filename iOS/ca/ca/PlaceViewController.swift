//
//  PlaceViewController.swift
//  ca
//
//  Created by Ant on 16/7/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    
    var place: Place!
    
    var topView = UIView()
    var topViewLbl = UILabel()
    
    var displayView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    func setupUI() {
        titleLbl.text = self.place.id
    }
    
    override func viewDidLayoutSubviews() {
        
        topView.frame = CGRectMake(0, -60, self.view.frame.width, 60)
        
        topViewLbl.numberOfLines = 2
        topViewLbl.textColor = THEME().textMainColor(0.8)
        
        var photoCountText:String!
        if self.place.photoList.count > 1 {
            photoCountText = "\(self.place.photoList.count) " + NSLocalizedString("Photos", comment: "Places")
        } else {
            photoCountText = "\(self.place.photoList.count) " + NSLocalizedString("Photo", comment: "Places")
        }
        
        topViewLbl.text = "从 \(self.place.photoList.first?.formattedDatetime ?? "第一天") 开始\n在 \(self.place.id) 拍了 \(photoCountText)"
        topViewLbl.font = UIFont(name: "FZYANS_JW--GB1-0", size: 18)
        topViewLbl.frame = CGRectMake(8, 0, topView.frame.width, topView.frame.height)
        
        topView.addSubview(topViewLbl)
        self.collectionview.addSubview(topView)
        
        for i in 0..<self.place.photoList.count {
            let temp = UIImageView()
            getImageByIdAndLocation(self.place.photoList[i].id, location: self.place.id, complete: { (image) in
                temp.image = image
            })
            temp.contentMode = .ScaleAspectFit
            temp.frame = CGRectMake(self.view.frame.width * CGFloat(i) , 0, self.view.frame.width, self.view.frame.height)
            temp.backgroundColor = UIColor.blackColor()
            
            self.displayView.addSubview(temp)
        }
        self.displayView.contentSize = CGSizeMake(self.view.frame.width * CGFloat(self.place.photoList.count), self.view.frame.height)
        self.displayView.pagingEnabled = true
        self.displayView.bounces = false
        self.displayView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.displayView.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PlaceViewController.dismissPopUp))
        self.displayView.addGestureRecognizer(tap)
        
        self.view.addSubview(displayView)
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
        cell.initCell(cellData.id, location: place.id, datetime: " "+cellData.time+"  "+cellData.date)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionview.frame.width - 2) / 3
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        self.displayView.setContentOffset(CGPointMake(self.view.frame.width * CGFloat(indexPath.row), 0), animated: false)

        UIView.animateWithDuration(0.15,
                                   delay: 0,
                                   options: [.CurveEaseOut],
                                   animations: {
                                    self.displayView.alpha = 1
        }) { (complete) in
        }
        
    }
    
    func dismissPopUp() {
        UIView.animateWithDuration(0.15, delay: 0, options: [.CurveEaseIn], animations: {
            self.displayView.alpha = 0
            }) { (complete) in
        }
    }
}
