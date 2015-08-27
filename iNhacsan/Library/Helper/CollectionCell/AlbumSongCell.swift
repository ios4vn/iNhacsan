//
//  AlbumSong.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/5/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

class AlbumSongCell: SongCell {

    private var _rank:String!
    var rank:String!{
        get{
            return _rank
        }
        set{
            _rank = newValue
            lblRank.text = newValue
        }
    }
    
    @IBOutlet weak private var lblRank: UILabel!

}
