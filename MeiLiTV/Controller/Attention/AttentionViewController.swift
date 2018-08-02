//
//  AttentionViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class AttentionViewController: UIViewController {

    let loginView = Bundle.main.loadNibNamed("LoginView", owner: nil, options: nil)?.first as! LoginView
    let contentView = UIView.init()
    // 小直播的控制器
//    let livevc = TCMainTabViewController()
//    let livevc = TCLiveListViewController()
    var flag = true
    
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginView.alpha = 0
        
        addLiveView()
        
        //添加观察者
        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        self.view.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            self.reviseLiveView()
            if let rect = change?[.newKey] as? CGRect {
                topViewHeightConstraint.constant = rect.size.width > rect.size.height ? 0 : 20
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flag {
            showLoginView()
            flag = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideLoginView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideLoginView()
    }
    
    func showLoginView() {
        contentView.frame = self.view.bounds
        contentView.backgroundColor = UIColor.black
        contentView.alpha = 0.2
        
        self.view.addSubview(contentView)
        self.view.addSubview(loginView)
        self.loginView.center = self.view.center
        
        UIView.animate(withDuration: 0.5) {
            self.loginView.alpha = 1
        }
    }
    
    func hideLoginView() {
        var frame = loginView.frame
        frame.size.width = 0
        frame.size.height = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.loginView.alpha = 0
        }) { (b) in
            self.loginView.removeFromSuperview()
            self.contentView.removeFromSuperview()
            self.contentView.alpha = 0
        }
    }
    
    
    func addLiveView() {
        // 初始化登录
        if !LiveDemoManager.isLogin {
            LiveDemoManager.initUser()
        }
        
//        livevc.view.backgroundColor = LightGrayColor
//        livevc.view.tag = 10
//        livevc.view.frame = self.view.bounds
////        livevc.tabBar.isHidden = true
//        self.addChildViewController(livevc)
//        self.view.addSubview(livevc.view)
//        livevc.didMove(toParentViewController: self)
        
    }
    
    func reviseLiveView() {
        
        if let view = self.view.viewWithTag(10) {
            view.removeFromSuperview()
        }
//        livevc.view.frame = self.view.bounds
//        self.view.addSubview(livevc.view)
        
    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
//    
//    
//    override var childViewControllerForStatusBarStyle: UIViewController? {
//        return self;
//    }
}
