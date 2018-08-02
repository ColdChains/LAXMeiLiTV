//
//  MyselfCollectionViewProtocol.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/20.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import Foundation
import UIKit

protocol MineViewDelegate {
    func didselectMineCollectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: MineModel)
}
