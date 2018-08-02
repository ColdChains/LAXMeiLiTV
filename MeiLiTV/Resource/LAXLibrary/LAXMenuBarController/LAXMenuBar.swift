//
//  MenuBar.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/26.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import Foundation
import UIKit
/*
 * LAXMenuBar代理 点击标签时调用
 */
protocol LAXMenuBarDelegate {
    func menuBarDidSelectItem(index: Int)
}
/*
 * 自定制LAXMenuBar
 */
class LAXMenuBar: UIView {
    // 标签的间距
    private let space: CGFloat = 10
    // 滑条滚动的时间
    private let duration: TimeInterval = 0.3
    // LAXMenuBar的宽度
    var width = UIScreen.main.bounds.width {
        didSet {
            var y: CGFloat = 0
            if isHaveTop {
                y = 20
            }
            menuView.frame = CGRect.init(x: 0, y: y, width: width, height: 44)
            self.frame = CGRect.init(x: 0, y: 0, width: width, height: 44 + y)
        }
    }
    // 是否有顶部 横屏可隐藏
    var isHaveTop = true {
        didSet {
            var y: CGFloat = 0
            if isHaveTop {
                y = 20
            }
            menuView.frame = CGRect.init(x: 0, y: y, width: width, height: 44)
            self.frame = CGRect.init(x: 0, y: 0, width: width, height: 44 + y)
        }
    }
    // 标签的父视图
    var menuView = UIScrollView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 44))
    // 滑条
    var lineView = LAXSplitLineView.init(color: UIColor.black)
    // 存放标签的数组
    var items: Array<UIButton> = []
    // 存放标签的名字
    var itemsName: Array<String> = [] {
        willSet {
            removeItems()
        }
        didSet {
            addItems()
        }
    }
    // 标签的字体大小
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14) {
        willSet {
            removeItems()
        }
        didSet {
            addItems()
        }
    }
    // 选中标签的字体大小
    var selectedTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 14) {
        willSet {
            removeItems()
        }
        didSet {
            addItems()
        }
    }
    // 标签的字体颜色
    var titleColor: UIColor = UIColor.white {
        didSet {
            for item in items {
                item.setTitleColor(titleColor, for: .normal)
            }
        }
    }
    // 标签选中的字体颜色
    var selectedTitleColor: UIColor = UIColor.black {
        didSet {
            for item in items {
                item.setTitleColor(titleColor, for: .selected)
                lineView.lineColor = selectedTitleColor
            }
        }
    }
    // 当前选中的标签下标
    var selectedIndex: Int = 0 {
        willSet {
            if  selectedIndex < items.count {
                items[selectedIndex].isSelected = false
                items[selectedIndex].titleLabel?.font = titleFont
            }
        }
        didSet {
            if selectedIndex < items.count {
                UIView.animate(withDuration: duration, animations: {
                    let x = self.items[self.selectedIndex].frame.origin.x + self.space
                    let w = self.items[self.selectedIndex].frame.size.width - self.space * 2
                    self.lineView.frame = CGRect.init(x: x, y: 42, width: w, height: 2)
                    self.items[self.selectedIndex].isSelected = true
                    self.items[self.selectedIndex].titleLabel?.font = self.selectedTitleFont
                })
                reviseScrollView()
            }
        }
    }
    // menubar Delegate
    var menuBarDelegate: LAXMenuBarDelegate?
    // 构造方法
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 64))
        self.backgroundColor = UIColor.red
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    convenience init(delegate: LAXMenuBarDelegate) {
        self.init()
        self.menuBarDelegate = delegate
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 移除所有标签
    private func removeItems() {
        menuView.removeFromSuperview()
        items = []
    }
    // 添加标签
    private func addItems() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        if isHaveTop {
            y = 20
        }
        menuView = UIScrollView.init(frame: CGRect.init(x: 0, y: y, width: width, height: 44))
        menuView.showsHorizontalScrollIndicator = false
        menuView.showsVerticalScrollIndicator = false
        var maxWidth: CGFloat = 0
        for i in 0..<itemsName.count {
            let btn = UIButton.init()
            btn.titleLabel?.font = titleFont
            let w = itemsName[i].widthWithConstrainedWidth(width: 200, font: btn.titleLabel!.font) + 2 * space
            btn.frame = CGRect.init(x: x, y: 0, width: w, height: 44)
            x = x + w
            maxWidth += w
            
            btn.tag = i
            btn.setTitle(itemsName[i], for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
            btn.setTitleColor(selectedTitleColor, for: .selected)
            btn.setTitleColor(UIColor.gray, for: .highlighted)
//            btn.setBackgroundImage(UIImage.init(named: "grayimage"), for: .highlighted)
            btn.addTarget(self, action: #selector(didselectItemAction(sender:)), for: .touchUpInside)
            menuView.addSubview(btn)
            self.items.append(btn)
        }
        menuView.contentSize = CGSize.init(width: maxWidth, height: 44)
        lineView.frame = CGRect.init(x: 0, y: 42, width: 0, height: 2)
        menuView.addSubview(lineView)
        self.addSubview(menuView)
        
        let i = selectedIndex
        selectedIndex = i
    }
    // 滑条滑动时 scroll view 偏移
    private func reviseScrollView() {
        // 向右滑动 显示右边的标签
        if (lineView.x + lineView.width) > width {
            menuView.setContentOffset(CGPoint.init(x: lineView.x + lineView.width - width + space * 3, y: 0), animated: true)
            if lineView.x + lineView.width + space * 3 > menuView.contentSize.width {
                menuView.setContentOffset(CGPoint.init(x: menuView.contentSize.width - width, y: 0), animated: true)
            }
        }
        // 向左滑动 显示左边的标签
        if lineView.x < menuView.contentOffset.x {
            menuView.setContentOffset(CGPoint.init(x: lineView.x - space * 3, y: 0), animated: true)
            if lineView.x - space * 3 < 0 {
                menuView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
        }
    }
    // 滑动距离的相对比例
    private var oldRate: CGFloat = 0
    //通过scrollview的偏移量设置lineview的frame
    func setLineViewFrame(index: Int, wRate: CGFloat) {
        
        var newX: CGFloat = 0
        var newW:CGFloat = 0
        
        if index >= items.count - 1 {
            return
        }
        // view左滑
        if wRate > oldRate {
            newW = items[index + 1].frame.size.width - (items[index + 1].frame.size.width - items[index].frame.size.width) * (1 - wRate)
        } else {
            newW = items[index].frame.size.width - (items[index].frame.size.width - items[index + 1].frame.size.width) * wRate
        }
        
        newX = items[index].frame.origin.x + (items[index + 1].frame.origin.x - items[index].frame.origin.x) * ( wRate)
        UIView.animate(withDuration: duration) {
            self.lineView.x = newX + self.space
            self.lineView.width = newW - 2 * self.space
        }
        oldRate = wRate
        
    }
    // 点击标签事件
    func didselectItemAction(sender: UIButton) {
        print("\ntabbar didselect index:", sender.tag)
        selectedIndex = sender.tag
        self.menuBarDelegate?.menuBarDidSelectItem(index: sender.tag)
    }
    
}
