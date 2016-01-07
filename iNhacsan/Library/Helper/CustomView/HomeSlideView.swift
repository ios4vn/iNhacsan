//
//  HomeSlideView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/20/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class HomeSlideView: UIView {
    
    private var _slides: [[String: AnyObject]]!
    var slides: [[String: AnyObject]]!
        {
        get{
            return _slides
        }
        set{
            _slides = newValue
            self.scrHeader.contentSize = CGSizeMake(CGFloat(_slides!.count) * self.frame.size.width, self.frame.size.height)
            pageControl.numberOfPages = _slides.count
            for var i = 0; i < _slides.count; i++ {
                var slide = _slides[i] as [String: AnyObject]!
                let view = SlideView.instanceFromNib() as! SlideView
                view.frame = CGRect(x: CGFloat(i)*self.frame.size.width, y: CGFloat(0), width: self.frame.size.width, height: self.frame.size.height)
                view.imageUrl = slide["priavatar"] as! String
                self.scrHeader.addSubview(view)
            }
        }
    }
    
    var durations = 0
    
    @IBOutlet weak private var scrHeader: UIScrollView!
    @IBOutlet weak private var pageControl: UIPageControl!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension HomeSlideView: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView){
        let offset = scrollView.contentOffset
        pageControl.currentPage = (Int)(offset.x/320)
    }
    
}
