//
//  AlbumSongsViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/1/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

let reuseIdentifierAlbumSong = "AlbumSongCell"

class AlbumSongsViewController: HTCollectionViewController {
    
    var album: Album!
    
    @IBOutlet weak private var playAllButton: UIButton!
    @IBOutlet weak private var albumThumbImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        keyData = "song"
        let url: NSURL = NSURL(string: album.thumb!
            )!
        albumThumbImage.kf_setImageWithURL(url, placeholderImage: noImage)
        parameters["act"] = "getAlbumDetail"
        parameters["id"] = album.modelId!
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func processResponse(JSON: AnyObject?) {
//        if JSON?.objectForKey("data") is String {
//
//        }
//        else {
//            data += (JSON?.objectForKey("data")?.objectForKey("song") as? [[String: AnyObject]])!
//            self.collectionView.reloadData()
//        }
//    }

    func playAlbumAtIndex(index: Int) {
        appDelegate.playerViewController.listSongs.removeAll(keepCapacity: false)
        for (_, element) in data.enumerate() {
            let songModel = Song()
            songModel.modelId = element["id"] as? String
            songModel.modelName = element["name"] as? String
            songModel.singer = element["singer"] as? String
            songModel.link = (element["link"] as? String)?.getImageUrl()
            appDelegate.playerViewController.listSongs.append(songModel)
        }
        appDelegate.playerViewController.resetAndPlayAtIndex(index)
        self.navigationController?.pushViewController(appDelegate.playerViewController, animated: true)
    }
    
    @IBAction func playAlbumPress(sender: AnyObject?){
        self.playAlbumAtIndex(0)
    }
    
    @IBAction func downloadPress(){
    
    }
    
    @IBAction func likePress(){
        
    }
    
    @IBAction func sharePress(){
        
    }

}

extension AlbumSongsViewController {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierAlbumSong, forIndexPath: indexPath) as! AlbumSongCell
        cell.titleName = album["name"] as? String
        cell.rank = "\(indexPath.row + 1)"
        return cell
    }
}

extension AlbumSongsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        self.playAlbumAtIndex(indexPath.row)
    }
    
}

