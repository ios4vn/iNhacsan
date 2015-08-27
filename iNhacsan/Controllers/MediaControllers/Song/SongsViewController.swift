//
//  SongsViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/21/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SongsViewController: ParentCategoryViewController {

    override func viewDidLoad() {
        self.titleName = "Bài hát"
        super.viewDidLoad()
        parameters["act"] = "getCategoryList"
        parameters["type"] = "audio"
        viewControllerIdentifier = "SongCategories"
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
