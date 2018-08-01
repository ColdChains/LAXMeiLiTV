//
//  BaseViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class BaseViewController: LAXNavigationController {

    var placeholderView: LoadPlaceholderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        
        placeholderView = LoadPlaceholderView.init(frame: self.view.bounds)
        self.view.addSubview(placeholderView)
        
        addViewContraint(subView: placeholderView, superView: self.view, widthMultiplier: 1, heightMultiplier: 1, centerYOffSet: 0)
        //添加观察者
//        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
//    }
//    
//    deinit {
//        self.view.removeObserver(self, forKeyPath: "frame")
    }
    
    //解决屏幕旋转动画关闭问题
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "frame" {
            placeholderView.loadingImageView.startAnimating()
        }
    }
    
    //解决点击屏幕动画关闭问题
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        placeholderView.loadingImageView.startAnimating()
    }
    
    //添加约束
    func addViewContraint(subView: UIView, superView: UIView, widthMultiplier: CGFloat, heightMultiplier: CGFloat, centerYOffSet: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let widthConstraint = NSLayoutConstraint.init(item: subView, attribute: .width, relatedBy: .equal, toItem: superView, attribute: .width, multiplier: widthMultiplier, constant: 0)
        let heightConstraint = NSLayoutConstraint.init(item: subView, attribute: .height, relatedBy: .equal, toItem: superView, attribute: .height, multiplier: heightMultiplier, constant: 0)
        let xConstraint = NSLayoutConstraint.init(item: subView, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint.init(item: subView, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1, constant: centerYOffSet)
        
        superView.addConstraint(widthConstraint)
        superView.addConstraint(heightConstraint)
        superView.addConstraint(xConstraint)
        superView.addConstraint(yConstraint)
    }
    
    //默认视图控制器只支持竖屏
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
}


