//
//  LAXTabBarPlusController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXTabBarPlusController: LAXTabBarController, LAXTabBarPlusDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar = LAXTabBarPlus.init()
        self.tabBar?.tabBarDelegate = self
        (self.tabBar as! LAXTabBarPlus).tabBarPlusDelegate = self
        self.view.addSubview(self.tabBar!)
    }
    
    func tabBarDidSelectPlusButton(sender: UIButton) {
        let vc = PlayerViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
}
