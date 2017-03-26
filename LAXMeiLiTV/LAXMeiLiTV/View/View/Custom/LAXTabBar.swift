//
//  LAXTabBar.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

protocol LAXTabBarDelegate {
    func tabBarDidSelectItem(index: Int)
}

class LAXTabBar: UIView {
    
    var items: Array<UIButton> = []
    
    var itemsName: Array<String> = [] {
        willSet {
            removeItems()
        }
        didSet {
            addItems()
        }
    }
    
    var itemsImage: Array<String> = [] {
        didSet {
            setImage()
        }
    }
    
    var itemsSelectedImage:Array<String> = [] {
        didSet {
            if selectedIndex < itemsImage.count && selectedIndex < items.count {
                items[selectedIndex].setImage(UIImage.init(named: itemsSelectedImage[selectedIndex]), for: .normal)
            }
        }
    }
    
    var selectedIndex: Int = 0 {
        willSet {
            if items.count > selectedIndex {
                items[selectedIndex].isSelected = false
                if selectedIndex < itemsImage.count && selectedIndex < items.count {
                    items[selectedIndex].setImage(UIImage.init(named: itemsImage[selectedIndex]), for: .normal)
                }
            }
        }
        didSet {
            if items.count > selectedIndex {
                items[selectedIndex].isSelected = true
                if selectedIndex < itemsImage.count && selectedIndex < items.count {
                    items[selectedIndex].setImage(UIImage.init(named: itemsSelectedImage[selectedIndex]), for: .normal)
                }
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height - 49, width: UIScreen.main.bounds.width, height: 49))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(delegate: LAXTabBarDelegate) {
        self.init()
        self.tabBarDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeItems() {
        for item in items {
            item.removeFromSuperview()
        }
        items = []
    }
    
    func addItems() {
        let w = UIScreen.main.bounds.width / (CGFloat)(itemsName.count)
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
            if itemsName[i] == "" {
                btn.isEnabled = false
            }
        }
    }
    
    private func setImage() {
        for i in 0..<itemsName.count {
            if i < itemsImage.count && i < items.count {
                items[i].setImage(UIImage.init(named: itemsImage[i]), for: .normal)
            }
        }   
    }
    
    //tabBar Delegate
    var tabBarDelegate: LAXTabBarDelegate?
    
    func didselectItemAction(sender: UIButton) {
        self.selectedIndex = sender.tag
        self.tabBarDelegate?.tabBarDidSelectItem(index: sender.tag)
    }
    
}
