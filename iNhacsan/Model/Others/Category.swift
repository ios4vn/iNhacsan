//
//  Category.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/22/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class Category: SuperModel {
    
    func initWithObject(category: AnyObject!){
        modelId = category.objectForKey("_id") as? String
        modelName = category.objectForKey("name") as? String
    }
    
}
