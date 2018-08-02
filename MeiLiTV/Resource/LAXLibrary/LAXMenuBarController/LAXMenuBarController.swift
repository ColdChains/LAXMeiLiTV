//
//  PageScrollController.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/16.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit
/*
 * 给UIViewController扩展laxMenuBarController属性
 */
private var key: Void?
extension UIViewController {
    @IBInspectable var laxMenuBarController: LAXMenuBarController? {
        get {
            return objc_getAssociatedObject(self, &key) as? LAXMenuBarController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
/*
 * LAXMenuBarController CollectionViewCell
 */
class LAXMenuBarControllerCell: UICollectionViewCell {
    var vc: UIViewController?
    var view: UIView?
}
/*
 * LAXMenuBarController
 */
class LAXMenuBarController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LAXMenuBarDelegate {
    
    private let cellId = "LAXmenuBarControllerCell"
    private var collectionViewFrame = UIScreen.main.bounds
    
    var laxMenuBar: LAXMenuBar?
    // 当前选中的下标
    var selectedIndex = 0 {
        didSet {
            laxMenuBar?.selectedIndex = selectedIndex
            let x = collectionView.bounds.size.width * CGFloat(selectedIndex)
            collectionView.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
            collectionView.reloadData()
        }
    }
    // 所有要显示的视图控制器
    var viewControllers: [UIViewController] = [] {
        didSet {
            for vc in viewControllers {
                vc.laxMenuBarController = self
                self.addChildViewController(vc)
                vc.didMove(toParentViewController: self)
                
                if self.laxTabBarController != nil {
                    vc.laxTabBarController = self.laxTabBarController
                }
                if self.laxTabBarPlusController != nil {
                    vc.laxTabBarPlusController = self.laxTabBarPlusController
                }
            }
            collectionView.reloadData()
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
        self.navigationController?.navigationBar.isHidden = true
        
        reloadCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LAXMenuBarControllerCell.self, forCellWithReuseIdentifier: cellId)
        self.view.addSubview(collectionView)
        
        self.laxMenuBar = LAXMenuBar.init()
        self.laxMenuBar?.menuBarDelegate = self
        self.view.addSubview(self.laxMenuBar!)
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
                laxMenuBar?.width = rect.size.width
                laxMenuBar?.selectedIndex = selectedIndex
                
                if rect.width > rect.height {
                    laxMenuBar?.isHaveTop = false
                } else {
                    laxMenuBar?.isHaveTop = true
                }
                collectionViewFrame.size = rect.size
                reloadCollectionView()
                menuBarDidSelectItem(index: selectedIndex)
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
    
    // MARK: - tabBar delegate 通过下标设置显示的视图
    func menuBarDidSelectItem(index: Int) {
        self.selectedIndex = index
    }
    
    // MARK: - collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("\nmenubar controller collection view indexpath item:", indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LAXMenuBarControllerCell
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
    
    // 拖拽collection view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / collectionView.bounds.size.width)
        let offsetx = collectionView.contentOffset.x - collectionView.bounds.size.width * CGFloat(index)
        let wRate = offsetx / collectionView.bounds.size.width
        laxMenuBar?.setLineViewFrame(index: index, wRate: wRate)
    }
        
}
