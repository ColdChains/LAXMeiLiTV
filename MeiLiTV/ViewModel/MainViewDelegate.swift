//
//  MainViewDelegate.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/13.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation

protocol MainViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int)
    
    func mainTopCollectionView(_ mainTopCollectionView: MainTopCollectionView!, didSelectItemAt index: Int)
    
}
