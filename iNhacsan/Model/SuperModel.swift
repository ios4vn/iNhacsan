//
//  SuperModel.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/22/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SuperModel: NSObject {
    
    var modelId: String?
    var modelName: String?
    
    override init() {
        super.init()
    }
    
    init(modelId : String, modelName : String) {

        self.modelId = modelId
        self.modelName = modelName
        
    }
 
}
