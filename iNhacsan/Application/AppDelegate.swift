//
//  AppDelegate.swift
//
//  Created by Hai Trieu on 4/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let screenSize = UIScreen.mainScreen().bounds.size
    
    private var _showPlayerView: Bool!
    var showPlayerView:Bool!{
        get{
            return _showPlayerView
        }
        set{
            _showPlayerView = newValue
            self.togglePlayerView(newValue)
        }
    }
    
    var window: UIWindow?
    var playerView: PlayerView!
    var showBannerView:Bool!
    var bannerView: BannerView!
    var playerViewController: PlayViewController!
    var menuViewController: MenuViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var rootViewController = self.window!.rootViewController
        playerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("playerViewController") as! PlayViewController
        self.initPlayerView()
        self.initBannerView()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }

    func initPlayerView() {
        self.playerView = PlayerView.instanceFromNib() as! PlayerView
        self.playerView.avatar.layer.cornerRadius = 20
        self.playerView.avatar.layer.masksToBounds = true
        self.playerView.avatar.layer.borderWidth = 1
        self.playerView.avatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.playerView.showDetailPlayer.addTarget(self, action: "showDetailPlayer", forControlEvents: .TouchUpInside)
    }
    
    func initBannerView(){
        showBannerView = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeBannerText", name: loginStatusChangeNotificationKey, object: nil)
        bannerView = BannerView.instanceFromNib() as! BannerView
    }
    
    func changeBannerText(){
         bannerView.lblMessage.text = bannerView.bannerText
    }
      
    func togglePlayerView(show: Bool) {
        
        if show {
            self.playerView.frame = CGRectMake(0, screenSize.height, screenSize.width, screenSize.height)
            self.window?.addSubview(self.playerView)
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.playerView.frame = CGRectMake(0, self.screenSize.height - (CGFloat)(50), self.screenSize.width, self.screenSize.height)
            })
        }
        else{
            var tmpRect = self.playerView.frame
            tmpRect.origin.y = screenSize.height
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.playerView.frame = tmpRect
                }, completion: { (finish: Bool) -> Void in
                self.playerView.removeFromSuperview()
            })
        }
        self.playerView.isPlaying = HysteriaPlayer.sharedInstance().isPlaying()
    }
    
    func showDetailPlayer() {
        var rootViewController = self.window!.rootViewController as! DLHamburguerViewController
        var contentView = rootViewController.contentViewController as! UINavigationController
        contentView.pushViewController(self.playerViewController, animated: true)
    }
}

