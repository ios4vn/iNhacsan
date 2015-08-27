//
//  CommentsViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/5/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class CommentsViewController: HTCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showBannerView = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func findHeightForText(text: String, widthValue: CGFloat, font: UIFont) -> CGFloat {
//        var size = CGSizeZero
//        if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
//            var frame = (text as NSString).boundingRectWithSize(CGSize(width: widthValue, height: DBL_MAX), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//        }
//        return size.height
//    }
//    
//    func sizeOfString (string: NSString, constrainedToWidth width: Double) -> CGSize {
//        return string.boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
//            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
//            attributes: [NSFontAttributeName: self],
//            context: nil).size
//    }
}
