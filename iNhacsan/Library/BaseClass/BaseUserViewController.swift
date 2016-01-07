//
//  BaseUserViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/28/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class BaseUserViewController: UIViewController {
    
    @IBOutlet weak var imageView:       UIImageView!
    @IBOutlet weak var lblMessage:  UILabel?
    
    //MARK: Global Variables for Changing Image Functionality.
    private var idx: Int = 0
    private let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg")]

    override func viewDidLoad() {
        super.viewDidLoad()

        let closeButton: UIButton = UIButton()
        closeButton.setImage(UIImage(named: "login_close.png"), forState: .Normal)
        closeButton.frame = CGRectMake(self.view.frame.size.width - 50, 25, 44, 44)
        closeButton.addTarget(self, action: "closePress", forControlEvents: .TouchUpInside)
        self.view.addSubview(closeButton)
        
        // Visual Effect View for background
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark)) as UIVisualEffectView
        visualEffectView.frame = self.view.frame
        visualEffectView.alpha = 0.5
        imageView.image = UIImage(named: "img1.jpg")
        imageView.addSubview(visualEffectView)
        
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    func changeImage(){
        if idx == backGroundArray.count-1{
            idx = 0
        }
        else{
            idx++
        }
        let toImage = backGroundArray[idx];
        UIView.transitionWithView(self.imageView, duration: 3, options: .TransitionCrossDissolve, animations: {self.imageView.image = toImage}, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.showPlayerView = false
    }
    
    func closePress() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            let player = HysteriaPlayer.sharedInstance()
            if player.playerItems.count > 0 {
                appDelegate.showPlayerView = true
            }
            else {
                appDelegate.showPlayerView = false
            }
        })
    }
}
