//
//  LAXTransitioningDelegate.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private lazy var customAnimator = LAXAnimationedTransition()
    // 提供present的时候使用到的动画执行对象
    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }
    // 提供dismiss的时候使用到的动画执行对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }
    
    private lazy var interactive = LAXInteractiveTransition()
    
    // 提供dismiss的时候使用到的可交互动画执行对象
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // 因为执行自定义动画会先调用这个方法, 如果返回不为nil, 那么将不会执行非交互的动画!!
        // 所以isInteracting只有在手势开始的时候才被设置为true
        // 返回nil便于不是可交互的时候就直接执行不可交互的动画
        return interactive.isInteracting ? interactive : nil
    }
    
}
