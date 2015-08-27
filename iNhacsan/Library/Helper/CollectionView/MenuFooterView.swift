//
//  MenuFooterView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class MenuFooterView: UICollectionReusableView {
    
    @IBOutlet private var logoutBtn: UIButton!
    
    private var _isLogin: Bool!
    var isLogin: Bool!{
        get {
            return _isLogin
        }
        set {
            _isLogin = newValue
            logoutBtn.hidden = !_isLogin
        }
    }
    
    @IBAction func logoutPress(sender: AnyObject?){
        AppUser.sharedInstance.logout()
        appDelegate.menuViewController.reloadSideView()
    }
    
}
