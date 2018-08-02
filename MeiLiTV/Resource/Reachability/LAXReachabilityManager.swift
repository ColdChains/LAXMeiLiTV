//
//  ReachabilityManager.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/19.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

enum LAXReachabilityState {
    case unknow
    case viaWWAN
    case viaWIFI
    case viaNone
}

class LAXReachabilityManager: NSObject {
    
    static let shared = LAXReachabilityManager.init()
    // 仅WIFI联网
    var onlyWIFI: Bool = true {
        didSet {
            UserDefaults.standard.set(onlyWIFI, forKey: "OnlyWIFI")
        }
    }
    // 网络状态
    var state: LAXReachabilityState = .unknow
    
    let reach = Reachability.forInternetConnection()
    var connectWiFiBlock: ((_ message: String) -> Void)?
    var connectWWANBlock: ((_ message: String) -> Void)?
    var connectFailedBlock: ((_ message: String) -> Void)?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self , selector: #selector(self.networkStatusChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        if let bool = UserDefaults.standard.object(forKey: "onlyWIFI") as? Bool {
            self.onlyWIFI = bool
        } else {
            UserDefaults.standard.set(true, forKey: "OnlyWIFI")
            self.onlyWIFI = true
        }
    }
    
    func start() {
        reach?.startNotifier()
    }
    
    // 设置网络状态改变回调方法
    func monitorNetwork(connectWiFiBlock: ((_ message: String) -> Void)?, connectWWANBlock: ((_ message: String) -> Void)?, connectFailedBlock: ((_ message: String) -> Void)?) {
        
        self.connectWiFiBlock = connectWiFiBlock
        self.connectWWANBlock = connectWWANBlock
        self.connectFailedBlock = connectFailedBlock
        
    }
    
    func networkStatusChanged() {
        var str = ""
        if reach!.isReachable() {
            str = "网络已连接"
            if reach!.isReachableViaWWAN() {
                state = .viaWWAN
                str = "当前连接3G/4G网络"
                connectWWANBlock?(str)
            } else if reach!.isReachableViaWiFi() {
                state = .viaWIFI
                str = "已连接WiFi网络"
                connectWiFiBlock?(str)
            }
        } else {
            state = .viaNone
            str = "网络已断开"
            connectFailedBlock?(str)
        }
        print(str)
    }
    
}
