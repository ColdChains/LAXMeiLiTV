//
//  LAXTimer.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/19.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXTimerManager: NSObject {
    
    var timer: Timer?
    var interval: TimeInterval = 0
    var isRepeat = false
    var isFinish: (() -> Bool)?
    var doSomething: (() -> Void)?
    
    override init() {
        
    }
    
    // 给定一个结束定时器的条件
    init(interval: TimeInterval, doSomething:(() -> Void)?, isFinish: (() -> Bool)?) {
        super.init()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        self.interval = interval
        self.isRepeat = true
        self.doSomething = doSomething
        self.isFinish = isFinish
    }
    
    // 不循环
    init(norepeats interval: TimeInterval, doSomething:(() -> Void)?) {
        super.init()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
        self.interval = interval
        self.isRepeat = false
        self.doSomething = doSomething
        self.isFinish = { () -> Bool in
            return false
        }
    }
    
    // 循环
    init(interval: TimeInterval, doSomething:(() -> Void)?) {
        super.init()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        self.interval = interval
        self.isRepeat = true
        self.doSomething = doSomething
        self.isFinish = { () -> Bool in
            return false
        }
    }
    
    func timerAction() {
        if let b = isFinish?() {
            if b {
                timer?.invalidate()
                timer = nil
            } else {
                doSomething?()
            }
        }
    }
    
    func resetTimer() {
        invalidateTimer()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: isRepeat)
        self.isFinish = { () -> Bool in
            return false
        }
    }
    
    func invalidateTimer() {
        self.isFinish = { () -> Bool in
            return true
        }
        timer?.invalidate()
        timer = nil
    }
    
    //        let delayTime = DispatchTime.now() + Double(3)
    //        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
    //            self.hideMenuView()
    //        })
}

