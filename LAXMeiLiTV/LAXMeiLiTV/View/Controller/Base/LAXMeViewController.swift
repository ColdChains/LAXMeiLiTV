//
//  LAXMeViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

protocol LAXMeViewControllerDelegate {
    func didselectMyselfCollectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: String)
}

class LAXMeViewController: UITableViewController, LAXMeViewControllerDelegate {
    
    let cellId = "cell"
    var imageHeight: CGFloat = ScreenWidth / 16 * 9
    
    var zoomImageView: UIImageView!
    var headImageView: UIImageView!
    var nickNameLabel: UILabel!
    
    var dataArr: [[String]] = [[""], [""]]
    var nameArr: [[String]] = [[""], [""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = GrayWhiteColor
        
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 49, 0);//tableview向下偏移
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.tableFooterView = UIView.init()
        
        self.createView()
        
    }
    
    func createView() {
        
        zoomImageView = UIImageView.init(image: UIImage.init(named: TopBackgroundImage))
        zoomImageView.frame = CGRect.init(x: 0, y: 0 - imageHeight, width: self.view.frame.width, height: imageHeight)
        zoomImageView.contentMode = .scaleAspectFill //高度改变宽度也跟着改变（不设置那将只会被纵向拉伸）
        zoomImageView.clipsToBounds = true;
        self.view.addSubview(zoomImageView)
        
        headImageView = UIImageView.init(frame: CGRect.init(x: 20, y: imageHeight - 100, width: 80, height: 80))
        headImageView.image = UIImage.init(named: HeadImage)
        headImageView.layer.cornerRadius = 40
        headImageView.clipsToBounds = true
        zoomImageView.addSubview(headImageView)
        
        nickNameLabel = UILabel.init(frame: CGRect.init(x: 120, y: imageHeight - 70, width: 170, height: 30))
        nickNameLabel.text = "未登录"
        nickNameLabel.font = UIFont.systemFont(ofSize: 20)
        nickNameLabel.textColor = UIColor.white
        zoomImageView.addSubview(nickNameLabel)
        
        zoomImageView.autoresizesSubviews = true
        headImageView.autoresizingMask = .flexibleTopMargin
        nickNameLabel.autoresizingMask = .flexibleTopMargin
        
        zoomImageView.isUserInteractionEnabled = true
        headImageView.isUserInteractionEnabled = true
        nickNameLabel.isUserInteractionEnabled = true
        
        headImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.touchHeadImageView)))
        nickNameLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.touchNicknameLabel)))
        
    }
    
    // MARK: - table view delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            
            cell.imageView?.image = UIImage.init(named: nameArr[indexPath.section][indexPath.row])
            cell.textLabel?.text = dataArr[indexPath.section][indexPath.row]
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
        showDetailViewController()
    }
    
    // scroll view delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y;
        if y < 0 - imageHeight && zoomImageView != nil {
            var frame = zoomImageView.frame
            frame.origin.y = y;
            frame.size.height =  0 - y
            zoomImageView.frame = frame
        }
    }
    
    // MeViewControllerDelegate
    func didselectMyselfCollectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: String) {
        print(model)
    }
    
    // button action
    func touchHeadImageView() {
        showLoginViewController()
    }
    
    func touchNicknameLabel() {
        showLoginViewController()
    }
    
    // custom function
    func showLoginViewController() {
    }
    
    func showDetailViewController() {
    }
    
}
