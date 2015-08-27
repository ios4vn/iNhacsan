//
//  AlbumDetailViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/31/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class AlbumDetailViewController: BaseViewController {
    
    private var _album: Album!
    var album: Album!{
        get{
            return _album
        }
        set{
            _album = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showBannerView = false
        self.titleName = album.modelName
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
        var relateAlbums = self.storyboard?.instantiateViewControllerWithIdentifier("albumList") as! AlbumListViewController
        relateAlbums.parameters["act"] = "getOtherList"
        relateAlbums.parameters["type"] = "album"
        relateAlbums.parameters["id"] = self.album.modelId!
        relateAlbums.keyData = "other"
        relateAlbums.showBannerView = false
        
        var albumDetail = self.storyboard?.instantiateViewControllerWithIdentifier("albumSongs") as! AlbumSongsViewController
        albumDetail.album = album
        albumDetail.showBannerView = false
        
        let albumComments = self.storyboard?.instantiateViewControllerWithIdentifier("CommentsView") as! CommentsViewController
        albumComments.showBannerView = false
        
        let slidingContainerViewController = SlidingContainerViewController (parent: self,contentViewControllers: [relateAlbums,albumDetail,albumComments ],titles: ["Gợi ý","Bài hát","Bình luận"])

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
