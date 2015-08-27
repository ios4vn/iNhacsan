//
//  VideosViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/21/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class VideosViewController: ParentCategoryViewController {

    override func viewDidLoad() {
        self.titleName = "Video"
        super.viewDidLoad()
        parameters["act"] = "getCategoryList"
        parameters["type"] = "video"
        viewControllerIdentifier = "VideoCategories"
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

