//
//  LAXAnimationManager.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/10.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXAnimationedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var titleArray: Array<String> = []
    
    init(titleArray: Array<String>) {
        super.init()
        self.titleArray = titleArray
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        var fromView = transitionContext.view(forKey: .from)
        var toView = transitionContext.view(forKey: .to)
        
        if fromView == nil {
            fromView = fromVC?.view
        }
        if toView == nil {
            toView = toVC?.view
        }
        
        var x = UIScreen.main.bounds.size.width
        if let t1 = fromVC?.title {
            if let t2 = toVC?.title {
                if let i = titleArray.index(of: t1) {
                    if let j = titleArray.index(of: t2) {
                        if i > j {
                            x = -x
                        }
                    }
                }
            }
        }
        
        var frame = toView?.frame
        frame?.origin.x = x
        toView?.frame = frame!
        
        transitionContext.containerView.addSubview(fromView!)
        transitionContext.containerView.addSubview(toView!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            fromView?.transform = (fromView?.transform.translatedBy(x: -x, y: 0))!
            toView?.transform = (toView?.transform.translatedBy(x: -x, y: 0))!
            
        }) { (b) in
            if b {
                transitionContext.completeTransition(true)
                fromView?.removeFromSuperview()
            }
        }
        
    }
    
}
