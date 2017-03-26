//
//  LAXInteractiveTransition.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // pan手势
    lazy var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action:  #selector(self.handlePan(gesture:)))
    // 用于添加手势
    var containerView: UIView!
    // 将要被dismiss的控制器, 在动画的delegate中传入
    var dismissedVc: UIViewController! = nil {
        didSet {
            containerView = dismissedVc.view
            containerView.addGestureRecognizer(panGesture)
        }
    }
    // 是否执行交互动画
    var isInteracting = false
    
    override init() {
        super.init()
        
    }
    // 处理手势
    func handlePan(gesture: UIPanGestureRecognizer) {
        //动画是否完成或者取消
        func finishOrCancel() {
            let translation = gesture.translation(in: containerView)
            let percent = translation.x / containerView.bounds.width
            let velocityX = gesture.velocity(in: containerView).x
            let isFinished: Bool
            if velocityX <= 0 {
                isFinished = false
            } else if velocityX > 100 {
                isFinished = true
            } else if percent > 0.3 {
                isFinished = true
            } else {
                isFinished = false
            }
            
            isFinished ? finish() : cancel()
        }
        
        switch gesture.state {
            
        case .began:
            // 手势开始, 开启交互动画, 并且dismiss(需要设置animated: true)
            isInteracting = true
            // dimiss
            dismissedVc.dismiss(animated: true, completion: nil)
        case .changed:
            // 手势改变状态, 计算动画的进度
            if isInteracting {// 开始执行交互动画的时候才设置为非nil
                let translation = gesture.translation(in: containerView)
                var percent = translation.x / containerView.bounds.width
                if percent < 0 {
                    percent = 0
                }
                // 更新动画
                update(percent)
                
            }
        case .cancelled:
            if isInteracting {
                finishOrCancel()
                isInteracting = false
                
            }
        case .ended:
            if isInteracting {
                finishOrCancel()
                isInteracting = false
                
            }
        default:
            break
        }
    }
    
}
