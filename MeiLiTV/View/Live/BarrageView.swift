//
//  BarrageView.swift
//  LAXDouyu
//
//  Created by 冰凉的枷锁 on 2016/10/12.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

class BarrageView: UIView {
    
    let width = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
    let labelHeight: CGFloat = 20
    var topPadding: CGFloat = 0
    // 要显示的弹幕数组
    var messageQueue: [String] = []
    // 要显示的弹幕集合
    var labelOnViewSet: Set<UILabel> = []
    // 字典记录每一行的弹幕位置
    var offSetDic: [Int: CGFloat] = [0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0]
    // 定时器 创建弹幕
    var timer1: Timer?
    // 定时器 移动弹幕
    var timer2: Timer?
    
    func startDanmu() {
        self.isHidden = false
        messageQueue.removeAll()
        print("start")
        if timer1 == nil {
            timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.createTimer(t:)), userInfo: nil, repeats: true)
        }
        if timer2 == nil {
            timer2 = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.moveTimer(t:)), userInfo: nil, repeats: true)
        }
    }
    
    func stopDanmu() {
        self.isHidden = true
        print("stop")
        timer1?.invalidate()
        timer2?.invalidate()
        timer1 = nil
        timer2 = nil
    }
    
    func createTimer(t: Timer) {
        
        if let message = messageQueue.first {
            
            let label = UILabel.init()
            label.text = message
            label.textColor = UIColor.red
            label.textAlignment = .center
            self.addSubview(label)
            
            let w = message.boundingRect(with: CGSize.init(width: 1000, height: 21), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil).size.width
            
            for (line, offset) in offSetDic {

                if offset < self.frame.size.width {
                    
                    let frame = CGRect.init(x: width, y: CGFloat(line) * labelHeight + topPadding, width: w + 100, height: labelHeight)
                    label.frame = frame
                    
                    offSetDic[line] = width + w
                    labelOnViewSet.insert(label)
                    messageQueue.removeFirst()
                    
                    print(line, offset, message, label.frame)
                    break
                }
                
            }
            print("--------------")
        }
        
    }
    
    func moveTimer(t: Timer) {
        //        print(messageQueue)
        
        for label in labelOnViewSet {
            
            var frame = label.frame
            frame.origin.x -= 1
            label.frame = frame
            
            
            if frame.origin.x + width  < 0 {
                label.removeFromSuperview()
                labelOnViewSet.remove(label)
            }
            
            let line = (frame.origin.y - topPadding) / labelHeight
            let newOffSet = frame.origin.x + frame.size.width
            
            if offSetDic[Int(line)] != nil {
                if offSetDic[Int(line)]! - 1 == newOffSet {
                    offSetDic[Int(line)] = newOffSet
                }
            }
            
        }
    }
    
}
