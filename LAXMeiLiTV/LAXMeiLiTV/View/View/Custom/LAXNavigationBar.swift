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
    
    var delegate:LAXNavigationBarDelegate?
    
    var leftItem: UIButton = {
        var btn = UIButton()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.frame = CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.size.width / 5, height: 44)
        return btn
    }()
    
    var rightItem: UIButton = {
        var btn = UIButton()
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.frame = CGRect.init(x: UIScreen.main.bounds.size.width / 5 * 4, y: 20, width: UIScreen.main.bounds.size.width / 5, height: 44)
        return btn
    }()
    
    var titleItem: UIButton = {
        var btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.frame = CGRect.init(x: UIScreen.main.bounds.size.width / 5, y: 20, width: UIScreen.main.bounds.size.width / 5 * 3, height: 44)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.leftItem)
        self.addSubview(self.rightItem)
        self.addSubview(self.titleItem)
        self.leftItem.addTarget(self, action: #selector(self.leftAction), for: .touchUpInside)
        self.rightItem.addTarget(self, action: #selector(self.rightAction), for: .touchUpInside)
        self.titleItem.addTarget(self, action: #selector(self.titleAction), for: .touchUpInside)

    }
    
    init(frame: CGRect, delegate:LAXNavigationBarDelegate) {
        super.init(frame: frame)
        
        self.delegate = delegate
        self.addSubview(self.leftItem)
        self.addSubview(self.rightItem)
        self.addSubview(self.titleItem)
        self.leftItem.addTarget(self, action: #selector(self.leftAction), for: .touchUpInside)
        self.rightItem.addTarget(self, action: #selector(self.rightAction), for: .touchUpInside)
        self.titleItem.addTarget(self, action: #selector(self.titleAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func hiddenMenuView {
//        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20)
//    }
//    
//    func hiddenNavigationView {
//        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20)
//    }
    
    func leftAction() {
        self.delegate?.leftAction()
    }
    
    func rightAction() {
        self.delegate?.rightAction()
    }
    
    func titleAction() {
        self.delegate?.rightAction()
    }

}
