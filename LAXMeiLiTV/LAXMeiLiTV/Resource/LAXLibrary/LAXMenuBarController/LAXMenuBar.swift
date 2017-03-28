//
//  MenuBar.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/26.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import Foundation

protocol LAXMenuBarDelegate {
    func menuBarDidSelectItem(index: Int)
}

class LAXMenuBar: UIScrollView {
    
    var width = UIScreen.main.bounds.width {
        didSet {
            self.frame = CGRect.init(x: 0, y: 0, width: width, height: 64)
            menuView.frame = CGRect.init(x: 0, y: 20, width: width, height: 44)
        }
    }
    
    var menuView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 44))
    var lineView = LAXSplitLineView.init(color: UIColor.black)
    
    var items: Array<UIButton> = []
    
    var itemsName: Array<String> = [] {
        willSet {
            removeItems()
        }
        didSet {
            addItems()
        }
    }
    
    var titleColor: UIColor = UIColor.white {
        didSet {
            for item in items {
                item.setTitleColor(titleColor, for: .normal)
            }
        }
    }
    
    var titleSelectedColor: UIColor = UIColor.black {
        didSet {
            for item in items {
                item.setTitleColor(titleColor, for: .selected)
                lineView.lineColor = titleSelectedColor
            }
        }
    }
    
    var selectedIndex: Int = 0 {
        willSet {
            if items.count > selectedIndex {
                items[selectedIndex].isSelected = false
            }
        }
        didSet {
            if items.count > selectedIndex {
                items[selectedIndex].isSelected = true
                var rect = lineView.frame
                rect.origin.x = items[selectedIndex].frame.origin.x
                rect.size.width = items[selectedIndex].frame.size.width
                lineView.frame = rect
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 64))
        self.backgroundColor = UIColor.red
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(delegate: LAXMenuBarDelegate) {
        self.init()
        self.menuBarDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeItems() {
        menuView.removeFromSuperview()
        items = []
    }
    
    func addItems() {
        var x: CGFloat = 10
        menuView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: width, height: 44))
        for i in 0..<itemsName.count {
            let btn = UIButton.init()
            let w = itemsName[i].widthWithConstrainedWidth(width: 200, font: btn.titleLabel!.font)
            btn.frame = CGRect.init(x: x, y: 0, width: w, height: 49)
            x = x + w + 20
            
            btn.tag = i
            btn.setTitle(itemsName[i], for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
            btn.setTitleColor(titleSelectedColor, for: .selected)
            btn.addTarget(self, action: #selector(didselectItemAction(sender:)), for: .touchUpInside)
            menuView.addSubview(btn)
            self.items.append(btn)
            
            if i == 0 {
                btn.isSelected = true
                lineView.frame = CGRect.init(x: 10, y: 42, width: w, height: 2)
            }
        }
        menuView.addSubview(lineView)
        self.addSubview(menuView)
    }
    
    //menubar Delegate
    var menuBarDelegate: LAXMenuBarDelegate?
    
    func didselectItemAction(sender: UIButton) {
        print("\ntabbar didselect index:", sender.tag)
        selectedIndex = sender.tag
        lineView.x = self.items[sender.tag].frame.origin.x
        lineView.width = self.items[sender.tag].frame.size.width
        self.menuBarDelegate?.menuBarDidSelectItem(index: sender.tag)
    }
    
}
