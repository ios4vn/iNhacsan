//
//  PackageCell.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/18/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class PackageCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    var _title: String!
    var title: String!{
        get {
            return _title
        }
        set {
            _title = newValue
            lblTitle.text = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
