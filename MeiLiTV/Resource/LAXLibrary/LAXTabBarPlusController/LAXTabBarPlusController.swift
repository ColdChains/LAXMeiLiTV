//
//  LAXTabBarPlusController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit
/*
 * 给UIViewController扩展laxTabBarPlusController属性
 */
private var key: Void?
extension UIViewController {
    @IBInspectable var laxTabBarPlusController: LAXTabBarPlusController? {
        get {
            return objc_getAssociatedObject(self, &key) as? LAXTabBarPlusController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
/*
 * LAXTabBarPlusControllerCell CollectionViewCell
 */
class LAXTabBarPlusControllerCell: UICollectionViewCell {
    var vc: UIViewController?
    var view: UIView?
}
/*
 * LAXTabBarPlusController
 */
class LAXTabBarPlusController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LAXTabBarPlusDelegate {
    
    private let cellId = "LAXTabBarControllerCell"
    private var collectionViewFrame = UIScreen.main.bounds
    
    var laxTabBarPlus: LAXTabBarPlus?
    // 当前选中的下标
    var selectedIndex = 0 {
        didSet {
            laxTabBarPlus?.selectedIndex = selectedIndex
            let x = collectionView.bounds.size.width * CGFloat(selectedIndex)
            collectionView.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
            collectionView.reloadData()
        }
    }
    // 所有要显示的视图控制器
    var viewControllers: [UIViewController] = [] {
        didSet {
            for vc in viewControllers {
                vc.laxTabBarPlusController = self
                self.addChildViewController(vc)
                vc.didMove(toParentViewController: self)
            }
        }
    }
    // 是否可以拖拽
    var isScrollEnabled = true {
        didSet {
            collectionView.isScrollEnabled = isScrollEnabled
        }
    }
    
    lazy var collectionView = { () -> UICollectionView in
        let rect = CGRect()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout:layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.isHidden = true
        
        reloadCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LAXTabBarPlusControllerCell.self, forCellWithReuseIdentifier: cellId)
        self.view.addSubview(collectionView)

        self.laxTabBarPlus = LAXTabBarPlus.init()
        self.laxTabBarPlus?.tabBarPlusDelegate = self
        self.view.addSubview(self.laxTabBarPlus!)
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
                collectionViewFrame = rect
                if rect.size.width > rect.size.height {
                    self.laxTabBarPlus?.isHidden = true
                } else {
                    self.laxTabBarPlus?.isHidden = false
                    collectionViewFrame.size.height -= 49
                }
                
                reloadCollectionView()
                //change
                laxTabBarPlus?.size = rect.size
                laxTabBarPlus?.revisePlusButton()
                
                tabBarPlusDidSelectItem(index: selectedIndex)
            }
        }
    }
    
    // 设置collectionview大小
    func reloadCollectionView() {
//        UIView.animate(withDuration: 0.25) {
            self.collectionView.frame = self.collectionViewFrame
//        }
        self.view.sendSubview(toBack: collectionView)
        collectionView.reloadData()
    }
    
    // 添加约束
    func addViewContraint(subView: UIView, superView: UIView, constant: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let widthConstraint = NSLayoutConstraint.init(item: subView, attribute: .width, relatedBy: .equal, toItem: superView, attribute: .width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint.init(item: subView, attribute: .height, relatedBy: .equal, toItem: superView, attribute: .height, multiplier: 1, constant: constant)
        let xConstraint = NSLayoutConstraint.init(item: subView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1, constant: 0)
        
        superView.addConstraint(widthConstraint)
        superView.addConstraint(heightConstraint)
        superView.addConstraint(xConstraint)
        superView.addConstraint(yConstraint)
    }
    
    //MARK: - tabBarplus delegate  通过下标设置显示的视图
    func tabBarPlusDidSelectItem(index: Int) {
        self.selectedIndex = index
    }
    //change
    func tabBarPlusDidSelectPlusButton(sender: UIButton) {
        
    }
    
    // MARK: - collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("\ntabbarplus controller collection view indexpath item:", indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LAXTabBarPlusControllerCell
        if indexPath.item < viewControllers.count {
            let vc = viewControllers[indexPath.item]
            vc.view.frame = collectionView.bounds
            cell.vc = vc
            cell.view = vc.view
            for v in cell.contentView.subviews {
                v.removeFromSuperview()
            }
            cell.contentView.addSubview((cell.view)!)
            addViewContraint(subView: cell.view!, superView: cell.contentView, constant: 0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewControllers[indexPath.item].viewWillAppear(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewControllers[indexPath.item].viewDidAppear(true)
    }
    
    // 拖拽collection view结束
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        self.selectedIndex = index
    }
    
}
