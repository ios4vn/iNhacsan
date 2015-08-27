//
//  AlbumCell.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/14/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class AlbumCell: BaseCell {
    
    override func awakeFromNib() {
        imageThumb.layer.cornerRadius = imageThumb.frame.size.width/2.0
        imageThumb.clipsToBounds = true
        imageThumb.layer.borderWidth = 2
        imageThumb.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
}
