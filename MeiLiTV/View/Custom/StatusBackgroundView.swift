//
//  StatusBackgroundView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/5/6.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class StatusBackgroundView: UIView {
    
    static var shared = StatusBackgroundView.init()
    
    fileprivate var touchBlock: (() -> Void)?
    
    var width = UIScreen.main.bounds.width {
        didSet {
            self.frame = CGRect.init(x: 0, y: 0, width: width, height: 20)
        }
    }
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 20))
        self.backgroundColor = UIColor.red
    }
    
    init(touchBlock: (() -> Void)?) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 20))
        self.touchBlock = touchBlock
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchBlock?()
    }
    
    fileprivate func tapAction(tap: UITapGestureRecognizer) {
        touchBlock?()
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
}
