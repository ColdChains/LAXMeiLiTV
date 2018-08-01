//
//  NetworkActivityIndicator.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/17.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation

class NetworkActivityIndicator {
    
    class func show() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    class func hide() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
