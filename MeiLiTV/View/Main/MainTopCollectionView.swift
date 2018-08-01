//
//  MainTopCollectionView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/13.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MainTopCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let topCellId = "MainTopCollectionViewCell"
    
    private let padding: CGFloat = 8
    private var itemWidth: CGFloat = 44
    
    var roomListResultModel = RoomListResultModel.init() {
        didSet {
            self.reloadData()
        }
    }
    var viewDelegate: MainViewDelegate?
    
    init(_ frame: CGRect) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding)
        super.init(frame: frame, collectionViewLayout: layout)
        
        initCollectionView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCollectionView() {
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsets.init()
        self.backgroundColor = UIColor.clear
        self.register(UINib.init(nibName: topCellId, bundle: nil), forCellWithReuseIdentifier: topCellId)
    }
    
    // MARK: - CollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = roomListResultModel.data {
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(padding, padding, padding, padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 第一个不显示 最后一个显示更多
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath) as! MainTopCollectionViewCell
        
        if indexPath.row == roomListResultModel.data!.count - 1 {
            cell.nameLabel.text = "更多"
            cell.headImageView.image = UIImage.init(named: Image_TopCollectionView_Default)
        } else {
            let roomList = roomListResultModel.data?[indexPath.row + 1]
            cell.nameLabel.text = roomList?.tag_name
            if let str = roomList?.icon_url {
                if let url = URL.init(string: str) {
                    cell.headImageView.setImageWith(url, placeholderImage: UIImage.init(named: Image_TopCollectionView_Default))
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //点击顶部集合视图item
        self.viewDelegate?.mainTopCollectionView(self, didSelectItemAt: indexPath.row)
    }
    
}
