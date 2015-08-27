//
//  SongCategoriesViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/22/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class SongCategoriesViewController: ChildCategoryViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parameters["type"] = "audio"
        self.refresh { () -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SongCategoriesViewController: UICollectionViewDataSource {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierSong, forIndexPath: indexPath) as! SongCell
        cell.titleName = album["name"] as? String
        cell.singerName = album["singer"] as? String
        return cell
    }
}

extension SongCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let songJson = data[indexPath.row]
        let songModel = Song(modelId: (songJson["id"] as? String)!, modelName: (songJson["name"] as? String)!)
        appDelegate.playerViewController.song = songModel
        self.navigationController?.pushViewController(appDelegate.playerViewController, animated: true)
    }

}
