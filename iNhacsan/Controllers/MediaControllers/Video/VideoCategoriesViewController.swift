//
//  VideoCategoriesViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/21/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class VideoCategoriesViewController: ChildCategoryViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parameters["type"] = "video"
        self.initData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension VideoCategoriesViewController {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let album = data[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifierVideo, forIndexPath: indexPath) as! VideoCell
        cell.titleName = album["name"] as? String
        cell.imageUrl = album["priavatar"] as? String
        cell.singerName = album["singer"] as? String
        return cell
    }
}

extension VideoCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let videoJson = data[indexPath.row]
        let videoModel = Video(modelId: (videoJson["id"] as? String)!, modelName: (videoJson["name"] as? String)!)
        let videoDetail = self.storyboard!.instantiateViewControllerWithIdentifier("videoDetailViewController") as! VideoDetailViewController
        videoDetail.video = videoModel
        self.navigationController?.pushViewController(videoDetail, animated: true)
    }
    
}