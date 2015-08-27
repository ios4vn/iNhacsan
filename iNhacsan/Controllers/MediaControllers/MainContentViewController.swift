//
//  DLDemoMainContentViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Alamofire

let GlobalDomain = "http://inhacsan.vn/app"
let reuseIdentifierSong = "SongCell"
let reuseIdentifierVideo = "VideoCell"
let reuseIdentifierAlbum = "AlbumCell"

class MainContentViewController: HTCollectionViewController {

    let segues = ["album","video","song"]
    var slides = [[String: AnyObject]]()
    var videos = [[String: AnyObject]]()
    var albums = [[String: AnyObject]]()
    var songs = [[String: AnyObject]]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parameters["act"] = "getHome"
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var logo = UIImage(named: "sidebar_logo.png") as UIImage?
        self.navigationItem.titleView = UIImageView(image: logo)
    }
    
    override func processResponse(JSON: AnyObject?) {
        
        var data: AnyObject? = JSON?.objectForKey("data")!
        slides = data?.objectForKey("slide") as! [([String : AnyObject])]
        songs = data?.objectForKey("audio") as! [([String : AnyObject])]
        albums = data?.objectForKey("album") as! [([String : AnyObject])]
        videos = data?.objectForKey("video") as! [([String : AnyObject])]
        self.collectionView?.reloadData()
        
    }
}

extension MainContentViewController : UICollectionViewDataSource {

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return albums.count
        case 2:
            return videos.count
        case 3:
            return songs.count
        default:
            return 0
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            let album = albums[indexPath.row]
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                reuseIdentifierAlbum, forIndexPath: indexPath) as! AlbumCell
            cell.titleName = album["name"] as? String
            cell.imageUrl = album["priavatar"] as? String
            return cell
        case 2:
            let video = videos[indexPath.row]
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                reuseIdentifierVideo, forIndexPath: indexPath) as! VideoCell
            cell.titleName = video["name"] as? String
            cell.imageUrl = video["priavatar"] as? String
            cell.singerName = video["singer"] as? String
            return cell
        case 3:
            let song = songs[indexPath.row]
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                reuseIdentifierSong, forIndexPath: indexPath) as! SongCell
            cell.titleName = song["name"] as? String
            cell.singerName = song["singer"] as? String
            return cell
        default:
            break
        }
        return UICollectionViewCell.alloc()
    }
    
    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionElementKindSectionHeader:
                switch indexPath.section {
                case 0:
                    let headerView =
                    collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                        withReuseIdentifier: "HomeSlideReusableView",
                        forIndexPath: indexPath)
                        as! HomeSlideReusableView
                    if slides.count > 0 {
                        if let tmpSlides = slides as [[String: AnyObject]]?  {
                            headerView.homeSlide.slides = tmpSlides
                        }
                    }
                    return headerView
                default:
                    assert(false, "Unexpected element header")
                }
            case UICollectionElementKindSectionFooter:
                var titleSection: String?
                switch indexPath.section{
                case 0:
                    titleSection = "Album"
                    break
                case 1:
                    titleSection = "MV"
                    break
                case 2:
                    titleSection = "Bài hát"
                    break
                default:
                    break;
                }
                let footerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "HomeSectionReusableView",
                    forIndexPath: indexPath)
                    as! HomeSectionReusableView
                footerView.delegate = self
                footerView.index = indexPath.section
                footerView.titleName = titleSection
                return footerView
            default:
                assert(false, "Unexpected element kind")
            }
            assert(false, "Unexpected element kind")
    }
}

extension MainContentViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            return CGSizeMake(160, 160)
        case 2:
            return CGSizeMake(160, 130)
        case 3:
            return CGSizeMake(320, 60)
        default:
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(320, 160)
        }

        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section < 3 {
            return CGSizeMake(320, 30)
        }
        return CGSizeZero
    }
    
}

extension MainContentViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        switch indexPath.section{
        case 0:
            break
        case 1:
            let albumJson = albums[indexPath.row]
            var albumModel = Album(modelId: (albumJson["id"] as? String)!, modelName: (albumJson["name"] as? String)!)
            albumModel.thumb = albumJson["priavatar"] as? String
            let albumDetail = self.storyboard!.instantiateViewControllerWithIdentifier("albumDetailViewController") as! AlbumDetailViewController
            albumDetail.titleName = albumModel.modelName
            albumDetail.album = albumModel
            self.navigationController?.pushViewController(albumDetail, animated: true)
            break
        case 2:
            let videoJson = videos[indexPath.row]
            let videoModel = Video(modelId: (videoJson["id"] as? String)!, modelName: (videoJson["name"] as? String)!)
            let videoDetail = self.storyboard!.instantiateViewControllerWithIdentifier("videoDetailViewController") as! VideoDetailViewController
            videoDetail.video = videoModel
            self.navigationController?.pushViewController(videoDetail, animated: true)
            break
        default:
            let songJson = songs[indexPath.row]
            let songModel = Song(modelId: (songJson["id"] as? String)!, modelName: (songJson["name"] as? String)!)
            appDelegate.playerViewController.song = songModel
            self.navigationController?.pushViewController(appDelegate.playerViewController, animated: true)
            break
            
        }
    }
    
}

extension MainContentViewController: HomeSectionDelegate {

    func didSelectMorePressAtIndex(index: Int){
        self.navigationController?.visibleViewController.performSegueWithIdentifier(self.segues[index], sender: nil)
    }
    
}
