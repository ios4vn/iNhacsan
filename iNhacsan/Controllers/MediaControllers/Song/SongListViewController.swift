//
//  SongListViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/6/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SongListViewController: HTCollectionViewController {
    
    var delegate: SongListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension SongListViewController: UICollectionViewDataSource {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierSong, forIndexPath: indexPath) as! SongCell
        cell.titleName = album["name"] as? String
        cell.singerName = album["singer"] as? String
        return cell
    }
}

extension SongListViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if delegate?.didSelectItemAtIndexPath(indexPath) == nil {
            let songJson = data[indexPath.row]
            let songModel = Song(modelId: (songJson["id"] as? String)!, modelName: (songJson["name"] as? String)!)
            appDelegate.playerViewController.song = songModel
            self.navigationController?.pushViewController(appDelegate.playerViewController, animated: true)
        }
        else {
            delegate?.didSelectItemAtIndexPath(indexPath)
        }
    }
    
}

protocol SongListDelegate {
    
    func didSelectItemAtIndexPath(indexPaht: NSIndexPath)
    
}