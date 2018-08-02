//
//  LAXAnimationTabBarController.swift
//  LAXAnimationTabBarController
//
//  Created by 冰凉的枷锁 on 2017/3/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation
import UIKit

class LAXAnimationTabBarController : UITabBarController, UITabBarControllerDelegate, LAXAnimationTabBarDelegate {
    
    var plusButtonImage: UIImage? {
        didSet {
            (self.tabBar as! LAXAnimationTabBar).plusButton.setImage(plusButtonImage, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let tabBar = LAXAnimationTabBar.init(delegate: self)
        self.setValue(tabBar, forKey: "tabBar")
        
        self.tabBar.barTintColor = UIColor.red
        self.tabBar.tintColor = UIColor.orange
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        
        //添加观察者
        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        self.view.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //屏幕旋转 重新设置frame
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                self.tabBar.frame = CGRect.init(x: 0, y: rect.size.height - 49, width: rect.size.width, height: 49)
            }
        }
    }
    
    func getTitleArray() -> Array<String> {
        var arr = Array<String>()
        if let vcs = viewControllers {
            for vc in vcs {
                if let title = vc.tabBarItem.title {
                    arr.append(title)
                } else {
                    arr.append("")
                }
            }
        }
        return arr
    }
    
    //delegate
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LAXAnimationedTransition.init(titleArray: getTitleArray())
    }
    
    func animationTabBarDidClickPlusButton(_: LAXAnimationTabBar) {
        
    }

}
