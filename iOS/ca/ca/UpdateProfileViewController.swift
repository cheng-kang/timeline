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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - @IBAction
extension UpdateProfileViewController {
    
    @IBAction func dismissBtnClick(sender: UIButton) {
    }
    @IBAction func pickBtnClick(sender: UIButton) {
    }
    @IBAction func updateBtnClick(sender: UIButton) {
    }
}