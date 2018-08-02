//
//  LAXTabBar.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

protocol LAXAnimationTabBarDelegate : UITabBarDelegate {
    func animationTabBarDidClickPlusButton(_: LAXAnimationTabBar)
}

class LAXAnimationTabBar: UITabBar {
    
    lazy var plusButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 55, height: 55))
        btn.addTarget(self, action: #selector(plusButtonAction(sender:)), for: .touchUpInside)
        btn.layer.cornerRadius = btn.bounds.width / 2
        btn.layer.masksToBounds = true
        return btn
    }()
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.size.height - 49, width: UIScreen.main.bounds.size.width, height: 49))
        plusButton.center = CGPoint.init(x: UIScreen.main.bounds.size.width / 2, y: 49 - plusButton.bounds.size.height / 2)
        self.backgroundColor = UIColor.red
        self.addSubview(plusButton)
        //添加观察者
        self.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //屏幕旋转 重新设置frame
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                self.plusButton.center = CGPoint.init(x: rect.size.width / 2, y: 49 - plusButton.bounds.size.height / 2)
            }
        }
    }
    
    convenience init(delegate: LAXAnimationTabBarDelegate) {
        self.init()
        self.animationTabbarDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animationTabbarDelegate: LAXAnimationTabBarDelegate?
    
    func plusButtonAction(sender: UIButton) {
        self.animationTabbarDelegate?.animationTabBarDidClickPlusButton(self)
    }

}
