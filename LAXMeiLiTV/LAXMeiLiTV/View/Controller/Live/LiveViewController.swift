//
//  LiveViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveViewController: LAXMenuBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        vc.view.backgroundColor = UIColor.lightText
        vc2.view.backgroundColor = UIColor.green
        vc3.view.backgroundColor = UIColor.magenta
        
        self.viewControllers = [vc, vc2, vc3]
        self.menuBar?.itemsName = ["精选", "哈哈哈哈哈哈", "游戏"]

    }

}
