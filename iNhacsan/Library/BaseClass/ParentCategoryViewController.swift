//
//  ParentCategoryViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/22/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Alamofire

class ParentCategoryViewController: BaseViewController {
    
    var parameters = [String: String]()
    var categories = [[String: AnyObject]]()
    var viewControllerIdentifier = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    self.processResponse(JSON)
                }
        }
    }
    
    func processResponse(JSON: AnyObject?) {
        categories = (JSON?.objectForKey("data")?.objectForKey("category") as? [[String: AnyObject]])!
        if categories.count > 0 {
            var controllers: [UIViewController] = [UIViewController]()
            var titles: [String] = [String]()
            for category in categories {
                let categoryViewController = self.storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifier) as! ChildCategoryViewController
                let categoryObj = Category()
                categoryObj.initWithObject(category)
                categoryViewController.category = categoryObj
                controllers.append(categoryViewController)
                titles.append(categoryObj.modelName!)
            }
            
            let slidingContainerViewController = SlidingContainerViewController (parent: self,contentViewControllers: controllers,titles: titles)
            view.addSubview(slidingContainerViewController.view)
            
            slidingContainerViewController.sliderView.appearance.outerPadding = 20
            slidingContainerViewController.sliderView.appearance.innerPadding = 47
            slidingContainerViewController.setCurrentViewControllerAtIndex(0)
            slidingContainerViewController.sliderView.appearance.textColor = UIColor.lightTextColor()
            slidingContainerViewController.sliderView.appearance.backgroundColor = UIColor(patternImage: UIImage(named: "bartop_ios")!)
            slidingContainerViewController.sliderView.appearance.selectorColor = UIColor(rgba: "#AD50C0")
            slidingContainerViewController.sliderView.appearance.selectedTextColor = UIColor.whiteColor()
            slidingContainerViewController.sliderView.appearance.selectorHeight = 3
            slidingContainerViewController.sliderView.appearance.font = UIFont.boldSystemFontOfSize(17)
            slidingContainerViewController.sliderView.appearance.selectedFont = UIFont.boldSystemFontOfSize(17)
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
