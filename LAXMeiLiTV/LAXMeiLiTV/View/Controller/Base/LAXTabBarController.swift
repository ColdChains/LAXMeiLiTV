//
//  PageScrollController.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/16.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

private var key: Void?
extension UIViewController {
    @IBInspectable var laxTabBarController: LAXTabBarController? {
        get {
            return objc_getAssociatedObject(self, &key) as? LAXTabBarController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class LAXTabBarControllerCell: UICollectionViewCell {
    var vc: UIViewController?
    var view: UIView?
}

class LAXTabBarController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LAXTabBarDelegate {
    
    private let cellId = "LAXTabBarControllerCell"
    private let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 49)
    
    var tabBar: LAXTabBar?
    
    var selectedIndex = 0
    var viewControllers: [UIViewController] = [] {
        didSet {
            for vc in viewControllers {
                vc.laxTabBarController = self
            }
        }
    }
    
    lazy var collectionView = { () -> UICollectionView in
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 49)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = rect.size
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return UICollectionView(frame: rect, collectionViewLayout:layout)
    }()
    
    override func loadView() {
        super.loadView()
        
        collectionView.frame = rect
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.register(LAXTabBarControllerCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.reloadData()
        self.view.addSubview(collectionView)
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar = LAXTabBar.init()
        self.tabBar?.tabBarDelegate = self
        self.view.addSubview(self.tabBar!)
    }
    
    //通过下标设置显示的视图
    func setSelectedViewController(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        let x = collectionView.bounds.size.width * CGFloat(selectedIndex)
        collectionView.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
    }
    
    //MARK: - tabBar delegate
    func tabBarDidSelectItem(index: Int) {
        print(index)
        setSelectedViewController(selectedIndex: index)
    }
    
    // MARK: - collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LAXTabBarControllerCell
        let vc = viewControllers[indexPath.item]
        vc.view.frame = rect
        
        cell.vc = vc
        cell.view?.removeFromSuperview()
        cell.view = vc.view
        cell.contentView.addSubview((vc.view)!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewControllers[indexPath.item].viewWillAppear(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewControllers[indexPath.item].viewWillDisappear(true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        self.selectedIndex = index
        tabBar?.selectedIndex = index
    }
    
}
