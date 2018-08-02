//
//  LAXAFManager.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import AFNetworking

class LAXAFManager {
    
    class var shared: AFHTTPSessionManager {
        get {
            let conf = URLSessionConfiguration.default
            // 是否允许数据请求网络
            if LAXReachabilityManager.shared.onlyWIFI {
                conf.allowsCellularAccess = false
            } else {
                conf.allowsCellularAccess = true
            }
            // 请求超时时间
            conf.timeoutIntervalForRequest = 5
            let manager = AFHTTPSessionManager.init(sessionConfiguration: conf)
            manager.requestSerializer.setValue("DYZB (iPhone; Scale/2.00)", forHTTPHeaderField: "User-Agent")
            manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","image/jpeg","image/png","application/octet-stream", "text/html"]
            return manager
        }
    }
    
    class var defaultParameters: Dictionary<String, String> {
        let date = NSDate.init()
        let time = String.init(format: "%f", date.timeIntervalSince1970)
        let dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        return dict
    }
    
}
