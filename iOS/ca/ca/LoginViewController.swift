//
//  LoginViewController.swift
//  CA
//
//  Created by Ant on 16/8/23.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit
import Wilddog
import SwiftValidators

class LoginViewController: UIViewController {

    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var aboutCABtn: UIButton!
    
    
    class func vc() -> LoginViewController {
        let sb = UIStoryboard(name: "User", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.accountField.delegate = self
        self.passwordField.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        self.accountLbl.text = NSLocalizedString("Account:", comment: "User")
        self.passwordLbl.text = NSLocalizedString("Password:", comment: "User")
        self.loginBtn.setTitle(NSLocalizedString("Log In", comment: "User"), forState: .Normal)
        self.registerBtn.setTitle(NSLocalizedString("Register", comment: "User"), forState: .Normal)
        self.forgetPasswordBtn.setTitle(NSLocalizedString("Forgot Password", comment: "User"), forState: .Normal)
        self.aboutCABtn.setTitle(NSLocalizedString("About CA", comment: "User"), forState: .Normal)
    }

}

// MARK: - @IBAction
extension LoginViewController {
    
    @IBAction func loginBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        
        let email = accountField.text!
        let password = passwordField.text!
        
        // Validation
        if Validator.isEmpty(password) {
            self.view.makeToast("Password cannot be empty.")
            return
        }
        
        if !Validator.isEmail(email) {
            self.view.makeToast("Please enter correct Email.")
            return
        }
        
        ROOT_REF.authUser(email,
                          password: password) { (error, authdata) in
                            if authdata != nil {
                                self.dismissViewControllerAnimated(true, completion: {
                                })
                            } else {
                                self.view.makeToast("Wrong Account or Password!")
                            }
        }
    }
    @IBAction func registerBtnClick(sender: UIButton) {
        self.view.endEditing(true)
        let vc = RegisterViewController.vc()
        self.presentViewController(vc, animated: true) { 
        }
    }
    @IBAction func aboutCABtnClick(sender: UIButton) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.accountField {
            self.passwordField.becomeFirstResponder()
        }
        
        if textField == self.passwordField {
            self.view.endEditing(true)
        }
        
        return true
    }
}



























