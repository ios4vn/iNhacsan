//
//  SlideView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/20/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SlideView: UIView {
    
    private var _imageUrl:String!
    var imageUrl:String!{
        get{
            return _imageUrl
        }
        set{
            _imageUrl = newValue
            let url: NSURL = NSURL(string: newValue)!
            imgThumb.setImageWithUrlRequest(NSURLRequest(URL: url), placeHolderImage: nil, success: { (request, response, image, fromCache) -> Void in
                self.imgThumb.image = image
                self.imgThumb.contentMode = .ScaleToFill
                }) { (request, response, error) -> Void in
                    
            }
        }
    }
    
    private var _titleName:String!
    var titleName:String!{
        get{
            return _titleName
        }
        set{
            _titleName = newValue
            lblTitle.text = newValue
        }
    }

    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "SlideView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}
