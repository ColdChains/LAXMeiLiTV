//
//  MainViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , MainViewDelegate{
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topMenuViewTop: NSLayoutConstraint!
    @IBOutlet weak var topMenuView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollToTopButton: UIButton!
    
    private let mainCellId = "MainCollectionViewCell"
    private let headerId = "MainHeaderView"
    private let sectionHeaderId = "MainSectionHeaderView"
    
    private let padding: CGFloat = 10
    private var itemWidth: CGFloat = 0
    private let sectionHeaderHeight: CGFloat = 60
    private var headerViewHeight: CGFloat = ScreenWidth / 3 + 60 + 60
    // 判断滑动方向
    private var oldOffSetY: CGFloat = 0
    var frame = UIScreen.main.bounds
    
    var timerManager: LAXTimerManager?
    var isVertical = true
    
    var sliderResultModel = SliderResultModel.init()
    var roomListResultModel = RoomListResultModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 监听网络的状态
        addReachabilityManager()
        
        initCollectionView()
        reloadCollectionView()
        createScrollToTopButton()
        
        placeholderView.reLoadingBlock = {
            self.requestAllData()
        }
        placeholderView.startLoading()
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        StatusBackgroundView.shared.removeFromSuperview()
        self.view.bringSubview(toFront: topView)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                //屏幕旋转 重新设置frame
                frame = rect
                headerViewHeight = rect.width / 3 + 60 + 60
                itemWidth = rect.width > rect.height ? (rect.width - 40) / 3 : (rect.width - 30) / 2
                topViewHeight.constant = rect.width > rect.height ? 0 : 20
                reloadCollectionView()
            }
        }
    }
    // 初始化top按钮
    func createScrollToTopButton() {
        scrollToTopButton.backgroundColor = UIColor.red
        scrollToTopButton.setTitleColor(UIColor.white, for: .normal)
        scrollToTopButton.setTitle("Top", for: .normal)
        scrollToTopButton.layer.cornerRadius = 20
        scrollToTopButton.layer.masksToBounds = true
        scrollToTopButton.isHidden = true
        scrollToTopButton.alpha = 0
        scrollToTopButton.addTarget(self, action: #selector(self.scrollToTopButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(scrollToTopButton)
    }
    // 点击返回顶部
    func scrollToTopButtonAction(sender: UIButton) {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            collectionView.setContentOffset(CGPoint.init(x: 0, y: -44), animated: true)
        } else {
            collectionView.setContentOffset(CGPoint.init(x: 0, y: -64), animated: true)
        }
    }
    // 初始化collectionview
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(UINib.init(nibName: mainCellId, bundle: nil), forCellWithReuseIdentifier: mainCellId)
        collectionView.register(UINib.init(nibName: headerId, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(UINib.init(nibName: sectionHeaderId, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
        collectionView.mj_header = LAXMJRefressManager.getAnimationHeader(block: { () in
            self.requestAllData()
        })
    }
    // 设置collectionview的frame
    func reloadCollectionView() {
        if frame.width > frame.height {
            isVertical = false
            topMenuViewTop.constant = 0
            collectionView.contentInset = UIEdgeInsets.init(top: 44, left: 0, bottom: 0, right: 0)
        } else {
            isVertical = true
            topMenuViewTop.constant = 20
            collectionView.contentInset = UIEdgeInsets.init(top: 64, left: 0, bottom: 0, right: 0)
        }
        collectionView.reloadData()
    }
    //请求数据
    func requestAllData() {
        
        // 如果没有网络提示用户
        if LAXReachabilityManager.shared.state == .viaNone {
            self.showAlertLabelView(message: "亲，您还未连接网络")
            self.collectionView.mj_header.endRefreshing()
            self.placeholderView.loadingFailed()
            return
        }
        if LAXReachabilityManager.shared.onlyWIFI && LAXReachabilityManager.shared.state == .viaWWAN {
            self.showAlertLabelView(message: "当前只允许WIFI联网")
            self.collectionView.mj_header.endRefreshing()
            self.placeholderView.loadingFailed()
            return
        }
        
        requestAutoPlayViewData()
        requestRoomData()
        
    }
    
    func requestAutoPlayViewData() {
        MainViewModel.getAutoPlayViewData(successBlock: { (model) in
            
            self.sliderResultModel = model
            self.collectionView.reloadData()
            
            self.addTimerManager()
            
        }) { (error) in
            print(error)
            
            self.addTimerManager()
            
        }
    }
    
    func requestRoomData() {
        MainViewModel.getRoomListData(successBlock: { (model) in
            
            self.placeholderView.endLoading(block: {
                self.collectionView.mj_header.endRefreshing()
                self.roomListResultModel = model
                self.collectionView.reloadData()
            })
            
            self.addTimerManager()
            
        }) { (error) in
            
            self.collectionView.mj_header.endRefreshing()
            self.placeholderView.loadingFailed()
            print(error)
            
            self.addTimerManager()
            
        }
    }
    
    // 添加网络状态监听
    func addReachabilityManager() {
        LAXReachabilityManager.shared.monitorNetwork(connectWiFiBlock: { (str) in
            self.showAlertLabelView(message: str)
        }, connectWWANBlock: { (str) in
            self.showAlertLabelView(message: str)
        }) { (str) in
            self.showAlertLabelView(message: str)
        }
    }
    
    // 添加数据请求失败定时器
    func addTimerManager() {
        if self.sliderResultModel.data == nil || self.roomListResultModel.data == nil {
            self.timerManager?.timer?.invalidate()
            self.timerManager = LAXTimerManager.init(interval: 5, doSomething: {
                print("重新发送请求")
                self.requestAllData()
            }, isFinish: { () -> Bool in
                // 数组不为空 结束
                return self.sliderResultModel.data != nil && self.roomListResultModel.data != nil
            })
        }
    }
    
    // MARK: - CollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let data = roomListResultModel.data {
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = roomListResultModel.data?[section].room_list {
            return list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(padding, padding, padding, padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: itemWidth, height: itemWidth / 16 * 9 + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: 0, height: headerViewHeight)
        }
        return CGSize.init(width: 0, height: sectionHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                // 设置第一段的段头
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MainHeaderView
                view.viewDelegate = self
                view.setHeaderViewModel(sliderResultModel: sliderResultModel, roomListResultModel: roomListResultModel, touchupButtonBlock: { (roomModel) in
                    // 点击更多按钮 跳转到第二页
                    //self.laxTabBarPlusController?.selectedIndex = 1
                    if let data = self.roomListResultModel.data {
                        
                        let vc = LiveListCollectionViewController()
                        vc.showNavigationBar()
                        let model = LiveTypeModel()
                        model.cate_id = data[indexPath.section].tag_id
                        model.tag_name = data[indexPath.section].tag_name
                        vc.liveTypeModel = model
                        vc.laxTitle = model.tag_name
                        self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
                        
                    } else {
                        self.showAlertLabelView(message: "亲，房间打不开，请稍后再来")
                    }
                })
                return view
                
            }
            // 设置其他段的段头
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! MainSectionHeaderView
            let model = roomListResultModel.data?[indexPath.section]
            view.setModel(model: model, touchupButtonBlock: { (model) in
                //self.laxTabBarPlusController?.navigationController?.pushViewController(UIViewController(), animated: true)
                
                if let data = self.roomListResultModel.data {
                    
                    let vc = LiveListCollectionViewController()
                    vc.showNavigationBar()
                    let model = LiveTypeModel()
                    model.cate_id = data[indexPath.section].tag_id
                    model.tag_name = data[indexPath.section].tag_name
                    vc.liveTypeModel = model
                    vc.laxTitle = model.tag_name
                    self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
                    
                } else {
                    self.showAlertLabelView(message: "亲，房间打不开，请稍后再来")
                }
            })
            return view
        }
        return UICollectionReusableView.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellId, for: indexPath) as! MainCollectionViewCell
        if let model = roomListResultModel.data?[indexPath.section].room_list?[indexPath.row] {
            cell.model = model
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = roomListResultModel.data?[indexPath.section].room_list?[indexPath.row] {
            print(model)
            // 创建房间
            let vc = LiveRoomViewController()
            vc.roomModel = model
            self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showAlertLabelView(message: "亲，房间打不开，请稍后再来")
        }
    }
    
    // scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            if scrollView.contentOffset.y > self.headerViewHeight {
                var frame = self.topMenuView.frame
                if scrollView.contentOffset.y > self.oldOffSetY {
                    frame.origin.y = -self.topMenuView.bounds.height
                } else {
                    if self.isVertical {
                        frame.origin.y = 20
                    } else {
                        frame.origin.y = 0
                    }
                }
                self.topMenuView.frame = frame
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
    
    // MARK: - MainViewDelegate
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if let model = sliderResultModel.data?[index].room {
            print(model)
            // 创建房间
            let vc = LiveRoomViewController()
            vc.roomModel = model
            self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showAlertLabelView(message: "亲，房间打不开，请稍后再来")
        }
    }
    
    func mainTopCollectionView(_ mainTopCollectionView: MainTopCollectionView!, didSelectItemAt index: Int) {
        if let data = roomListResultModel.data {
            // 点击最后的更多 跳转到第二页
            if index >= data.count - 1 {
                self.laxTabBarPlusController?.selectedIndex = 1
                if let vc = self.laxTabBarPlusController?.viewControllers[1] as? LiveViewController {
                    vc.selectedIndex = 0
                }
            } else {
                let vc = LiveListCollectionViewController()
                vc.showNavigationBar()
                // 集合视图是子分类 LiveTypeModel
                let model = LiveTypeModel()
                model.cate_id = data[index + 1].tag_id
                model.tag_name = data[index + 1].tag_name
                vc.liveTypeModel = model
                vc.laxTitle = model.tag_name
                self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.showAlertLabelView(message: "亲，房间打不开，请稍后再来")
        }
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
