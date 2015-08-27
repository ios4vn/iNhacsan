//
//  MediaModel.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/30/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

enum MediaType {
    case Song
    case Video
    case Album
}

class MediaModel: SuperModel {
 
    var type: MediaType?
    var link: String?
    var thumb: String?
    var singer: String?
    var linkShare: String?
    var lyrics: String?
    var like = 0
    var view = 0
    var download = 0
    var isLiked = false
    
}
