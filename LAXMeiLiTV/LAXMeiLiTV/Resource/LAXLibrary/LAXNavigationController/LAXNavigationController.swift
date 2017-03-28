//
//  BaseViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXNavigationController: UIViewController, LAXNavigationBarDelegate {

    lazy var laxNavigationBar: LAXNavigationBar? = {
        let bar = LAXNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64), delegate: self)
        bar.backgroundColor = RedColor
        self.view.addSubview(bar)
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideSystemBar()
        self.showNavigationBar()
        //添加观察者
        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                laxNavigationBar?.frame = CGRect.init(x: 0, y: -20, width: rect.size.width, height: 64)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // custom function
    func showNavigationBar() {
        self.laxNavigationBar?.isHidden = false
    }
    
    func hideNavigationBar() {
        self.laxNavigationBar?.isHidden = true
    }
    
    func showSystemBar() {
        self.laxTabBarController?.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func hideSystemBar() {
        self.laxTabBarController?.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //navigationbar delegate
    func leftAction() {
        print("left")
        if self.navigationController != nil {
            _ = self.navigationController?.popViewController(animated: true)
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
