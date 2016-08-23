//
//  RegisterViewController.swift
//  CA
//
//  Created by Ant on 16/8/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordRepeatLbl: UILabel!
    @IBOutlet weak var passwordRepeatField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var aboutCABtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - @IBAction
extension RegisterViewController {
    
    @IBAction func registerBtnClick(sender: UIButton) {
    }
    @IBAction func loginBtnClick(sender: UIButton) {
    }
    @IBAction func aboutCABtnClick(sender: UIButton) {
    }
}