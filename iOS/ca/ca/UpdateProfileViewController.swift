//
//  UpdateProfileViewController.swift
//  CA
//
//  Created by Ant on 16/8/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var navTitleLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var avatarView: RoundedCornerImage!
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var pickBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    let ipc = ImagePickerController()
    
    class func vc() -> UpdateProfileViewController {
        let sb = UIStoryboard(name: "User", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("UpdateProfileViewController") as! UpdateProfileViewController
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ipc.delegate = self
        ipc.imageLimit = 1

        setupUI()
    }
    
    func setupUI() {
        self.navTitleLbl.text = NSLocalizedString("Profile", comment: "User")
        self.nameLbl.text = NSLocalizedString("Name", comment: "User")
        self.pickBtn.setTitle(NSLocalizedString("Pick", comment: "User"), forState: .Normal)
        self.updateBtn.setTitle(NSLocalizedString("Update", comment: "User"), forState: .Normal)
    }

}

// MARK: - @IBAction
extension UpdateProfileViewController {
    
    @IBAction func dismissBtnClick(sender: UIButton) {
        self.view.endEditing(true)
    }
    @IBAction func pickBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        
        self.presentViewController(ipc, animated: true) {
        }
    }
    @IBAction func updateBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        
    }
}

extension UpdateProfileViewController: ImagePickerDelegate {
    
    func wrapperDidPress(imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(imagePicker: ImagePickerController, images: [UIImage]) {
        self.avatarView.image = images.first
    }
    
    func cancelButtonDidPress(imagePicker: ImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true) {
        }
    }
}