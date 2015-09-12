//
//  OfflineViewViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 9/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Realm

class OfflineViewController: HTCollectionViewController {
    
    var offlineSongs: RLMResults!

    override func viewDidLoad() {
        titleName = "Nhạc đã tải"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        offlineSongs = RLMSong.allObjects()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension OfflineViewController: UICollectionViewDataSource {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(offlineSongs.count)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let song = offlineSongs[(UInt)(indexPath.row)] as! RLMSong
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierSong, forIndexPath: indexPath) as! SongCell
        cell.titleName = song.modelName
        cell.singerName = song.singer
        return cell
    }
}

extension OfflineViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let song = offlineSongs[(UInt)(indexPath.row)] as! RLMSong
        let songModel = Song(modelId: song.modelId, modelName: song.modelName)
        songModel.source = MediaSourceType.Offline
        appDelegate.playerViewController.song = songModel
        self.navigationController?.pushViewController(appDelegate.playerViewController, animated: true)
    }
    
}
