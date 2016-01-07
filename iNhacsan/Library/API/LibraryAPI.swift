//
//  LibraryAPI.swift
//  iNhacsan
//
//  Created by Hai Trieu on 7/30/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit
import Alamofire

class LibraryAPI: NSObject {
    

    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    func getMediaDetail(mediaId: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"getMediaDetail","id":mediaId]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func userLogin(mobile: String, password: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"userLogin","mobile":mobile,"password":password]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }

        }
    }

    func userRegister(mobile: String, password: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"userRegister","mobile":mobile,"password":password]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }

        }
    }
    
    func userActive(mobile: String, active_code: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"userActive","mobile":mobile,"active_code":active_code]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }

        }
    }
    
    func userReSendActiveKey(mobile: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"userReSendActiveKey","mobile":mobile]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }

        }
    }
    
    func sendConfirmKey(mobile: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"sendConfirmKey","mobile":mobile]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }

        }
    }
    
    func userLogout(ssid: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"userLogout","ssid":ssid]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func userChangePassword(mobile: String, password: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"userChangePassword","mobile":mobile,"password":password]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func receiveNewPassword(mobile: String, password: String,resetPassKey: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"receiveNewPassword","mobile":mobile,"password":password,"reset_pass_key":resetPassKey]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }

    func like(atid: String, type: MediaType, completion: (result: AnyObject?) -> Void) {
        var typeStr = ""
        switch type {
        case MediaType.Song:
                typeStr = "audio"
            break
        case MediaType.Album:
            typeStr = "album"
            break
        case MediaType.Video:
            typeStr = "video"
            break
        }
        let parameters = ["act":"like","atid":atid,"type": typeStr,"method":"like", "ssid":AppUser.sharedInstance.ssid]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func unlike(atid: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"unlike","like_id":atid, "ssid":AppUser.sharedInstance.ssid]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func comment(atid: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"comment","atid":atid, "ssid":AppUser.sharedInstance.ssid]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func donwload(to: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"download","to":to, "ssid":AppUser.sharedInstance.ssid]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    /*Package*/
    func getPhoneNumber(completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"getPhoneNumber"]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func packageList(completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"packageList"]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func packageRegister(startCode: String, completion: (result: AnyObject?) -> Void) {
        let parameters = ["act":"packageRegister","startCode":startCode,"ssid":AppUser.sharedInstance.ssid]
        Alamofire.request(.GET, GlobalDomain, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    completion(result: JSON)
                }
        }
    }
    
    func download(url: String, filename: String, completion: (result: AnyObject?) -> Void) {
        Alamofire.download(.GET,url, destination:{ (temporaryURL, response) in
            
            let path = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let newPath = path.URLByAppendingPathComponent(filename)
            return newPath
        }).response { (request, response, _, error) -> Void in
            print(response)
            completion(result:response)
            }
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) -> Void in
                print(totalBytesRead)
        }
    }
    
}
