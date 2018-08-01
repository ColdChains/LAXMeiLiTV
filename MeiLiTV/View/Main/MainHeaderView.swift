//
//  MainHeaderView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/2.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MainHeaderView: UICollectionReusableView, SDCycleScrollViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var autoPlayView: SDCycleScrollView!
    @IBOutlet weak var topContentView: UICollectionView!
    
    var topCollectionView: MainTopCollectionView!
    // 点击更多按钮闭包
    var touchupButtonBlock: ((_ model: RoomListModel?) -> Void)?
    // 轮播图和集合视图代理
    var viewDelegate: MainViewDelegate? {
        didSet {
            topCollectionView.viewDelegate = self.viewDelegate
        }
    }
    // 集合视图数据源
    var roomListResultModel = RoomListResultModel.init() {
        didSet {
            nameLabel.text = roomListResultModel.data?[0].tag_name
            topCollectionView.roomListResultModel = roomListResultModel
            topCollectionView.reloadData()
        }
    }
    // 轮播图数据源
    var sliderResultModel = SliderResultModel.init() {
        didSet {
            if let data = sliderResultModel.data {
                tempArr = []
                for model in data {
                    if let str = model.pic_url {
                        tempArr.append(str)
                    }
                }
                initAutoPlayView()
            }
        }
    }
    // 轮播图 图片url
    var tempArr: Array<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initAutoPlayView()
        
        topCollectionView = MainTopCollectionView.init(topContentView.bounds)
        topContentView.addSubview(topCollectionView)
        
        // 添加观察者
        self.topContentView.addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
    }
    
    deinit {
        self.topContentView.removeObserver(self, forKeyPath: "bounds")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //屏幕旋转 重新设置frame
        if keyPath == "bounds" {
            if let rect = change?[.newKey] as? CGRect {
                self.initAutoPlayView()
                topCollectionView.frame = rect
                topCollectionView.reloadData()
            }
        }
    }
    
    // 轮播图
    func initAutoPlayView() {
        autoPlayView.imageURLStringsGroup = []
        autoPlayView.imageURLStringsGroup = tempArr
        autoPlayView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        autoPlayView.placeholderImage = UIImage.init(named: Image_Placeholder_Rect)
        autoPlayView.autoScrollTimeInterval = DefaultAutoPlayTime
        autoPlayView.delegate = self
        autoPlayView.reloadMainCollectionView()
    }
    
    // 设置数据源
    func setHeaderViewModel(sliderResultModel: SliderResultModel, roomListResultModel: RoomListResultModel, touchupButtonBlock: @escaping (_ model: RoomListModel?) -> Void) {
        self.sliderResultModel = sliderResultModel
        self.roomListResultModel = roomListResultModel
        self.touchupButtonBlock = touchupButtonBlock
    }
    
    // MARK: - SDCycle Delegate
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        //点击轮播图item
        self.viewDelegate?.cycleScrollView(cycleScrollView, didSelectItemAt: index)
    }
    
    // MARK: - IBAction 点击更多
    @IBAction func buttonAction(_ sender: UIButton) {
        touchupButtonBlock?(roomListResultModel.data?[0])
    }
    
}
