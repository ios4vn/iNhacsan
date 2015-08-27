//
//  BaseViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/2/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Alamofire

let BannerHeight: CGFloat = 44
let noImage = UIImage(named: "no_image.png")

class BaseViewController: UIViewController {

    @IBOutlet var topConstraint: NSLayoutConstraint?
    @IBOutlet var contentView: UIView?
    var showBannerView: Bool!
    var searchBar: INSSearchBar!
    var leftItem:UIBarButtonItem = UIBarButtonItem()
    private var lblHeaderTitle: UILabel!
    private var _titleName:String!
    var titleName:String!{
        get{
            return _titleName
        }
        set{
            _titleName = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showBannerView == nil {
            showBannerView = true
        }
        self.setupNavigationBar()
        lblHeaderTitle.text = self.titleName
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setupSearchBar()
        if showBannerView == true {
            var frameForBanner = CGRectMake(0,self.view.frame.origin.y == 64 ? 0:64, self.view.frame.size.width, BannerHeight)
            appDelegate.bannerView.frame = frameForBanner
            self.view.addSubview(appDelegate.bannerView)
            self.topConstraint?.constant = frameForBanner.height
            self.view.layoutSubviews()
        }
        else {
            self.topConstraint?.constant = 0
            appDelegate.bannerView.frame = CGRectZero
        }
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            contentView?.layoutIfNeeded()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSearchBar(){
        searchBar = INSSearchBar(frame: CGRectMake(self.view.frame.size.width - 54, 5, 44, 34))
        searchBar.delegate = self
        self.navigationController?.navigationBar.addSubview(searchBar)
    }
    
    func setupNavigationBar() {

        /*Background color*/
        let bgColor = UIColor(rgba: "#12171E")
        view.backgroundColor = bgColor
        
        /*Background navigation bar image*/
        var bgImage = UIImage(named: "bartop_ios.png") as UIImage?
        self.navigationController?.navigationBar.setBackgroundImage(bgImage,
            forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        /*Left bar button item*/
        if self.navigationController?.viewControllers.count > 1 {
            var backButton: UIButton = UIButton()
            backButton.setImage(UIImage(named: "btn_back"), forState: .Normal)
            backButton.frame = CGRectMake(0, 0, 45, 45)
            backButton.addTarget(self, action: "backPress", forControlEvents: .TouchUpInside)
            var leftItem:UIBarButtonItem = UIBarButtonItem()
            leftItem.customView = backButton
            self.navigationItem.leftBarButtonItem = leftItem
        }
        else{
            var menuButton: UIButton = UIButton()
            menuButton.setImage(UIImage(named: "btn-menu.png"), forState: .Normal)
            menuButton.frame = CGRectMake(0, 0, 45, 45)
            menuButton.addTarget(self, action: "menuPress", forControlEvents: .TouchUpInside)
            leftItem.customView = menuButton
            self.navigationItem.leftBarButtonItem = leftItem
        }
        
        /*Header title*/
        lblHeaderTitle = UILabel()
        lblHeaderTitle.frame = CGRectMake(0, 0, 120, 45)
        lblHeaderTitle.textAlignment = NSTextAlignment.Center
        lblHeaderTitle.font = UIFont.boldSystemFontOfSize(20)
        lblHeaderTitle.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = lblHeaderTitle
        
    }
    
    func backPress(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func menuPress(){
        self.findHamburguerViewController()?.showMenuViewController()
    }
}

extension BaseViewController: INSSearchBarDelegate {

    func destinationFrameForSearchBar(searchBar: INSSearchBar!) -> CGRect {
        return CGRectMake(10, 5, self.view.frame.size.width - 20, 34)
    }
    
    func searchBar(searchBar: INSSearchBar!, willStartTransitioningToState destinationState: INSSearchBarState) {
        leftItem.enabled = !leftItem.enabled
    }
    
    func searchBar(searchBar: INSSearchBar!, didEndTransitioningFromState previousState: INSSearchBarState) {
        
    }
    
    func searchBarDidTapReturn(searchBar: INSSearchBar!) {
        if searchBar.searchField.text != "" {
            var searchView = self.storyboard?.instantiateViewControllerWithIdentifier("SearchView") as! SearchViewController
            searchView.keyword = searchBar.searchField.text
            searchView.showBannerView = false
            self.navigationController?.pushViewController(searchView, animated: true)
        }
        searchBar.hideSearchBar(nil)
    }
    
    func searchBarTextDidChange(searchBar: INSSearchBar!) {

    }
}
