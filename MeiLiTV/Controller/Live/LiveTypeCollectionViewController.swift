//
//  LiveTypeCollectionViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveTypeCollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var oldOffSetY: CGFloat = 0
    private let reuseIdentifier = "MineCollectionViewCell"
    var padding: CGFloat = 1
    var itemWidth: CGFloat = (UIScreen.main.bounds.width - 4) / 3
    var collectionViewFrame = UIScreen.main.bounds
    
    var liveTypeResultModel = LiveTypeResultModel.init()
    var collectionView: UICollectionView!
    
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
                itemWidth = rect.width > rect.height ? (rect.width - 7) / 6 : (rect.width - 4) / 3
                if rect.width > rect.height {
                    itemWidth = (rect.width - 7) / 6
                    collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
                } else {
                    itemWidth = (rect.width - 4) / 3
//                    collectionViewFrame.size.height -= 49
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
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding)
        
        collectionView = UICollectionView.init(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        collectionView.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.mj_header = LAXMJRefressManager.getAnimationHeader(block: {
            self.requestData()
        })
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
        LiveViewModel.getLiveTypeData(successBlock: { (model) in
            
            self.placeholderView.endLoading(block: {
                self.collectionView.mj_header.endRefreshing()
                self.liveTypeResultModel = model
                self.collectionView.reloadData()
            })
            
        }) { (error) in
            self.placeholderView.loadingFailed()
            self.collectionView.mj_header.endRefreshing()
            self.showAlertLabelView(message: error)
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let data = liveTypeResultModel.data {
            return data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MineCollectionViewCell
        if let model = liveTypeResultModel.data?[indexPath.item] {
            cell.nameLabel.text = model.tag_name
            cell.nameLabel.font = UIFont.systemFont(ofSize: 12)
            cell.headImageView.layer.cornerRadius = cell.headImageView.bounds.width / 2
            if let str = model.icon_url {
                cell.headImageView.sd_setImage(with: URL.init(string: str), placeholderImage: UIImage.init(named: Image_Placeholder))
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = liveTypeResultModel.data?[indexPath.item] {
            let vc = LiveListCollectionViewController()
            vc.showNavigationBar()
            vc.liveTypeModel = model
            vc.laxTitle = model.tag_name
            self.laxTabBarPlusController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            if scrollView.contentOffset.y > scrollView.bounds.height / 2 {
                if var frame = self.laxMenuBarController?.laxMenuBar?.frame {
                    if scrollView.contentOffset.y > self.oldOffSetY {
                        frame.origin.y = -frame.height
                    } else {
                        frame.origin.y = 0
                    }
                    self.laxMenuBarController?.laxMenuBar?.frame = frame
                }
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
    
}
