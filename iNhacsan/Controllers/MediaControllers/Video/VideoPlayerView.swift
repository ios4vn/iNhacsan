//
//  VideoPlayerView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/30/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class VideoPlayerView: CPModuleView {
    
    private let kVideoPlayerWillHideControlsNotification = "VideoPlayerWillHideControlsNotitication"
    private let kVideoPlayerWillShowControlsNotification = "VideoPlayerWillShowControlsNotification"

    let MinizeFrameWidth = 320
    let MinizeFrameHeight = 180
    private var totalTime = 0
    private var currentTime = 0
    private var controlShow = true
    
    var playButton = UIButton()
    var likeButton = UIButton()
    var fullscreenButton = UIButton()
    var shareButton = UIButton()
    var downloadButton = UIButton()
    
    var slider = UISlider()
    var lblCurrentTime = UILabel()
    var lblRemainTime = UILabel()
    var containerControl = UIView()
    
    func playButtonPress(){
        playButton.selected = !playButton.selected
        if self.moduleDelegate!.isPlaying() {
            self.moduleDelegate?.pause()
        } else {
            self.moduleDelegate?.play()
        }
    }
    
    func likeButtonPress(){
        NSLog("like touch")
    }
    
    func downloadButtonPress(){
        NSLog("like touch")
    }
    
    func shareButtonPress(){
        NSLog("like touch")
    }
    
    func fullscreenButtonPress(){
        NSLog("fullscreen touch")
    }
    
    func screenTouch(sender: AnyObject?){
        NSLog("screen touch")
        self.toggleShowHideControl()
    }
    
    func toggleShowHideControl() {
        controlShow = !controlShow
        if !controlShow {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.playButton.alpha = 0
                self.likeButton.alpha = 0
                self.shareButton.alpha = 0
                self.fullscreenButton.alpha = 0
                self.downloadButton.alpha = 0
                self.lblCurrentTime.alpha = 0
                self.lblRemainTime.alpha = 0
                self.slider.alpha = 0
            })
        
        }
        else{
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.playButton.alpha = 1
                self.likeButton.alpha = 1
                self.shareButton.alpha = 1
                self.fullscreenButton.alpha = 1
                self.downloadButton.alpha = 1
                self.lblCurrentTime.alpha = 1
                self.lblRemainTime.alpha = 1
                self.slider.alpha = 1
            })
        }
    }
    
    func willPlay() {
        NSLog("willplay")
    }
    
    class func instanceFromNib() -> VideoPlayerView {
        return UINib(nibName: "VideoPlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! VideoPlayerView
    }
    
    override func layoutView() {
        self.frame = CGRectMake(0, 0, 320, 180)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /*Play button*/
        playButton.frame = CGRectMake(130, 60, 60, 60)
        playButton.setImage(UIImage(named: "btn_pause.png"), forState: .Normal)
        playButton.setImage(UIImage(named: "player_icon_play.png"), forState: .Selected)
        playButton.addTarget(self, action: "playButtonPress", forControlEvents: UIControlEvents.TouchUpInside)

        /*Like button*/
        likeButton.frame = CGRectMake(151, 8, 18, 22)
        likeButton.setImage(UIImage(named: "player_icon_like.png"), forState: .Normal)
        likeButton.setImage(UIImage(named: "player_icon_like.png"), forState: .Selected)
        likeButton.addTarget(self, action: "likeButtonPress", forControlEvents: UIControlEvents.TouchUpInside)
        
        /*Fullscreen button*/
        fullscreenButton.frame = CGRectMake(279, 145, 40, 40)
        fullscreenButton.setImage(UIImage(named: "player_icon_fullscreen.png"), forState: .Normal)
        fullscreenButton.addTarget(self, action: "fullscreenButtonPress", forControlEvents: UIControlEvents.TouchUpInside)
        
        /*Download button*/
        downloadButton.frame = CGRectMake(11, 8, 20, 22)
        downloadButton.setImage(UIImage(named: "player_icon_download.png"), forState: .Normal)
        downloadButton.addTarget(self, action: "downloadButtonPress", forControlEvents: UIControlEvents.TouchUpInside)
        
        /*Share button*/
        shareButton.frame = CGRectMake(289, 8, 20, 22)
        shareButton.setImage(UIImage(named: "player_icon_share.png"), forState: .Normal)
        shareButton.addTarget(self, action: "shareButtonPress", forControlEvents: UIControlEvents.TouchUpInside)
        
        /*Others*/
        slider.frame = CGRectMake(32, 150, 218, 31)
        lblCurrentTime.frame = CGRectMake(2, 154, 30, 21)
        lblCurrentTime.font = UIFont.systemFontOfSize(10)
        lblCurrentTime.textColor = UIColor.whiteColor()
        lblRemainTime.frame = CGRectMake(252, 154, 30, 21)
        lblRemainTime.font = UIFont.systemFontOfSize(10)
        lblRemainTime.textColor = UIColor.whiteColor()
        
        /*Container View*/
        containerControl.frame = self.bounds
        containerControl.backgroundColor = UIColor.clearColor()
        
        /*Tap gesture*/
        let screenTouchGesture = UITapGestureRecognizer(target: self, action: "screenTouch:")
        containerControl.addGestureRecognizer(screenTouchGesture)
        containerControl.addSubview(playButton)
        containerControl.addSubview(downloadButton)
        containerControl.addSubview(shareButton)
        containerControl.addSubview(likeButton)
        containerControl.addSubview(fullscreenButton)
        containerControl.addSubview(slider)
        containerControl.addSubview(lblRemainTime)
        containerControl.addSubview(lblCurrentTime)
        
    }
    
    override func initModule() {
        NSLog("initModule")
        self.addSubview(containerControl)
        self.moduleDelegate?.view().addSubview(self)
    }
    
    override func deinitModule() {
        NSLog("deinitModule")
    }
    
    func startPlay() {
        NSLog("startPlay")
    }
    
    func cancelPlay() {
        NSLog("cancelPlay")
    }
    
    func endPlayCode(errCode: Int) {
        NSLog("endPlayCode")
    }
    
    func willSection(cpu: CPUrl) {
        NSLog("willSection")
    }
    
    func startSection(cpu: CPUrl) {
        NSLog("startSection")
    }
    
    func endSection(cpu: CPUrl) {
        NSLog("endSection")
    }
    
    func willPend() {
        NSLog("willPend")
    }
    
    func endPend() {
        NSLog("endPend")
    }
    
    func willPause() {
        NSLog("willPause")
    }
    
    func endPause() {
        NSLog("endPause")
    }
    
    func startSeek(time: NSTimeInterval) {
        NSLog("startSeek")
    }
    
    func seekTo(time: NSTimeInterval) {
        NSLog("seekTo")
    }
    
    func endSeek(time: NSTimeInterval, isEnd: Bool) {
        NSLog("endSeek")
    }
    
    func durationAvailable(duration: NSTimeInterval) {
        totalTime = (Int)(duration)
    }
    
    func played(duration: NSTimeInterval) {
        currentTime = (Int)(duration)
        let minute = (Int)(duration / 60)
        let second = (Int)(duration % 60)
        lblCurrentTime.text = String(format: "%02d:%02d", minute, second)
        let diffTime = totalTime - (Int)(duration)
        lblRemainTime.text = String(format: "-%d:%02d", (diffTime / 60), diffTime % 60)
        self.syncScrubber()
        
    }
    
    func syncScrubber() {
        if totalTime <= 0 {
            slider.minimumValue = 0
        }
        else {
            let minValue = slider.minimumValue
            let maxValue = slider.maximumValue
            slider.value = (maxValue - minValue) * (Float)(currentTime)/(Float)(totalTime) + minValue
        }
    }
    
    func playable(duration: NSTimeInterval) {

    }
    
    func appResign() {
        NSLog("appResign")
    }
    
    func appActive() {
        NSLog("appActive")
    }
    
    func presentationSize(size: CGSize) {
        NSLog("presentationSize")
    }
    
    func airplayShift(on: Bool) {
        NSLog("airplayShift")
    }
    
    func interrupt(reason: InterruptionReason) {
        NSLog("interrupt")
    }
    
    func error(err: Int) {
        NSLog("error")
    }

}
