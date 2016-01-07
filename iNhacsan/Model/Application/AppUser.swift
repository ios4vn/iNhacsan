//
//  AppUser.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

let loginStatusChangeNotificationKey = "loginStatusChangeNotificationKey"

class AppUser: NSObject {
    var userId: String = ""
    var username: String = ""
    var mobile: String = ""
    var ssid: String = ""
    var isLogin: Bool = false
    var is3G: Bool = false
    var isService: Bool = false
    
    class var sharedInstance: AppUser {
        struct Singleton {
            static let instance = AppUser()
        }
        return Singleton.instance
    }
    
    func logout() {
        userId = ""
        username = ""
        mobile = ""
        ssid = ""
        isLogin = false
        is3G = false
    }
}
