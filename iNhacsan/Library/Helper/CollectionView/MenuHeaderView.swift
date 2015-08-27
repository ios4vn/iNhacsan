//
//  MenuHeaderView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class MenuHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var lblAccount: UILabel!
    
    @IBAction func accountButtonTouched(sender: AnyObject) {
        if AppUser.sharedInstance.isLogin {
            Util.sharedInstance.showAccount()
        }
        else {
            Util.sharedInstance.showLogin()
        }
    }
    
}
