//
//  PlayerView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/28/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class PlayerView: UIView {

    var avatarUrl: String?
    private var _songName: String?
    var songName: String?{
        get {
            return _songName
        }
        set {
            _songName = newValue
            self.lblSongName.text = newValue
        }
    }
    
    private var _artirtName: String?
    var artirtName: String?{
        get {
            return _artirtName
        }
        set {
            _artirtName = newValue
            self.lblArtirtName.text = newValue
        }
    }
    
    private var _duration: NSTimeInterval?
    var duration: NSTimeInterval?{
        get {
            return _duration
        }
        set {
            _duration = newValue
        }
    }
    
    private var _isPlaying: Bool!
    var isPlaying: Bool! {
        get {
            return _isPlaying
        }
        set {
            _isPlaying = newValue
            if (self.isPlaying == true) {
                self.playBtn.setImage(UIImage(named: "btn_pause.png"), forState: .Normal)
            }
            else {
                self.playBtn.setImage(UIImage(named: "player_icon_play.png"), forState: .Normal)
            }
        }
    }
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var showDetailPlayer: UIButton!
    @IBOutlet weak private var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak private var lblSongName: UILabel!
    @IBOutlet weak private var lblArtirtName: UILabel!
    
    @IBAction func prevButtonTouched(sender: AnyObject) {
        HysteriaPlayer.sharedInstance().playPrevious()
    }
    
    @IBAction func nextButtonTouched(sender: AnyObject) {
        HysteriaPlayer.sharedInstance().playNext()
    }
    
    @IBAction func playButtonTouched(sender: AnyObject) {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        if hysteriaPlayer.isPlaying() {
            hysteriaPlayer.pausePlayerForcibly(true)
            hysteriaPlayer.pause()
        }
        else {
            hysteriaPlayer.pausePlayerForcibly(false)
            hysteriaPlayer.play()
        }
        self.isPlaying = hysteriaPlayer.isPlaying()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
}
