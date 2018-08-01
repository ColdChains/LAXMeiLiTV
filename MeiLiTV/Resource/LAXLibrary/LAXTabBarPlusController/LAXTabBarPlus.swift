//
//  LAXTabBar.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit
/*
 * LAXTabBarPlus代理 点击标签时调用
 */
protocol LAXTabBarPlusDelegate {
    func tabBarPlusDidSelectItem(index: Int)
    func tabBarPlusDidSelectPlusButton(sender: UIButton)
}
/*
 * 自定制LAXTabBarPlus
 */
class LAXTabBarPlus: UIView {
    // change 大按钮
    lazy var plusButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 55, height: 55))
        btn.backgroundColor = UIColor.orange
        btn.layer.cornerRadius = btn.bounds.width / 2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(plusButtonAction(sender:)), for: .touchUpInside)
        return btn
    }()
    // 大按钮图片
    var plusButtonImage: String? {
        didSet {
            self.plusButton.setImage(UIImage.init(named: plusButtonImage!), for: .normal)
        }
    }
    //end
    var size = UIScreen.main.bounds.size {
        didSet {
            self.frame = CGRect.init(x: 0, y: size.height - 49, width: size.width, height: 49)
            setItemsFrame()
        }
    }
    // 标签按钮数组
    var items: Array<UIButton> = []
    // 标签名称数组
    var itemsName: Array<String> = [] {
        willSet {
            removeItems()
        }
        didSet {
            addItems()
        }
    }
    // 标签图片数组
    var itemsImage: Array<String> = [] {
        didSet {
            setItemsImage()
        }
    }
    // 标签选中的图片数组
    var itemsSelectedImage:Array<String> = [] {
        didSet {
            setItemsSelectedImage()
        }
    }
    // 当前选中的标签下标
    var selectedIndex: Int = 0 {
        willSet {
            if items.count > selectedIndex {
                items[selectedIndex].isSelected = false
            }
        }
        didSet {
            if items.count > selectedIndex {
                items[selectedIndex].isSelected = true
            }
        }
    }
    // tabbarplus delegate
    var tabBarPlusDelegate: LAXTabBarPlusDelegate?
    // 构造方法
    init() {
        super.init(frame: CGRect.init(x: 0, y: size.height, width: size.width, height: 49))
        self.backgroundColor = UIColor.red
        //change
        revisePlusButton()
        self.addSubview(plusButton)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        size = frame.size
    }
    convenience init(delegate: LAXTabBarPlusDelegate) {
        self.init()
        self.tabBarPlusDelegate = delegate
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 移除标签
    func removeItems() {
        for item in items {
            item.removeFromSuperview()
        }
        items = []
    }
    // change 添加标签
    func addItems() {
        for i in 0..<itemsName.count {
            let btn = UIButton.init()
            btn.tag = i
            
            btn.setTitle(itemsName[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(UIColor.black, for: .selected)
            btn.setTitleColor(UIColor.gray, for: .highlighted)
            btn.addTarget(self, action: #selector(didselectItemAction(sender:)), for: .touchUpInside)
            self.addSubview(btn)
            self.items.append(btn)
            
            if itemsName[i] == "" {
                btn.isEnabled = false
            }
        }
        setItemsFrame()
        setItemsImage()
        setItemsSelectedImage()
        self.bringSubview(toFront: plusButton)
    }
    // 设置标签的frame
    func setItemsFrame() {
        let w = size.width / (CGFloat)(itemsName.count + 1)
        for i in 0..<items.count {
            let btn = items[i]
            
            if i == selectedIndex {
                btn.isSelected = true
            }
            
            if i < items.count / 2 {
                btn.frame = CGRect.init(x: (CGFloat)(i) * w, y: 0, width: w, height: 49)
            } else {
                btn.frame = CGRect.init(x: (CGFloat)(i + 1) * w, y: 0, width: w, height: 49)
            }
        }
    }
    // 设置标签的图片
    func setItemsImage() {
        for i in 0..<itemsImage.count {
            if i < items.count {
                items[i].setImage(UIImage.init(named: itemsImage[i]), for: .normal)
            }
        }
    }
    // 设置标签选中的图片
    func setItemsSelectedImage() {
        for i in 0..<itemsSelectedImage.count {
            if i < items.count {
                items[i].setImage(UIImage.init(named: itemsSelectedImage[i]), for: .selected)
            }
        }
    }
    // change 设置大按钮frame
    func revisePlusButton() {
        self.plusButton.center = CGPoint.init(x: size.width / 2, y: 49 - plusButton.bounds.size.height / 2)
    }
    // 点击标签事件
    func didselectItemAction(sender: UIButton) {
        print("\ntabbar didselect index:", sender.tag)
        self.selectedIndex = sender.tag
        self.tabBarPlusDelegate?.tabBarPlusDidSelectItem(index: sender.tag)
    }
    // 点击大按钮事件
    func plusButtonAction(sender: UIButton) {
        self.tabBarPlusDelegate?.tabBarPlusDidSelectPlusButton(sender: sender)
    }
   
}
