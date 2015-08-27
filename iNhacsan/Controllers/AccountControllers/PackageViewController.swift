//
//  PackageViewController.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/7/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class PackageViewController: BaseUserViewController {

    var data = [[String: AnyObject]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "PackageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "PackageCell")
        self.getPackage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPackage(){
        LibraryAPI.sharedInstance.packageList { (result) -> Void in
            self.data = result?.objectForKey("data") as! [[String: AnyObject]]
            self.tableView.reloadData()
        }
    }
}

extension PackageViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.data.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:PackageCell = self.tableView.dequeueReusableCellWithIdentifier("PackageCell") as! PackageCell
        let package = data[indexPath.row]
        cell.title = package["wifimss"] as! String
        return cell
        
    }
    
}

extension PackageViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let package = data[indexPath.row]
        var message = package["wifimss"] as! String
        if AppUser.sharedInstance.is3G {
        
        }
        else {
            
        }
    }
}
