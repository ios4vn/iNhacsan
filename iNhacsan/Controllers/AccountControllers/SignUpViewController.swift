//
//  SignUpViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SignUpViewController: BaseUserViewController {
    
    @IBOutlet weak var usernameField:   UITextField!
    @IBOutlet weak var passwordField:   UITextField!
    @IBOutlet weak var repasswordField:   UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func signupPressed(sender: AnyObject) {
        LibraryAPI.sharedInstance.userRegister(usernameField.text!, password: passwordField.text!) { (result) -> Void in
            let status = result?.objectForKey("status") as! Int
            if status == 0 {
                AppUser.sharedInstance.username = self.usernameField.text!
                AppUser.sharedInstance.mobile = self.usernameField.text!
                self.performSegueWithIdentifier("showActiveView", sender: nil)
            }
            else {
                SVProgressHUD.showInfoWithStatus(result?.objectForKey("mesage") as! String, maskType: SVProgressHUDMaskType.Clear)
            }
        }
    }

}
