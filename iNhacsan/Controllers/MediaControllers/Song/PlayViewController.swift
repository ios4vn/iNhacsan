//
//  PlayViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/21/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Alamofire
import Realm
import MediaPlayer

class PlayViewController: UIViewController {
    let PageControlHeight: Float = 37
    let PlayerSongCellIdentifier = "PlayerSongCell"
    private var mTimeObserver: AnyObject?
    
    private var _song: Song!
    var song: Song!{
        get{
            return _song
        }
        set{
            _song = newValue
            self.getSongDetail()
        }
    }
    
    var listSongs = [Song]()
    
    @IBOutlet weak private var lblSongName: UILabel!
    @IBOutlet weak private var lblSongArtist: UILabel!
    @IBOutlet weak private var scrMain: UIScrollView!
    @IBOutlet weak private var pgPageControl: UIPageControl!
    
    @IBOutlet weak private var uvPageOne: UIView!
    @IBOutlet weak private var imgThumbnail: UIImageView!
    @IBOutlet weak private var wvLyrics: UIWebView!
    @IBOutlet weak private var clListSongs: UICollectionView!
    @IBOutlet weak private var uvContainerPlayer: UIView!
    @IBOutlet weak private var currentTime: UILabel!
    @IBOutlet weak private var duration: UILabel!
    
    @IBOutlet weak private var downloadButton: UIButton!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var playButton: UIButton!
    @IBOutlet weak private var pauseButton: UIButton!
    @IBOutlet weak private var previousButton: UIButton!
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var repeateButton: UIButton!
    @IBOutlet weak private var shuffleButton: UIButton!
    @IBOutlet weak private var progressSlide: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitView()
        self.setupPlayer()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.showPlayerView = false
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        appDelegate.showPlayerView = true
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSongDetail(){
        if self.song.source == MediaSourceType.Online {
            let parameters = ["act":"getMediaDetail","id":self.song.modelId!]
            Alamofire.request(.GET, GlobalDomain, parameters: parameters)
                .responseJSON {  response in
                    if let JSON = response.result.value {
                        if (JSON.objectForKey("status"))! as! Int == 0 {
                            if let data: AnyObject = JSON.objectForKey("data")?.objectForKey("media"){
//                                self.song.link = data.objectForKey("link") as? String
                                self.song.link = "http://upload.nhacdj.vn/Nonstop/2015/2/14/128/NhacDJ.vn-Nonstop-Vit-Mix-Tuyn-Tp-Ca-Khc-V-Tnh-Yu-Valentine-2015-DJ-CDL-On-The-Mix.mp3"
                                self.song.thumb = data.objectForKey("priavatar") as? String
                                self.song.singer = data.objectForKey("singer") as? String
                                self.song.linkShare = data.objectForKey("link_share") as? String
                                self.song.lyrics = data.objectForKey("lyric") as? String
                                self.song.like = (data.objectForKey("liked") as? Int)!
                                self.song.view = (data.objectForKey("view") as? Int)!
                                self.song.download = (data.objectForKey("download") as? Int)!
                                self.song.isLiked = (data.objectForKey("islike") as? Bool)!
                                self.listSongs.insert(self.song, atIndex: 0)
                                self.resetAndPlayAtIndex(0)
                            }
                        }
                    }
            }
        }
        else {
            let realm = RLMRealm.defaultRealm()
            let results = RLMSong.objectsInRealm(realm, "modelId contains '\(self.song.modelId!)'")
            if let rlmSong = results[(UInt)(0)] as? RLMSong {
                self.song.singer = rlmSong.singer
                self.song.source = MediaSourceType.Offline
//                self.song.linkShare = data["link_share"] as? String
//                self.song.lyrics = data["lyric"] as? String
//                self.song.like = (data["liked"] as? Int)!
//                self.song.view = (data["view"] as? Int)!
//                self.song.link = data["link"] as? String
//                self.song.thumb = data["priavatar"] as? String
//                self.song.download = (data["download"] as? Int)!
//                self.song.isLiked = (data["islike"] as? Bool)!
                self.listSongs.insert(self.song, atIndex: 0)
                self.resetAndPlayAtIndex(0)
            }
        }
    }
    
