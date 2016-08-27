//
//  RegisterViewController.swift
//  CA
//
//  Created by Ant on 16/8/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import SwiftValidators

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
    
    class func vc() -> RegisterViewController {
        let sb = UIStoryboard(name: "User", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("RegisterViewController") as! RegisterViewController
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        self.accountLbl.text = NSLocalizedString("Account:", comment: "User")
        self.passwordLbl.text = NSLocalizedString("Password:", comment: "User")
        self.passwordRepeatLbl.text = NSLocalizedString("Repeat Password:", comment: "User")
        self.loginBtn.setTitle(NSLocalizedString("Log In", comment: "User"), forState: .Normal)
        self.registerBtn.setTitle(NSLocalizedString("Register", comment: "User"), forState: .Normal)
        self.aboutCABtn.setTitle(NSLocalizedString("About CA", comment: "User"), forState: .Normal)
    }
}

// MARK: - @IBAction
extension RegisterViewController {
    
    @IBAction func registerBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        
        let email = accountField.text!
        let password = passwordField.text!
        let passwordRepeat = passwordRepeatField.text!
        
        if password != passwordRepeat {
            self.view.makeToast("Password not match.")
            return
        }
        
        if Validator.isEmpty(password) {
            self.view.makeToast("Password cannot be empty.")
            return
        }
        
        if !Validator.isEmail(email) {
            self.view.makeToast("Please enter correct Email.")
            return
        }
        
        ROOT_REF.createUser(email,
                            password: password,
                            withCompletionBlock: { error in
                                if error != nil {
                                    self.view.makeToast(error.debugDescription)
                                } else {
                                    self.dismissViewControllerAnimated(true, completion: {
                                        self.view.makeToast("User Created!")
                                    })
                                }
            }
        )
        
        
    }
    @IBAction func loginBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true) {
        }
    }
    @IBAction func aboutCABtnClick(sender: UIButton) {
        self.view.endEditing(true)
    }
}