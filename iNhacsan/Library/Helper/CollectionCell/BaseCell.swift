//
//  BaseCell.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/15/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    private var _imageUrl:String!
    var imageUrl:String!{
        get{
            return _imageUrl
        }
        set{
            _imageUrl = newValue.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            let url: NSURL = NSURL(string: self.imageUrl.getImageUrl())!
            imageThumb.setImageWithUrl(url, placeHolderImage: noImage)
        }
    }
    
    private var _titleName:String!
    var titleName:String!{
        get{
            return _titleName
        }
        set{
            _titleName = newValue
            lblSongName.text = newValue
        }
    }
    
    private var _singerName:String!
    var singerName:String!{
        get{
            return _singerName
        }
        set{
            _singerName = newValue
            lblSingerName.text = newValue
        }
    }
    
    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSingerName: UILabel!
    
}
