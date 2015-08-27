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
        let parameters = ["act":"getMediaDetail","id":self.song.modelId!]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { (_, _, JSON, _) in
                if (JSON?.objectForKey("status"))! as! Int == 0 {
                    if let data: AnyObject = JSON?.objectForKey("data")?.objectForKey("media"){
                        self.song.link = data["link"] as? String
                        self.song.thumb = data["priavatar"] as? String
                        self.song.singer = data["singer"] as? String
                        self.song.linkShare = data["link_share"] as? String
                        self.song.lyrics = data["lyric"] as? String
                        self.song.like = (data["liked"] as? Int)!
                        self.song.view = (data["view"] as? Int)!
                        self.song.download = (data["download"] as? Int)!
                        self.song.isLiked = (data["islike"] as? Bool)!
                        self.listSongs.insert(self.song, atIndex: 0)
                        self.resetAndPlayAtIndex(0)
                    }
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
            return NSURL(string:song.link!)!
        }, itemsCount: (UInt)(self.listSongs.count))
        self.playSongAtIndex(index)
        
    }
    
    func playSongAtIndex(index: Int){
        var hysteriaPlayer: HysteriaPlayer = HysteriaPlayer.sharedInstance()
        if !hysteriaPlayer.isPlaying() {
            self.play_pause(index)
        }
        hysteriaPlayer.fetchAndPlayPlayerItem((UInt)(index))
    }
    
    func updateViewForPlayer() {
        
        self.lblSongName.text = self.song.modelName
        self.lblSongArtist.text = self.song.singer
        if let imageUrl = self.song.thumb {
            self.imgThumbnail.setImageWithUrlRequest(NSURLRequest(URL: NSURL(string:imageUrl)!), placeHolderImage: nil, success: { (request, response, image, fromCache) -> Void in
                    self.imgThumbnail.image = image
                }) { (request, response, error) -> Void in
                    self.imgThumbnail.image = noImage!
            }
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
                        appDelegate.playerView.duration =  NSTimeInterval(HysteriaPlayer.sharedInstance().getPlayingItemDurationTime())
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
        default:
            break
        }
    }
    
    func showStopButton() {
        self.pauseButton.hidden = false
        self.playButton.hidden = true
//        SharedAppDelegate.playerView.isPlaying = YES;
    }
    
    func showPlayButton() {
        self.pauseButton.hidden = true
        self.playButton.hidden = false
        //        SharedAppDelegate.playerView.isPlaying = NO;
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
        var pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer){
        var pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        var timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    /*Action*/
    @IBAction func btnDownloadPress(sender: AnyObject) {
        var realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
    }
    
    @IBAction func likePress(sender: AnyObject) {

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
            var slider: UISlider = sender as! UISlider
            var hysteriaPlayer: HysteriaPlayer = HysteriaPlayer.sharedInstance()
            var durationF: Float = hysteriaPlayer.getPlayingItemDurationTime()
            if durationF <= 0 {
                return
            }
            if isfinite(durationF) {
                var minValue: Float = slider.minimumValue
                var maxValue: Float = slider.maximumValue
                var value: Float = slider.value
                var time: Double = (Double)(durationF * (value - minValue) / (maxValue - minValue))
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
        var offset = scrollView.contentOffset
        pgPageControl.currentPage = (Int)(offset.x/320)
    }
    
}