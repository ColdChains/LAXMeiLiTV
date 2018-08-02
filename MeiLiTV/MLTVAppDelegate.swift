//
//  MLTVAppDelegate.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/8.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

@UIApplicationMain
class MLTVAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = BackgroundColor
        enterMainViewController()
        window?.makeKeyAndVisible()
        
        // 启动监听网络
        LAXReachabilityManager.shared.start()
        initLive()
        addNotificationCenter()
        initUMeng()
        
        return true
    }
    
    func enterLoginViewController() {
        window?.rootViewController = LoginViewController()
    }
    
    func enterMainViewController() {
        window?.rootViewController = UINavigationController.init(rootViewController: RootViewController())
    }
    // 腾讯移动直播SDK
    func initLive() {
//        print(TXLivePush.getSDKVersion())
    }
    // 添加屏幕旋转监听
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.statusBarOrientationChange), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        // 添加状态栏背景
        self.window?.addSubview(StatusBackgroundView.shared)
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            StatusBackgroundView.shared.removeFromSuperview()
        }
    }
    // 友盟统计
    func initUMeng() {
        UMAnalyticsConfig.sharedInstance().appKey = "5912cff96e27a46dc1000484"
        UMAnalyticsConfig.sharedInstance().channelId = "App Store" // App Store是默认值 可不设置
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance()) // 配置以上参数后调用此方法初始化SDK！
    }
    func statusBarOrientationChange(notification: Notification) {
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            StatusBackgroundView.shared.hide()
        } else {
            StatusBackgroundView.shared.show()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

