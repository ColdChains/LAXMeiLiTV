//
//  LiveViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveViewController: LAXMenuBarController {
    
    var nameArray = ["常用", "全部"]
    var liveMenuResultModel: LiveMenuResultModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LightGrayColor
        setSubViewController()
        requestLiveMenu()
    }
    
    
    func setSubViewController() {
        var vcs: Array<UIViewController> = []
        
        for i in 0..<nameArray.count {
            if i == 0 {
                let vc = LiveTypeCollectionViewController()
                vcs.append(vc)
            } else {
                // 0：常用 1：全部 去掉2
                let vc = LiveListCollectionViewController()
                if let data = liveMenuResultModel?.data {
                    if i == 1 {
                        let model = LiveMenuModel.init()
                        model.cate_id = -1
                        vc.liveMenuModel = model
                    }
                    if i - 2 >= 0 && i - 2 < data.count {
                        vc.liveMenuModel = data[i - 2]
                    }
                }
                vcs.append(vc)
            }
        }
        
        self.laxMenuBar?.itemsName = nameArray
        self.viewControllers = vcs
        self.selectedIndex = 1
    }
    
    func requestLiveMenu() {
        LiveViewModel.getLiveMenuData(successBlock: { (model) in
            self.liveMenuResultModel = model
            self.nameArray = ["常用", "全部"]
            
            if let arr = model.data {
                for room in arr {
                    if let name = room.cate_name {
                        self.nameArray.append(name)
                    }
                }
                self.setSubViewController()
            }
            
        }) { (error) in
//            self.showAlertLabelView(message: error)
//            _ = LAXTimerManager.init(norepeats: 5, doSomething: {
//                self.requestLiveMenu()
//            })
            let delayTime = DispatchTime.now() + Double(5)
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
                self.requestLiveMenu()
            })
        }
    }

}
