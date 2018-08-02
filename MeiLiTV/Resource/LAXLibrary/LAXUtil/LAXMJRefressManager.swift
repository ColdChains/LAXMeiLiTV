//
//  LAXMJHeader.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import MJRefresh

class LAXMJRefressManager {
    
    class func getAnimationHeader(block:@escaping () -> Void) -> MJRefreshGifHeader? {
        
        let header = MJRefreshGifHeader.init(refreshingBlock: {
            block()
        })
//        header?.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        header?.setImages([UIImage.init(named: "img_mj_stateIdle")!], for: .idle)
        header?.setImages([UIImage.init(named: "img_mj_statePulling")!], for: .pulling)
        header?.setImages([UIImage.init(named: "img_mj_stateRefreshing_01")!, UIImage.init(named: "img_mj_stateRefreshing_02")!, UIImage.init(named: "img_mj_stateRefreshing_03")!, UIImage.init(named: "img_mj_stateRefreshing_04")!], for: .refreshing)
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.stateLabel.isHidden = true
        return header
        
    }
    
    class func getDefaultHeader(block:@escaping () -> Void) -> MJRefreshHeader? {
        let header = MJRefreshHeader.init(refreshingBlock: {
            block()
        })
        return header
    }
    
    class func getDefaultFooter(block:@escaping () -> Void) -> MJRefreshFooter? {
        let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            block()
        })
        return footer
    }
    
}
