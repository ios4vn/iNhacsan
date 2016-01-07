//
//  HTCollectionViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/16/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Alamofire

let PageSize = 10

enum INSPullToRefreshStyle {
    case Default
    case Circle
    case Twitter
    case Facebook
    case Lappsy
    case Vine
    case Pinterest
    case Text
    case PreserveContentInset
}

class HTCollectionViewController: BaseViewController {
    
    var keyData: String = ""
    var parameters = [String: String]()
    var currentPage = 0
    var data = [[String: AnyObject]]()
    var style: INSPullToRefreshStyle = INSPullToRefreshStyle.Default
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.ins_addPullToRefreshWithHeight((CGFloat)(60), handler: { (scrollView: UIScrollView!) -> Void in
            let delayInSeconds: Int64 = 1
            let popTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {() in
                self.refresh({ () -> Void in
                    scrollView.ins_endPullToRefresh()
                })
            })
        })

        self.collectionView.ins_addInfinityScrollWithHeight((CGFloat)(60), handler: { (scrollView: UIScrollView!) -> Void in
            self.loadMoreContent({ () -> Void in
                scrollView.ins_endInfinityScroll()
            })
        })

        let infinityIndicator: AnyObject = self.infinityIndicatorViewFromCurrentStyle() as AnyObject
        self.collectionView.ins_infiniteScrollBackgroundView.addSubview(infinityIndicator as! UIView)
        (infinityIndicator as! INSAnimatable).startAnimating()
        self.collectionView.ins_infiniteScrollBackgroundView.preserveContentInset = false
        
        let pullToRefresh: AnyObject = self.pullToRefreshViewFromCurrentStyle() as AnyObject
        self.collectionView.ins_pullToRefreshBackgroundView.delegate = (pullToRefresh as! INSPullToRefreshBackgroundViewDelegate)
        self.collectionView.ins_pullToRefreshBackgroundView.addSubview(pullToRefresh as! UIView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        data.removeAll(keepCapacity: false)
        self.refresh { () -> Void in
            
        }
    }
    
    func refresh(completion: () -> Void) {
        currentPage = 0
        self.loadMoreContent { () -> Void in
            completion()
        }
    }
    
    func loadMoreContent(completion: () -> Void) {
        currentPage++
        parameters["limit"] = "\(PageSize)"
        parameters["page"] = "\(currentPage)"
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    self.processResponse(JSON)
                    self.collectionView.reloadData()
                }
        }
    }
    
    func processResponse(JSON: AnyObject?) {
        if keyData == "" {
            if let tmpdata = JSON?.objectForKey("data") as? [[String: AnyObject]] {
                data += tmpdata
            }
        }
        else {
            if let tmpdata = (JSON?.objectForKey("data")?.objectForKey(self.keyData) as? [[String: AnyObject]]){
                data += tmpdata
            }

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HTCollectionViewController {
    
    func pullToRefreshViewFromCurrentStyle() -> UIView {
        let defaultFrame: CGRect = CGRectMake(0, 0, 24, 24)
        switch self.style {
        case .Circle:
            return INSCirclePullToRefresh(frame: defaultFrame)
        case .Twitter:
            return INSTwitterPullToRefresh(frame: defaultFrame)
        case .Facebook:
            return INSDefaultPullToRefresh(frame: defaultFrame, backImage: nil, frontImage: UIImage(named: "iconFacebook"))
        case .Lappsy:
            return INSLappsyPullToRefresh(frame: defaultFrame)
        case .Pinterest:
            return INSPinterestPullToRefresh(frame: defaultFrame, logo: UIImage(named: "iconPinterestLogo"), backImage: UIImage(named: "iconPinterestCircleLight"), frontImage: UIImage(named:"iconPinterestCircleDark"))
        case .Vine:
            return INSVinePullToRefresh(frame: defaultFrame)
        case .Text:
            return INSLabelPullToRefresh(frame: CGRectMake(0, 0, self.view.frame.size.width, 60.0), noneStateText: "Pull to refresh", triggeredStateText: "Release to refresh", loadingStateText: "Loading...")
        default:
            return INSDefaultPullToRefresh(frame: defaultFrame, backImage: UIImage(named: "circleLight"), frontImage: UIImage(named: "circleDark"))
        }
    }
    
    func infinityIndicatorViewFromCurrentStyle() -> UIView {
        let defaultFrame: CGRect = CGRectMake(0, 0, 24, 24)
        switch self.style {
        case .Circle:
            return INSCircleInfiniteIndicator(frame: defaultFrame)
        case .Lappsy:
            return INSLappsyInfiniteIndicator(frame: defaultFrame)
        default:
            return INSDefaultInfiniteIndicator(frame: defaultFrame)
        }
    }
    
}

extension HTCollectionViewController: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
