//
//  DLDemoRootViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

class RootViewController: DLHamburguerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        self.contentViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoNavigationViewController"))! as UIViewController
        self.menuViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoMenuViewController"))! as UIViewController
        appDelegate.menuViewController = self.menuViewController as! MenuViewController
    }
}
