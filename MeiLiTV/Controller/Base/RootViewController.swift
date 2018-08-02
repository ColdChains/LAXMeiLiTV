//
//  RootViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class RootViewController: LAXTabBarPlusController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.addViewController()
        
    }
    
    override func tabBarPlusDidSelectPlusButton(sender: UIButton) {
        // 初始化登录
        if !LiveDemoManager.isLogin {
            LiveDemoManager.initUser()
        }
        
        // 开始直播
//        let vc = TCPushSettingViewController()
//        let nav = TCNavigationController.init(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)

        let vc = PlayerViewController()
        self.present(vc, animated: true) {
            vc.locationAction(UIButton.init())
        }
    }
    
    func addViewController() {
        
        let vc1 = MainViewController()
        let vc2 = LiveViewController()
        let vc4 = AttentionViewController()
        let vc5 = MineViewController()
        self.viewControllers = [vc1, vc2, vc4, vc5]
        
        laxTabBarPlus?.itemsName = [TabBar_Title_1, TabBar_Title_2, TabBar_Title_4, TabBar_Title_5]
        laxTabBarPlus?.itemsImage = [TabBar_Image_1, TabBar_Image_2, TabBar_Image_4, TabBar_Image_5]
        laxTabBarPlus?.itemsSelectedImage = [TabBar_Image_Selected_1, TabBar_Image_Selected_2, TabBar_Image_Selected_4, TabBar_Image_Selected_5]
        
        laxTabBarPlus?.plusButtonImage = Image_PlusButtonImage
        laxTabBarPlus?.backgroundColor = RedColor
        
    }
    
}