    func playAlbum(songs: [Song], index: Int){
    
    }
    
    func toggleShuffle() {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        if hysteriaPlayer.getPlayerShuffleMode() == HysteriaPlayerShuffleMode.On {
            hysteriaPlayer.setPlayerShuffleMode(HysteriaPlayerShuffleMode.Off)
            self.shuffleButton.setImage(UIImage(named: "player_btn_shuffle"), forState: .Normal)
        }
        else {
            hysteriaPlayer.setPlayerShuffleMode(HysteriaPlayerShuffleMode.On)
            self.shuffleButton.setImage(UIImage(named: "player_btn_shuffle_active"), forState: .Normal)
        }
    }
    
    func toggleRepeat() {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        if hysteriaPlayer.getPlayerRepeatMode() == HysteriaPlayerRepeatMode.Once {
            self.repeateButton.setImage(UIImage(named: "repeat"), forState: .Normal)
            hysteriaPlayer.setPlayerRepeatMode(HysteriaPlayerRepeatMode.Off)
        }
        else if hysteriaPlayer.getPlayerRepeatMode() == HysteriaPlayerRepeatMode.Off {
            self.repeateButton.setImage(UIImage(named: "player_repeat_full"), forState: .Normal)
            hysteriaPlayer.setPlayerRepeatMode(HysteriaPlayerRepeatMode.On)
        }
        else {
            self.repeateButton.setImage(UIImage(named: "repeat_1"), forState: .Normal)
            hysteriaPlayer.setPlayerRepeatMode(HysteriaPlayerRepeatMode.Once)
        }
    }

