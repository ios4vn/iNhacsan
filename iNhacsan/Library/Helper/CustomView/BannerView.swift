//
//  BannerView.swift
//  iNhacsan
//
//  Created by Hai Trieu on 8/14/15.
//  Copyright (c) 2015 DITECH TECHNOLOGY AND MEDIA JSC. All rights reserved.
//

import UIKit

enum UserStatus {
    case NoLogin
    case NoService
    case WithService
}

class BannerView: UIView {

    private var _bannerText: String?
    var bannerText: String? {
        get {
            switch (self.getUserStatus()){
            case .NoLogin:
                _bannerText = "Không nhận diện được thuê bao, vui lòng ĐĂNG NHẬP bằng 3G của Viettel"
                break
            case .NoService:
                _bannerText = "Xin chào \(AppUser.sharedInstance.username). Quý khách được nghe/xem Miễn phí 5 nội dung/ngày. Để nghe, tải MIỄN PHÍ không giới hạn hàng trăm bài Nhạc Sàn, Nhạc DJ HOT nhất, Quý khách vui lòng ĐĂNG KÝ tại đây"
                break
            case .WithService:
                _bannerText = "Xin chào \(AppUser.sharedInstance.username). Quý khách đang sử dụng gói Ngày dịch vụ iNhacsan (2.000 đồng/ngày; gia hạn hằng ngày)"
                break
            }
            return _bannerText
        }
        set {
            _bannerText = newValue
        }
    }
    
    @IBOutlet weak var lblMessage: UILabel!
    
    func getUserStatus() -> UserStatus {
        if !AppUser.sharedInstance.isLogin {
            return UserStatus.NoLogin
        }
        else if AppUser.sharedInstance.isService {
            return UserStatus.WithService
        }
        else {
            return UserStatus.NoService
        }
    }
    
    @IBAction func btnShowLoginPress(sender: AnyObject?){
        switch (self.getUserStatus()){
        case .NoLogin:
            Util.sharedInstance.showLogin()
            break
        case .NoService:
            Util.sharedInstance.showPackage()
            break
        case .WithService:
            Util.sharedInstance.showAccount()
            break
        }
    }
    
    @IBAction func btnHideBannerPress(sender: AnyObject?){
        
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "BannerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
}
