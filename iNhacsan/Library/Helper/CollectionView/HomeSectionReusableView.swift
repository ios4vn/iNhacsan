//
//  HomeSectionReusableView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/20/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class HomeSectionReusableView: UICollectionReusableView {
    
    private var _titleName:String!
    var delegate: HomeSectionDelegate?
    var index = 0
    var titleName:String!{
        get{
            return _titleName
        }
        set{
            _titleName = newValue
            lblTitleName.text = newValue
        }
    }
    
    @IBOutlet weak private var lblTitleName: UILabel!
    
    @IBAction func moreButtonPress (sender: AnyObject?){
        
        delegate?.didSelectMorePressAtIndex(index)
        
    }
    
}

protocol HomeSectionDelegate {
    func didSelectMorePressAtIndex(index: Int)
}