    func resetAndPlayAtIndex(index: Int) {
        
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        hysteriaPlayer.removeAllItems()
        hysteriaPlayer.setupSourceGetter({ (idx: UInt) -> NSURL! in
            let song = self.listSongs[(Int)(idx)] as Song
            if song.source == MediaSourceType.Online {
                return NSURL(string:song.link!)!
            }
            else {
                let path = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] 
                let filePath = path.URLByAppendingPathComponent(song.modelId! + ".mp3")
                return filePath
            }
        }, itemsCount: (UInt)(self.listSongs.count))
        self.playSongAtIndex(index)
        
    }
    
    func playSongAtIndex(index: Int){
        let hysteriaPlayer: HysteriaPlayer = HysteriaPlayer.sharedInstance()
        if !hysteriaPlayer.isPlaying() {
            self.play_pause(index)
        }
        hysteriaPlayer.fetchAndPlayPlayerItem((UInt)(index))
    }
    
    func updateViewForPlayer() {
        self.lblSongName.text = self.song.modelName
        self.lblSongArtist.text = self.song.singer
        if let imageUrl = self.song.thumb {
            self.imgThumbnail.kf_setImageWithURL(NSURL(string:imageUrl)!, placeholderImage: noImage)
        }
        else{
            self.imgThumbnail.image = noImage!
        }
        appDelegate.playerView.songName = self.song.modelName
        appDelegate.playerView.artirtName = self.song.singer
        appDelegate.playerView.avatarUrl = self.song.thumb
        self.clListSongs.reloadData()
    }
    
    func setupPlayer() {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        hysteriaPlayer.addDelegate(self)
        hysteriaPlayer.registerHandlerReadyToPlay { (identifier: HysteriaPlayerReadyToPlay) -> Void in
            switch identifier {
            case HysteriaPlayerReadyToPlay.Player:
                self.addAnimation()
                if self.mTimeObserver == nil {
                    self.mTimeObserver = hysteriaPlayer.addPeriodicTimeObserverForInterval(CMTimeMake(100, 1000), queue: nil, usingBlock: { (time: CMTime) -> Void in
                        let totalSecond = CMTimeGetSeconds(time);
                        let minute = (Int)(totalSecond / 60)
                        let second = (Int)(totalSecond % 60)
                        self.currentTime.text = String(format: "%02d:%02d", minute, second)
                        let diffTime = (Int)(hysteriaPlayer.getPlayingItemDurationTime() - hysteriaPlayer.getPlayingItemCurrentTime())
                        self.duration.text = String(format: "-%d:%02d", (diffTime / 60), diffTime % 60)
                        let duration = NSTimeInterval(HysteriaPlayer.sharedInstance().getPlayingItemDurationTime())
                        appDelegate.playerView.duration = duration
                        let artwork : MPMediaItemArtwork = MPMediaItemArtwork(image: noImage!)
                        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo =  [MPMediaItemPropertyTitle : self.song.modelName!,MPMediaItemPropertyPlaybackDuration : duration, MPMediaItemPropertyArtwork : artwork]
                        self.syncScrubber()
                    })
                }
                break
            case HysteriaPlayerReadyToPlay.CurrentItem:
                break
            }
        }
        hysteriaPlayer.registerHandlerFailed { (identifier: HysteriaPlayerFailed,error: NSError!) -> Void in
            
        }
    }
    
    func setupInitView() {
        scrMain.contentSize = CGSizeMake(scrMain.frame.size.width * 3, scrMain.frame.size.height)
        uvPageOne.frame = CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height)
        clListSongs.frame = CGRectMake(scrMain.frame.size.width, (CGFloat)(PageControlHeight),scrMain.frame.size.width, scrMain.frame.size.height - (CGFloat)(PageControlHeight))
        imgThumbnail.layer.cornerRadius = imgThumbnail.frame.size.width/2;
        imgThumbnail.layer.masksToBounds = true;
        imgThumbnail.layer.borderColor = UIColor.whiteColor().CGColor
        imgThumbnail.layer.borderWidth = 3
        scrMain.addSubview(uvPageOne)
        scrMain.addSubview(clListSongs)
    }
    
    func addSongToPlaylist(playlistId: String) {
    
    }

    /* Set the scrubber based on the player current time. */
    func syncScrubber() {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        let durationF = hysteriaPlayer.getPlayingItemDurationTime()
        if durationF <= 0 {
            self.progressSlide.minimumValue = 0
        }
        if isfinite(durationF) && (durationF > 0) {
            let time = hysteriaPlayer.getPlayingItemCurrentTime()
            let minValue = self.progressSlide.minimumValue
            let maxValue = self.progressSlide.maximumValue
            self.progressSlide.value = (maxValue - minValue) * time / durationF + minValue
        }
    }
    
    func syncPlaypauseButtons() {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        switch hysteriaPlayer.getHysteriaPlayerStatus() {
        case .Unknown:
            self.animationDisc(true)
            self.showStopButton()
            break
        case .ForcePause:
            self.animationDisc(false)
            self.showPlayButton()
            break
        case .Buffering:
            self.animationDisc(true)
            self.showStopButton()
            break
        case .Playing:
            self.animationDisc(true)
            self.showStopButton()
            break
        }
    }
    
    func showStopButton() {
        self.pauseButton.hidden = false
        self.playButton.hidden = true
    }
    
    func showPlayButton() {
        self.pauseButton.hidden = true
        self.playButton.hidden = false
    }
    
    func enablePlayerButtons() {
        self.playButton.enabled = true
        self.pauseButton.enabled = true
    }
    
    func disablePlayerButtons() {
        self.playButton.enabled = false
        self.pauseButton.enabled = false
    }

    func addAnimation() {
        let halfTurn = CABasicAnimation(keyPath:"transform.rotation")
        halfTurn.fromValue = 0
        halfTurn.toValue = 360 * M_PI/180
        halfTurn.duration = 20
        halfTurn.repeatCount = Float.infinity
        halfTurn.removedOnCompletion = false
        self.imgThumbnail.layer.addAnimation(halfTurn, forKey: "turnAround")
        appDelegate.playerView.avatar.layer.addAnimation(halfTurn, forKey: "turnAround")
    }
    
    func animationDisc(animated: Bool) {
        if animated {
            self.resumeLayer(appDelegate.playerView.avatar.layer)
            self.resumeLayer(self.imgThumbnail.layer)
        }
        else {
            self.pauseLayer(appDelegate.playerView.avatar.layer)
            self.pauseLayer(self.imgThumbnail.layer)
        }
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer){
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    /*Action*/
    @IBAction func btnDownloadPress(sender: AnyObject) {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        let realmSong = RLMSong()
        realmSong.modelId = song.modelId!
        realmSong.modelName = song.modelName!
        realmSong.singer = song.singer!
        realm.addObject(realmSong)
        realm.commitWriteTransaction()
        LibraryAPI.sharedInstance.download(song.link!, filename: song.modelId! + ".mp3") { (result) -> Void in
            
        }
    }
    
    @IBAction func likePress(sender: AnyObject) {
        LibraryAPI.sharedInstance.like(self.song.modelId!, type: MediaType.Song) { (result) -> Void in
            
        }
    }
    
    @IBAction func btnSharePress(sender: AnyObject) {
        Util.sharedInstance.shareUrl(self.song)
    }
    
    @IBAction func shuffleButtonClick(sender: AnyObject) {
        self.toggleShuffle()
    }
    
    @IBAction func repeateButtonClick(sender: AnyObject) {
        self.toggleRepeat()
    }
    
    @IBAction func playNext(sender: AnyObject) {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        hysteriaPlayer.playNext()
    }
    
    @IBAction func playPreviouse(sender: AnyObject) {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        hysteriaPlayer.playPrevious()
    }
    
    @IBAction func play_pause(sender: AnyObject) {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        if hysteriaPlayer.isPlaying() {
            hysteriaPlayer.pausePlayerForcibly(true)
            hysteriaPlayer.pause()
        }
        else {
            hysteriaPlayer.pausePlayerForcibly(false)
            hysteriaPlayer.play()
        }
    }
    
    @IBAction func beginScrubbing(sender: AnyObject) {
        
    }
    
    @IBAction func scrub(sender: AnyObject) {
        if sender.isKindOfClass(UISlider) {
            let slider: UISlider = sender as! UISlider
            let hysteriaPlayer: HysteriaPlayer = HysteriaPlayer.sharedInstance()
            let durationF: Float = hysteriaPlayer.getPlayingItemDurationTime()
            if durationF <= 0 {
                return
            }
            if isfinite(durationF) {
                let minValue: Float = slider.minimumValue
                let maxValue: Float = slider.maximumValue
                let value: Float = slider.value
                let time: Double = (Double)(durationF * (value - minValue) / (maxValue - minValue))
                hysteriaPlayer.seekToTime(time)
            }
        }
    }
    
    @IBAction func endScrubbing(sender: AnyObject) {
        
    }
    
    @IBAction func backPress() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}

