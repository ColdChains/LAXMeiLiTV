//
//  MineViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MineViewController: LAXMeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr = [[""], ["我的资料", "我的账户"], ["我的关注", "我的视频"], ["直播历史", "观看记录"]]
        nameArr = [[""], ["head", "head"], ["head", "head"], ["head", "head"]]
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
        showDetailViewController()
    }
    
    // meviewcontroller delegate
    override func didselectMyselfCollectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: String) {
        print(model)
    }
    
    override func showLoginViewController() {
        let vc = LoginViewController()
        self.laxTabBarController?.present(vc, animated: true, completion: nil)
    }
    
    override func showDetailViewController() {
        let vc = PersonalViewController()
        self.laxTabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

}
