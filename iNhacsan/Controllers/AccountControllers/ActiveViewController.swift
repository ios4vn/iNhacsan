//
//  ActiveViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/4/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class ActiveViewController: BaseUserViewController {
    
    @IBOutlet weak var validateTextField:   UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func validatedPressed(sender: AnyObject) {
        LibraryAPI.sharedInstance.userActive(AppUser.sharedInstance.username, active_code: validateTextField.text) { (result) -> Void in
            let status = result?.objectForKey("status") as! Int
            if status == 0 {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else {
                SVProgressHUD.showInfoWithStatus(result?.objectForKey("mesage") as! String, maskType: SVProgressHUDMaskType.Clear)
            }
        }
    }

}
