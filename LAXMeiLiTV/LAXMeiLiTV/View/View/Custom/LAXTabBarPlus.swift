//
//  LAXTabBar.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

protocol LAXTabBarPlusDelegate : LAXTabBarDelegate {
    func tabBarDidSelectPlusButton(sender: UIButton)
}

class LAXTabBarPlus: LAXTabBar {
    
    lazy var plusButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 55, height: 55))
        btn.addTarget(self, action: #selector(plusButtonAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    var plusButtonImage: String? {
        didSet {
            self.plusButton.setImage(UIImage.init(named: plusButtonImage!), for: .normal)
        }
    }

    override init() {
        super.init()
        self.plusButton.center = CGPoint.init(x: UIScreen.main.bounds.width / 2, y: 49 - plusButton.bounds.size.height / 2)
        self.addSubview(plusButton)
    }
    
    override func addItems() {
        let w = UIScreen.main.bounds.width / (CGFloat)(itemsName.count + 1)
        for i in 0..<itemsName.count {
            let btn = UIButton.init(frame: CGRect.init(x: (CGFloat)(i) * w, y: 0, width: w, height: 49))
            btn.tag = i
            btn.setTitle(itemsName[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .selected)
            btn.addTarget(self, action: #selector(didselectItemAction(sender:)), for: .touchUpInside)
            self.addSubview(btn)
            self.items.append(btn)
            
            if i == 0 {
                btn.isSelected = true
            }
            if i >= 2 {
                btn.frame = CGRect.init(x: (CGFloat)(i + 1) * w, y: 0, width: w, height: 49)
            }
            if itemsName[i] == "" {
                btn.isEnabled = false
            }
        }
        self.bringSubview(toFront: plusButton)
    }
    
    convenience init(delegate: LAXTabBarPlusDelegate) {
        self.init()
        self.tabBarPlusDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //tabbarplus delegate
    var tabBarPlusDelegate: LAXTabBarPlusDelegate?
    
    func plusButtonAction(sender: UIButton) {
        self.tabBarPlusDelegate?.tabBarDidSelectPlusButton(sender: sender)
    }

}
