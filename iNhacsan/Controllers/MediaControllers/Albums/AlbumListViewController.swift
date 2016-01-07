//
//  AlbumListViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/5/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class AlbumListViewController: HTCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func processResponse(JSON: AnyObject?) {
//        if let tmpdata = (JSON?.objectForKey("data")?.objectForKey(self.keyData) as? [[String: AnyObject]]){
//            data += tmpdata
//        }
//        self.collectionView.reloadData()
//    }
    
}

extension AlbumListViewController {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierAlbum, forIndexPath: indexPath) as! AlbumCell
        cell.titleName = album["name"] as? String
        cell.imageUrl = album["priavatar"] as? String
        return cell
    }
}


extension AlbumListViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){

        let albumJson = data[indexPath.row]
        let albumModel = Album(modelId: (albumJson["id"] as? String)!, modelName: (albumJson["name"] as? String)!)
        albumModel.thumb = albumJson["priavatar"] as? String
        let albumDetail = self.storyboard!.instantiateViewControllerWithIdentifier("albumDetailViewController") as! AlbumDetailViewController
        albumDetail.titleName = albumModel.modelName
        albumDetail.album = albumModel
        self.navigationController?.pushViewController(albumDetail, animated: true)
        
    }
    
}




