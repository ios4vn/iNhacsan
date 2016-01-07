//
//  LoginViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/27/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import QuartzCore

class LoginViewController: BaseUserViewController {
    
    //MARK: Outlets for UI Elements.
    @IBOutlet weak var usernameField:   UITextField!
    @IBOutlet weak var passwordField:   UITextField!
    @IBOutlet weak var loginButton:     UIButton!

    
    //MARK: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.alpha = 0;
        passwordField.alpha = 0;
        loginButton.alpha   = 0;
        
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 0.9
            }, completion: nil)
        usernameField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        self.loginButton(true)
        
    }
    
    func loginButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#33CC00", alpha: 1)
                }, completion: nil)
            loginButton.enabled = true
        }
        func disable(){
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldDidChange() {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        LibraryAPI.sharedInstance.userLogin(usernameField.text!, password: passwordField.text!) { (result) -> Void in
            let status = result?.objectForKey("status") as! Int
            if status == 1 {
                let data: AnyObject? = result?.objectForKey("data")
                let user: AnyObject? = data?.objectForKey("user")
                AppUser.sharedInstance.isLogin = true
                AppUser.sharedInstance.username = self.usernameField.text!
                AppUser.sharedInstance.mobile = self.usernameField.text!
                AppUser.sharedInstance.userId = (user?.objectForKey("_id") as? String)!
                AppUser.sharedInstance.ssid = (data?.objectForKey("ssid") as? String)!
                AppUser.sharedInstance.isService = (user?.objectForKey("isRegister") as? Bool)!
                NSNotificationCenter.defaultCenter().postNotificationName(loginStatusChangeNotificationKey, object: nil)
                appDelegate.menuViewController.reloadSideView()
                self.dismissViewControllerAnimated(true, completion: { () -> Void in

                })
            }
            else if status == 0 {
                AppUser.sharedInstance.username = self.usernameField.text!
                let activeView = (self.storyboard?.instantiateViewControllerWithIdentifier("playerViewController"))! as UIViewController
                self.navigationController?.pushViewController(activeView, animated: true)
            }
            else {
                SVProgressHUD.showInfoWithStatus(result?.objectForKey("mesage") as! String, maskType: SVProgressHUDMaskType.Clear)
            }
        }
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    
}

//Extension for Color to take Hex Values
extension UIColor{
    
    class func colorWithHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgb: CUnsignedInt = 0;
        let scanner = NSScanner(string: hex)
        
        if hex.hasPrefix("#") {
            // skip '#' character
            scanner.scanLocation = 1
        }
        scanner.scanHexInt(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}





