//
//  ChildCategoryViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/22/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class ChildCategoryViewController: HTCollectionViewController {
    
    var category: Category!

    override func viewDidLoad() {
        super.viewDidLoad()
        showBannerView = false
        parameters["act"] = "getCategory"
        parameters["id"] = category.modelId

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func processResponse(JSON: AnyObject?) {
        let test: AnyObject? = JSON?.objectForKey("data")
        if test?.count > 0 {
            data += (test?.objectForKey("media") as? [[String: AnyObject]])!
        }
    }
}
