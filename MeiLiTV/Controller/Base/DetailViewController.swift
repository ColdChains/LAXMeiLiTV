//
//  DetailViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/11.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = true;
        self.view.backgroundColor = RedColor
        
        setBackItem()
    }

    //设置统一的后退按钮样式
    func setBackItem() {
        let backItem = UIBarButtonItem.init(image: UIImage.init(named: "btn_back"), style: .done, target: self, action: #selector(self.returnAction))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func returnAction() {
        
    }

}
