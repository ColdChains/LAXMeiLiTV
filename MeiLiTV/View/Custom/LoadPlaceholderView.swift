//
//  LoadPlaceholderView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LoadPlaceholderView: UIView {

    
    var loadingFailedView = UIView.init()
    private var failedImageView = UIImageView.init()
    private var failedLabel = UILabel.init()
    private var failedButton = UIButton.init()
    
    var loadingView = UIView.init()
    var loadingImageView = UIImageView.init()
    
    var reLoadingBlock: (() -> Void)?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        initLoadingFailedView()
        initLoadingView()
        loadingFailedView.alpha = 0
        self.alpha = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        initLoadingView()
        initLoadingFailedView()
        loadingFailedView.alpha = 0
        self.alpha = 0
        //添加观察者
        self.loadingImageView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        self.loadingImageView.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            self.loadingImageView.startAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLoadingView() {
        loadingImageView.animationImages = [UIImage.init(named: "img_loading_1")!, UIImage.init(named: "img_loading_2")!]
        loadingImageView.animationDuration = 0.6
        loadingImageView.startAnimating()
        loadingImageView.backgroundColor = UIColor.black
        self.addSubview(loadingView)
        loadingView.addSubview(loadingImageView)
        
        addViewContraint(subView: loadingView, superView: self, widthMultiplier: 1, heightMultiplier: 1, centerYOffSet: 0)
        addViewContraint(subView: loadingImageView, superView: loadingView, width: 120, height: 150, centerYOffSet: -30)
    }
    
    private func initLoadingFailedView() {
        failedImageView.image = UIImage.init(named: "img_loading_fail")
        failedLabel.text = "请您检查网络是否正常"
        failedLabel.textAlignment = .center
        failedLabel.font = UIFont.systemFont(ofSize: 14)
        failedButton.backgroundColor = UIColor.orange
        failedButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        failedButton.setTitle("点击重新加载", for: .normal)
        failedButton.setTitleColor(UIColor.white, for: .normal)
        failedButton.addTarget(self, action: #selector(self.reloadButtonAction(_:)), for: .touchUpInside)
        failedButton.layer.cornerRadius = 5
        failedButton.layer.masksToBounds = true
        
        self.addSubview(loadingFailedView)
        loadingFailedView.addSubview(failedLabel)
        loadingFailedView.addSubview(failedButton)
        loadingFailedView.addSubview(failedImageView)
        
        addViewContraint(subView: loadingFailedView, superView: self, widthMultiplier: 1, heightMultiplier: 1, centerYOffSet: 0)
        addViewContraint(subView: failedImageView, superView: loadingFailedView, width: 120, height: 120, centerYOffSet: -70)
        addViewContraint(subView: failedLabel, superView: loadingFailedView, width: 150, height: 20, centerYOffSet: 20)
        addViewContraint(subView: failedButton, superView: loadingFailedView, width: 100, height: 20, centerYOffSet: 50)
    }
    
    //加载失败
    func loadingFailed() {
        UIView.animate(withDuration: 0.5) {
            self.loadingFailedView.alpha = 1
            self.loadingView.alpha = 0
        }
    }
    
    func startLoading() {
        self.superview?.bringSubview(toFront: self)
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
            self.loadingFailedView.alpha = 0
            self.loadingView.alpha = 1
        }) { (b) in
            self.reLoadingBlock?()
        }
    }
    
    func endLoading(block: (() -> Void)?) {
        if self.alpha == 0 {
            block?()
            return
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { (b) in
            block?()
            self.superview?.sendSubview(toBack: self)
        })
    }
    
    func reloadButtonAction(_ sender: UIButton) {
        startLoading()
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
    
    //添加约束
    func addViewContraint(subView: UIView, superView: UIView, width: CGFloat, height: CGFloat, centerYOffSet: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let widthConstraint = NSLayoutConstraint.init(item: subView, attribute: .width, relatedBy: .equal, toItem: superView, attribute: .width, multiplier: 0, constant: width)
        let heightConstraint = NSLayoutConstraint.init(item: subView, attribute: .height, relatedBy: .equal, toItem: superView, attribute: .height, multiplier: 0, constant: height)
        let xConstraint = NSLayoutConstraint.init(item: subView, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint.init(item: subView, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1, constant: centerYOffSet)
        
        superView.addConstraint(widthConstraint)
        subView.addConstraint(heightConstraint)
        superView.addConstraint(xConstraint)
        superView.addConstraint(yConstraint)
    }
    
}
