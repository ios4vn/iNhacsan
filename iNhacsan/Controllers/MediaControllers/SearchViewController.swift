//
//  SearchViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/18/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    var keyword: String!
    
    override func viewDidLoad() {
        self.titleName = keyword
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setupSlideView()
    }
    
    func setupSlideView(){
        var albumView = self.storyboard?.instantiateViewControllerWithIdentifier("albumList") as! AlbumListViewController
        albumView.showBannerView = false
        albumView.parameters["type"] = "album"
        albumView.parameters["keyword"] = keyword
        albumView.parameters["act"] = "search"
        albumView.keyData = "album"
        
        var songView = self.storyboard?.instantiateViewControllerWithIdentifier("SongTop") as! SongListViewController
        songView.showBannerView = false
        songView.parameters["type"] = "audio"
        songView.parameters["keyword"] = keyword
        songView.parameters["act"] = "search"
        songView.keyData = "audio"
        
        let videoView = self.storyboard?.instantiateViewControllerWithIdentifier("VideoTop") as! VideoListViewController
        videoView.showBannerView = false
        videoView.parameters["type"] = "video"
        videoView.parameters["keyword"] = keyword
        videoView.parameters["act"] = "search"
        videoView.keyData = "video"
        
        let slidingContainerViewController = SlidingContainerViewController (parent: self,contentViewControllers: [albumView,songView,videoView ],titles: ["Album","Bài hát","Video"])
        
        contentView!.addSubview(slidingContainerViewController.view)
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 47
        slidingContainerViewController.setCurrentViewControllerAtIndex(1)
        slidingContainerViewController.sliderView.appearance.backgroundColor = UIColor(patternImage: UIImage(named: "bartop_ios")!)
        slidingContainerViewController.sliderView.appearance.textColor = UIColor.lightTextColor()
        slidingContainerViewController.sliderView.appearance.selectorColor = UIColor(rgba: "#AD50C0")
        slidingContainerViewController.sliderView.appearance.selectedTextColor = UIColor.whiteColor()
        slidingContainerViewController.sliderView.appearance.selectorHeight = 3
        slidingContainerViewController.sliderView.appearance.font = UIFont.boldSystemFontOfSize(17)
        slidingContainerViewController.sliderView.appearance.selectedFont = UIFont.boldSystemFontOfSize(17)
    }
}
