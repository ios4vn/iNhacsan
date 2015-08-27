//
//  ReceiveNewPassViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/20/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class ReceiveNewPassViewController: BaseUserViewController {
    
    @IBOutlet weak private var txtPasswordValid: UITextField!
    @IBOutlet weak private var txtNewPassword: UITextField!
    @IBOutlet weak private var txtReNewPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func receivePasswordPress(){
        LibraryAPI.sharedInstance.receiveNewPassword(AppUser.sharedInstance.mobile, password: txtNewPassword.text, resetPassKey: txtPasswordValid.text) { (result) -> Void in
            let status = result?.objectForKey("status") as! Int
            if status == 0 {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }

}
