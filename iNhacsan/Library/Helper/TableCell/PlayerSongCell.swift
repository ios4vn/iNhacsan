//
//  PlayerSongCell.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/28/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class PlayerSongCell: UITableViewCell {
    
    private var _titleName:String!
    var titleName:String!{
        get{
            return _titleName
        }
        set{
            _titleName = newValue
            lblSongName.text = newValue
        }
    }
    
    private var _singerName:String!
    var singerName:String!{
        get{
            return _singerName
        }
        set{
            _singerName = newValue
            lblSingerName.text = newValue
        }
    }
    
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSingerName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