extension PlayViewController: HysteriaPlayerDelegate {
    
    func hysteriaPlayerCurrentItemChanged(item: AVPlayerItem!) {
        let index = HysteriaPlayer.sharedInstance().getHysteriaOrder(item)
        if self.listSongs.count > 0 && index != nil {
            _song = self.listSongs[(Int)(index)] as Song
            self.updateViewForPlayer()
        }
    }
    
    func hysteriaPlayerCurrentItemPreloaded(time: CMTime) {

    }
    
    func hysteriaPlayerDidReachEnd() {

    }
    
    func hysteriaPlayerRateChanged(isPlaying: Bool) {
        self.syncPlaypauseButtons()
    }
    
}

extension PlayViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listSongs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let songModel = self.listSongs[indexPath.row] as Song
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierSong, forIndexPath: indexPath) as! SongCell
        cell.titleName = songModel.modelName
        cell.singerName = songModel.singer!
        return cell
    }
}

extension PlayViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let hysteriaPlayer = HysteriaPlayer.sharedInstance()
        hysteriaPlayer.fetchAndPlayPlayerItem((UInt)(indexPath.row))
    }
    
}

extension PlayViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        let offset = scrollView.contentOffset
        pgPageControl.currentPage = (Int)(offset.x/320)
    }
    
}