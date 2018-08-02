//
//  LAXMeViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXMeViewController: UITableViewController {
    
    private let cellId = "cell"
    private var imageHeight: CGFloat = UIScreen.main.bounds.width / 16 * 9 { // 按照图片比例设置高度
        didSet {
            self.tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 49, 0);
            self.setSubViewsFrame()
        }
    }
    
    private var zoomImageView = UIImageView.init()
    private var headImageView = UIImageView.init()
    private var nickNameLabel = UILabel.init()
    
    var headImage = "" {
        didSet {
            self.headImageView.image = UIImage.init(named: headImage)
        }
    }
    
    var backImage = "" {
        didSet {
            self.zoomImageView.image = UIImage.init(named: backImage)
        }
    }
    
    var backImageH = ""
    
    var dataArr: [[String]] = [[""], [""]]
    var nameArr: [[String]] = [[""], [""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 49, 0);//tableview向下偏移
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.tableFooterView = UIView.init()
        
        self.createView()
        self.setSubViewsFrame()
        //添加观察者
        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        self.view.removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //屏幕旋转 重新设置frame
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                if rect.size.width < rect.size.height {
                    //屏幕纵向
                    imageHeight = rect.size.width / 16 * 9
                    zoomImageView.image = UIImage.init(named: backImage)
                } else {
                    //屏幕横向
                    imageHeight = rect.size.width / 5 * 1
                    zoomImageView.image = UIImage.init(named: backImageH)
                }
            }
        }
    }
    
    func setSubViewsFrame() {
        zoomImageView.frame = CGRect.init(x: 0, y: 0 - imageHeight, width: self.view.frame.width, height: imageHeight)
        headImageView.frame = CGRect.init(x: 20, y: imageHeight - 100, width: 80, height: 80)
        headImageView.layer.cornerRadius = 40
        nickNameLabel.frame = CGRect.init(x: 120, y: imageHeight - 70, width: 170, height: 30)
    }
    
    func createView() {
        
        zoomImageView = UIImageView.init()
        zoomImageView.contentMode = .scaleAspectFill //高度改变宽度也跟着改变（不设置那将只会被纵向拉伸）
        zoomImageView.clipsToBounds = true;
        self.view.addSubview(zoomImageView)
        
        headImageView = UIImageView.init()
        headImageView.clipsToBounds = true
        zoomImageView.addSubview(headImageView)
        
        nickNameLabel = UILabel.init()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        cell.imageView?.image = UIImage.init(named: nameArr[indexPath.section][indexPath.row])
        cell.textLabel?.text = dataArr[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
        if y < 0 - imageHeight {
            var frame = zoomImageView.frame
            frame.origin.y = y;
            frame.size.height =  0 - y
            zoomImageView.frame = frame
        }
    }
    
    // button action
    func touchHeadImageView() {
        print("\ntouch head imageview")
        showLoginViewController()
    }
    
    func touchNicknameLabel() {
        print("\ntouch nickname label")
        showLoginViewController()
    }
    
    // custom function
    func showLoginViewController() {
    }
    
    func showDetailViewController() {
    }
    
}
