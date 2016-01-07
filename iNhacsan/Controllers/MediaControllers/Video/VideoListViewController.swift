//
//  VideoListViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/6/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class VideoListViewController: HTCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension VideoListViewController {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let video = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierVideo, forIndexPath: indexPath) as! VideoCell
        cell.titleName = video["name"] as? String
        cell.imageUrl = video["priavatar"] as? String
        cell.singerName = video["singer"] as? String
        return cell
    }
    
}

extension VideoListViewController: UICollectionViewDelegate {

}
