//
//  LAXNavigationController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXNavigationController: UIViewController, LAXNavigationBarDelegate {
    // laxNavigationBar
    lazy var laxNavigationBar: LAXNavigationBar? = {
        let bar = LAXNavigationBar.init(delegate: self)
        bar.backgroundColor = UIColor.red
        self.view.addSubview(bar)
        return bar
    }()
    // 标题
    var laxTitle: String? {
        didSet {
            laxNavigationBar?.titleItem.setTitle(laxTitle, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        showNavigationBar()
        //添加观察者
        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        self.view.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                
                laxNavigationBar?.width = rect.size.width
                if rect.width > rect.height {
                    laxNavigationBar?.isHaveTop = false
                } else {
                    laxNavigationBar?.isHaveTop = true
                }
                
            }
        }
    }
    
    // custom function
    func showNavigationBar() {
        self.laxNavigationBar?.isHidden = false
    }
    
    func hideNavigationBar() {
        self.laxNavigationBar?.isHidden = true
    }
    
    //navigationbar delegate
    func leftAction() {
        print("left")
        if self.navigationController != nil {
            _ = self.navigationController?.popViewController(animated: true)
        } else if self.laxTabBarPlusController != nil || self.laxTabBarController != nil {
            _ = self.laxTabBarController?.navigationController?.popViewController(animated: true)
            _ = self.laxTabBarPlusController?.navigationController?.popViewController(animated: true)
        } else {
            _ = self.dismiss(animated: true, completion: nil)
        }
    }
    
    func rightAction() {
        print("right")
    }
    
    func titleAction() {
        print("title")
    }

}
