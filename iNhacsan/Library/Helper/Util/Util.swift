//
//  Util.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/19/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class Util: NSObject {
   
    class var sharedInstance: Util {
        struct Singleton {
            static let instance = Util()
        }
        return Singleton.instance
    }
    
    func showLogin(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController =
        mainStoryboard.instantiateViewControllerWithIdentifier("navLogin") 
        appDelegate.window?.rootViewController?.presentViewController(loginViewController, animated: true, completion: { () -> Void in
            
        })
    }
    
    func showAccount(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userViewController =
        mainStoryboard.instantiateViewControllerWithIdentifier("navAccount") as! UINavigationController
        appDelegate.window!.rootViewController?.presentViewController(userViewController, animated: true, completion: { () -> Void in
            let packageView =
            mainStoryboard.instantiateViewControllerWithIdentifier("PackageView") 
            userViewController.pushViewController(packageView, animated: true)
        })
    }
    
    func showPackage(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userViewController =
        mainStoryboard.instantiateViewControllerWithIdentifier("navAccount") as! UINavigationController
        appDelegate.window!.rootViewController?.presentViewController(userViewController, animated: true, completion: { () -> Void in
            let packageView =
            mainStoryboard.instantiateViewControllerWithIdentifier("PackageView") 
            userViewController.pushViewController(packageView, animated: true)
        })
    }
    
    func shareUrl(media: MediaModel){
        let url = NSURL(string: media.linkShare!)
        let urbnActivityController = URBNActivityViewController(defaultBody: "iNhacsan", url: url, canOpenInSafari: true)
        appDelegate.window?.rootViewController?.presentViewController(urbnActivityController, animated: true, completion: { () -> Void in
            
        })
    }
    
    func likeMedia(media: MediaModel){
        if !AppUser.sharedInstance.isLogin {
            self.showLogin()
        }
        else {
            LibraryAPI.sharedInstance.like(media.modelId!, type: media.type!, completion: { (result) -> Void in
                
            })
        }
    }
    
    func download(media: MediaModel){
        if let _ = media.link {
        
        }
    }
    
}
