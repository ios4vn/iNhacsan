//
//  StringExtension.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/11/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

let GlobalImageSource = "http://inhacsan.vn"

extension String {
    func getImageUrl() -> String {
        if self.rangeOfString("http") != nil{
            return self
        }
        return "\(GlobalImageSource)\(self)"
    }
}
