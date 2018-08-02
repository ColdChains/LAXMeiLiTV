//
//  LiveListCollectionViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit


class LiveListCollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var oldOffSetY: CGFloat = 0
    private let reuseIdentifier = "MainCollectionViewCell"
    var padding: CGFloat = 10
    var itemWidth: CGFloat = (UIScreen.main.bounds.width - 40) / 2
    var collectionViewFrame = UIScreen.main.bounds
    
    var collectionView: UICollectionView!
    var collectionViewBottom: CGFloat = 49
    // 菜单上的类别
    var liveMenuModel: LiveMenuModel?
    // 集合视图跳转过来
    var liveTypeModel: LiveTypeModel?
    
    var liveListResultModel = LiveListResultModel.init()
    // 数据源
    var dataArray: Array<RoomModel> = []
    var count = 0
    
    @IBOutlet weak var scrollToTopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCollectionView()
        collectionView.frame = collectionViewFrame
        
        createScrollToTopButton()
        
        placeholderView.reLoadingBlock = {
            self.requestData()
        }
        placeholderView.startLoading()
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                //屏幕旋转 重新设置frame
                collectionViewFrame.size = rect.size
                
                if rect.width > rect.height {
                    itemWidth = (rect.width - 40) / 3
                    collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
                } else {
                    itemWidth = (rect.width - 30) / 2
                    collectionViewFrame.size.height -= collectionViewBottom
                    collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
                }
                reloadCollectionView()
            }
        }
    }
    
    // 创建集合视图
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding)
        
        collectionView = UICollectionView.init(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = WhiteColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        collectionView.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.mj_header = LAXMJRefressManager.getAnimationHeader(block: {
            self.count = 0
            self.requestData()
        })
        collectionView.mj_footer = LAXMJRefressManager.getDefaultFooter {
            self.count += DefaultLoadCount
            self.requestData()
        }
    }
    // 设置frame
    func reloadCollectionView() {
//        UIView.animate(withDuration: 0.25) {
            self.collectionView.frame = self.collectionViewFrame
//        }
        self.view.sendSubview(toBack: collectionView)
        collectionView.reloadData()
    }
    
    //点击返回顶部
    func createScrollToTopButton() {
        scrollToTopButton.backgroundColor = UIColor.red
        scrollToTopButton.setTitleColor(UIColor.white, for: .normal)
        scrollToTopButton.setTitle("Top", for: .normal)
        scrollToTopButton.layer.cornerRadius = 20
        scrollToTopButton.layer.masksToBounds = true
        self.scrollToTopButton.isHidden = true
        scrollToTopButton.alpha = 0
        scrollToTopButton.addTarget(self, action: #selector(self.scrollToTopButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(scrollToTopButton)
    }
    
    func scrollToTopButtonAction(sender: UIButton) {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            collectionView.setContentOffset(CGPoint.init(x: 0, y: -44), animated: true)
        } else {
            collectionView.setContentOffset(CGPoint.init(x: 0, y: -64), animated: true)
        }
    }
    
    func requestData() {
//        requestSubType()
        
        var tagId = -1
        // 无id请求全部数据
        if let i = liveMenuModel?.cate_id {
            tagId = i
        }
        var subId: Int? = nil
        if liveTypeModel != nil {
            subId = liveTypeModel?.cate_id
        }
        LiveViewModel.getLiveListData(tagId: tagId, subTagId: subId, offset: count, successBlock: { (model) in
            
            self.placeholderView.endLoading(block: {
                self.collectionView.mj_header.endRefreshing()
                
                self.liveListResultModel = model
                if self.dataArray.count > self.count {
                    self.dataArray.removeAll()
                }
                if let data = self.liveListResultModel.data {
                    // 根据数组内容判断是否有更多数据
                    if data.count == 0{
                        self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                    } else {
                        self.collectionView.mj_footer.endRefreshing()
                    }
                    self.dataArray += data
                }
                self.collectionView.reloadData()
                
            })
            
        }) { (error) in
            self.placeholderView.loadingFailed()
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            self.showAlertLabelView(message: error)
        }
    }
    
    func requestSubType() {
        if let name = liveTypeModel?.short_name {
            LiveViewModel.getLiveSubTypeData(tagName: name, successBlock: { (model) in
                
            }) { (error) in
                
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: itemWidth, height: itemWidth / 16 * 9 + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        let model = dataArray[indexPath.item]
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < dataArray.count {
            let model = dataArray[indexPath.item]
            print(model)
            // 创建房间
            let vc = LiveRoomViewController()
            vc.roomModel = model
            if self.navigationController != nil {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.showAlertLabelView(message: "亲，房间打不开，请稍后再来")
        }
    }
    
    // scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            if var frame = self.laxMenuBarController?.laxMenuBar?.frame {
                if scrollView.contentOffset.y > scrollView.bounds.height / 2 && scrollView.contentOffset.y > self.oldOffSetY {
                    frame.origin.y = -frame.height
                } else {
                    frame.origin.y = 0
                }
                self.laxMenuBarController?.laxMenuBar?.frame = frame
            }
            if scrollView.contentOffset.y > self.view.bounds.height {
                self.scrollToTopButton.isHidden = false
                self.scrollToTopButton.alpha = 1
            } else {
                self.scrollToTopButton.alpha = 0
            }
            self.oldOffSetY = scrollView.contentOffset.y
        })
    }
    
    override func showNavigationBar() {
        super.showNavigationBar()
        // 显示navigationbar 并调整collectionview大小
        collectionViewBottom = 0
    }
    
}
