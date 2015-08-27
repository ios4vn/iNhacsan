//
//  AlbumsViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/21/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class AlbumsViewController: HTCollectionViewController {

    override func viewDidLoad() {
        self.titleName = "Album"
        super.viewDidLoad()
        parameters["act"] = "getAlbum"
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func processResponse(JSON: AnyObject?) {
        data += (JSON?.objectForKey("data")?.objectForKey("album") as? [[String: AnyObject]])!
        self.collectionView.reloadData()
    }

}

extension AlbumsViewController: UICollectionViewDataSource {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierAlbum, forIndexPath: indexPath) as! AlbumCell
        cell.titleName = album["name"] as? String
        cell.imageUrl = album["priavatar"] as? String
        return cell
    }
}

extension AlbumsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let albumJson = data[indexPath.row]
        var albumModel = Album(modelId: (albumJson["id"] as? String)!, modelName: (albumJson["name"] as? String)!)
        albumModel.thumb = albumJson["priavatar"] as? String
        let albumDetail = self.storyboard!.instantiateViewControllerWithIdentifier("albumDetailViewController") as! AlbumDetailViewController
        albumDetail.titleName = albumModel.modelName
        albumDetail.album = albumModel
        self.navigationController?.pushViewController(albumDetail, animated: true)
    }
    
}


