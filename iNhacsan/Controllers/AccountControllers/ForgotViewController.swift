//
//  ForgotViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/20/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class ForgotViewController: BaseUserViewController {
    
    @IBOutlet weak private var txtMobile: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendNewPasswordPress(sender: AnyObject?){
        LibraryAPI.sharedInstance.sendConfirmKey(txtMobile.text, completion: { (result) -> Void in
            let status = result?.objectForKey("status") as! Int
            if status == 0 {
                var resetView = self.storyboard?.instantiateViewControllerWithIdentifier("ReceiveNewPassView") as! UIViewController
                self.navigationController?.pushViewController(resetView, animated: true)
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
