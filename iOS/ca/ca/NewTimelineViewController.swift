//
//  NewTimelineViewController.swift
//  ca
//
//  Created by Ant on 16/7/18.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class NewTimelineViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var textviewPlaveholderLbel: UILabel!
    @IBOutlet weak var postImageGrid: PostImageGrid!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textview.delegate = self
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        postImageGrid.gridItems[0].frame = CGRectMake(0,0,106,106)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func newTimelineViewController() -> NewTimelineViewController {
        
        let sb = UIStoryboard(name: "Timeline", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("NewTimelineViewController") as! NewTimelineViewController
        
        return vc
    }
    
    func setUpUI() {
//        self.textview.sizeToFit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.hasText() {
            self.textviewPlaveholderLbel.hidden = true
        } else {
            self.textviewPlaveholderLbel.hidden = false
        }
    }

}
