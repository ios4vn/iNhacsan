//
//  DLDemoMenuViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let identifiers = ["DLDemoNavigationViewController", "leftSongs", "leftAlbums", "leftVideos"]
    
    private let reuseIdentifier = "MenuCell"
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadSideView() {
        collectionView.reloadData()
    }
    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoNavigationViewController") as! DLHamburguerNavigationController
    }
    
    func rootViewController() -> RootViewController{
        return self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoRootViewController") as! RootViewController
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var imageNamed: String
        var title: String
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MenuCell
        switch (indexPath.row){
        case 0:
            imageNamed = "sidebar_icon_home.png"
            title = "Trang chủ"
        case 1:
            imageNamed = "sidebar_icon_nhacsan.png"
            title = "Nhạc sàn"
        case 2:
            imageNamed = "sidebar_icon_album.png"
            title = "Album"
        case 3:
            imageNamed = "sidebar_icon_video.png"
            title = "Video"
        case 4:
            imageNamed = "sidebar_icon_top.png"
            title = "Top nhạc sàn"
        case 5:
            imageNamed = "sidebar_icon_top.png"
            title = "Top đề cử"
        case 6:
            imageNamed = "sidebar_icon_top.png"
            title = "Top video"
        default:
            imageNamed = "sidebar_icon_top.png"
            title = "Nhạc offline"
        }
        
        cell.icon.image = UIImage(named: imageNamed) as UIImage?
        cell.title.text = title
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                withReuseIdentifier: "MenuHeaderView",
                forIndexPath: indexPath) as! MenuHeaderView

            if AppUser.sharedInstance.isLogin == true {
                headerView.lblAccount.text = "Xin chào, \(AppUser.sharedInstance.username)"
            }
            else {
                headerView.lblAccount.text = "Bạn chưa đăng nhập"
            }
            return headerView
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                withReuseIdentifier: "MenuFooterView",
                forIndexPath: indexPath) as! MenuFooterView
            footerView.isLogin = AppUser.sharedInstance.isLogin
            return footerView
        default :
            assert(false, "Unexpected element kind")
        }
    }
}

extension MenuViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let nvc = self.mainNavigationController()
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                var contentViewController:UINavigationController!
                switch indexPath.row {
                case 0:
                    contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(self.identifiers[indexPath.row]) as! UINavigationController
                    break
                case 1:
                    contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(self.identifiers[indexPath.row]) as! UINavigationController
                    break
                case 2:
                    contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(self.identifiers[indexPath.row]) as! UINavigationController
                    break
                case 3:
                    contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(self.identifiers[indexPath.row]) as! UINavigationController
                    break
                case 4:
                    var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("SongTop") as! SongListViewController
                    viewController.parameters["act"] = "getTopMedia"
                    viewController.parameters["type"] = "top_nhac_san"
                    viewController.titleName = "Top nhạc sàn"
                    contentViewController = UINavigationController(rootViewController: viewController)
                    break
                case 5:
                    var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("SongTop") as! SongListViewController
                    viewController.parameters["act"] = "getTopMedia"
                    viewController.parameters["type"] = "top_de_cu"
                    viewController.titleName = "Top đề cử"
                    contentViewController = UINavigationController(rootViewController: viewController)
                    break
                case 6:
                    var viewController = self.storyboard?.instantiateViewControllerWithIdentifier("VideoTop") as! VideoListViewController
                    viewController.parameters["act"] = "getTopMedia"
                    viewController.parameters["type"] = "top_video"
                    viewController.titleName = "Top video"
                    contentViewController = UINavigationController(rootViewController: viewController)
                case 7:
                    contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OfflineView") as! UINavigationController
                    break
                default:
                    break
                }
                hamburguerViewController.contentViewController = contentViewController
            })
        }
        
    }
    
}
