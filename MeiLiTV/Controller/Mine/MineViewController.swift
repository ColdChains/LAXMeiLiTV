//
//  MineViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MineViewController: LAXMeViewController, MineViewDelegate {
    
    var collectionView = MineCollectionView.init(line: 1, rank: 4, frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headImage = "head"
        backImage = "topback"
        backImageH = "topback2"
        
        dataArr = [["我的资料", "我的账户"], ["我的关注", "我的视频"], ["直播历史", "观看记录"], ["设置"]]
        nameArr = [["", ""], ["", ""], ["", ""], [""]]
        self.tableView.reloadData()
        
        collectionView.viewdelegate = self
        self.tableView.tableHeaderView = collectionView;
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //屏幕旋转 重新设置frame
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                collectionView.width = rect.width
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
        if (indexPath.section == 3) {
            let vc = SettingViewController()
            self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
        } else {
            showDetailViewController()
        }
    }
    
    // mine collectionview delegate
    func didselectMineCollectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: MineModel) {
        print(indexPath, model)
        showDetailViewController()
    }
    
    override func showLoginViewController() {
        let vc = LoginViewController()
        self.laxTabBarPlusController?.present(vc, animated: true, completion: nil)
    }
    
    override func showDetailViewController() {
        let vc = PersonalViewController()
        self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
    }

}
