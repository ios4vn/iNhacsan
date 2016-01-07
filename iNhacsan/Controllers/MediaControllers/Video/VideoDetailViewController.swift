//
//  VideoDetailViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/30/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import AVFoundation

class VideoDetailViewController: HTCollectionViewController {

    var corePlayer: CorePlayer?
    var segment: DZNSegmentedControl!
    
    @IBOutlet private var scrMain: UIScrollView!
    @IBOutlet private var wvLyrics: UIWebView!
    
    private var _video: Video!
    var video: Video!{
        get{
            return _video
        }
        set{
            _video = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        LibraryAPI.sharedInstance.getMediaDetail(self.video.modelId!, completion: { (result) -> Void in
            if (result?.objectForKey("status"))! as! Int == 0 {
                if let data: AnyObject = result?.objectForKey("data")?.objectForKey("media"){
                    self.video.link = data.objectForKey("link") as? String
                    self.video.thumb = data.objectForKey("priavatar") as? String
                    self.video.singer = data.objectForKey("singer") as? String
                    self.video.linkShare = data.objectForKey("link_share") as? String
                    self.video.lyrics = data.objectForKey("lyric") as? String
                    self.wvLyrics.loadHTMLString("<body style='background-color: transparent;color:#fff;text-align:center;'>\(self.video.lyrics!)</body>", baseURL: nil)
                    self.video.like = (data.objectForKey("liked") as? Int)!
                    self.video.view = (data.objectForKey("view") as? Int)!
                    self.video.download = (data.objectForKey("download") as? Int)!
                    self.video.isLiked = (data.objectForKey("islike") as? Bool)!
                    self.corePlayer!.playURL(NSURL(string: self.video.link!)!)
                    self.parameters["act"] = "getOtherList"
                    self.parameters["id"] = self.video.modelId
                    self.parameters["type"] = "video"
                    self.initData()
                }
            }
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        corePlayer?.stopPlaybackSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView(){
        self.titleName = self.video.modelName!
        
        corePlayer = CorePlayer()
        corePlayer!.moduleManager().initModules([VideoPlayerView.self])
        corePlayer!.view().frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.width/16*9)
        view.addSubview(corePlayer!.view())
        
        segment = DZNSegmentedControl(items: ["Clip liên quan","Mô tả","Bình luận"])
        segment.frame = CGRectMake(0, 244, self.view.frame.size.width, 36)
        segment.height = 36
        segment.showsCount = false
        segment.tintColor = UIColor(rgba: "#AD50C0")
        segment.backgroundColor = UIColor.clearColor()
        segment.hairlineColor = UIColor.clearColor()
        segment.addTarget(self, action: "selectedSegment:", forControlEvents: UIControlEvents.ValueChanged)
//        scrMain.contentSize = CGSizeMake(scrMain.frame.size.width*3, scrMain.frame.size.height)
        collectionView.frame = CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height)
        wvLyrics.frame = CGRectMake(scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)
        scrMain.setContentOffset(CGPointZero, animated: true)
        scrMain.addSubview(collectionView)
        scrMain.addSubview(wvLyrics)
        self.view.addSubview(segment)
        
    }
    
    override func processResponse(JSON: AnyObject?) {
        data = (JSON?.objectForKey("data")?.objectForKey("other") as? [[String: AnyObject]])!
    }
    
    func selectedSegment(sender: AnyObject?){
        let segment = sender as! DZNSegmentedControl
        let contentOffset = CGPointMake(scrMain.frame.size.width * (CGFloat)(segment.selectedSegmentIndex), 0)
        self.scrMain.setContentOffset(contentOffset, animated: true)
    }
    
}

extension VideoDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        let contentOffset = scrollView.contentOffset
        segment.selectedSegmentIndex = (Int)(contentOffset.x/self.scrMain.frame.size.width)
    }

}

extension VideoDetailViewController: UICollectionViewDelegate {

}

extension VideoDetailViewController {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierVideo, forIndexPath: indexPath) as! VideoCell
        cell.titleName = album["name"] as? String
        cell.imageUrl = album["priavatar"] as? String
        cell.singerName = album["singer"] as? String
        return cell
    }
    
}