//
//  LAXNavigationBar.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

protocol LAXNavigationBarDelegate {
    func leftAction()
    func rightAction()
    func titleAction()
}

class LAXNavigationBar: UIView {
    // LAXNavigationBar宽度
    var width = UIScreen.main.bounds.width {
        didSet {
            var y: CGFloat = 0
            if isHaveTop {
                y = 20
            }
            leftItem.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
            titleItem.frame = CGRect.init(x: 60, y: 0, width: width - 60 * 2, height: 44)
            rightItem.frame = CGRect.init(x: width - 60, y: 0, width: 100, height: 44)
            menuView.frame = CGRect.init(x: 0, y: y, width: width, height: 44)
            self.frame = CGRect.init(x: 0, y: 0, width: width, height: 44 + y)
        }
    }
    // 是否有顶部20px
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
    // item菜单
    var menuView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 44))
    // 左侧item
    var leftItem: UIButton = {
        var btn = UIButton()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
    // 标题item
    var titleItem: UIButton = {
        var btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    // 右侧item
    var rightItem: UIButton = {
        var btn = UIButton()
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
    // 构造方法
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 64))
        self.backgroundColor = UIColor.red
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        initView()
    }
    convenience init(delegate:LAXNavigationBarDelegate) {
        self.init()
        self.delegate = delegate
        self.backgroundColor = UIColor.red
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 初始化菜单栏
    func initView() {
        menuView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: width, height: 44))
        menuView.addSubview(self.leftItem)
        menuView.addSubview(self.rightItem)
        menuView.addSubview(self.titleItem)
        self.addSubview(menuView)
        self.leftItem.addTarget(self, action: #selector(self.leftAction), for: .touchUpInside)
        self.rightItem.addTarget(self, action: #selector(self.rightAction), for: .touchUpInside)
        self.titleItem.addTarget(self, action: #selector(self.titleAction), for: .touchUpInside)    
    }
    // LAXNavigationBarDelegate
    var delegate:LAXNavigationBarDelegate?
    // 左侧item事件
    func leftAction() {
        self.delegate?.leftAction()
    }
    // 右侧item事件
    func rightAction() {
        self.delegate?.rightAction()
    }
    // 标题item事件
    func titleAction() {
        self.delegate?.rightAction()
    }

}
