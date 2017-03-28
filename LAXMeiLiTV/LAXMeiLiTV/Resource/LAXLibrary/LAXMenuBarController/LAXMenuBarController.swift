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
    @IBInspectable var laxMenuBarController: LAXMenuBarController? {
        get {
            return objc_getAssociatedObject(self, &key) as? LAXMenuBarController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class LAXMenuBarControllerCell: UICollectionViewCell {
    var vc: UIViewController?
    var view: UIView?
}

class LAXMenuBarController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LAXMenuBarDelegate {
    
    private let cellId = "LAXmenuBarControllerCell"
    private var offSetY: CGFloat = 0
    
    var laxMenuBar: LAXMenuBar?
    
    var selectedIndex = 0
    
    var viewControllers: [UIViewController] = [] {
        didSet {
            for vc in viewControllers {
                vc.laxMenuBarController = self
            }
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
        
        collectionView.backgroundColor = UIColor.lightGray
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
        
        reloadCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LAXMenuBarControllerCell.self, forCellWithReuseIdentifier: cellId)
        
        self.laxMenuBar = LAXMenuBar.init()
        self.laxMenuBar?.menuBarDelegate = self
        self.view.addSubview(self.laxMenuBar!)
        //添加观察者
        self.view.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //屏幕旋转 重新设置frame
        if keyPath == "frame" {
            if let rect = change?[.newKey] as? CGRect {
                laxMenuBar?.width = rect.size.width
                offSetY = rect.size.width > rect.size.height ? -20 : 0
                laxMenuBar?.frame = CGRect.init(x: 0, y: offSetY, width: rect.size.width, height: 64)
                reloadCollectionView()
                _ = collectionView(collectionView, cellForItemAt: IndexPath.init(item: selectedIndex, section: 0))
                menuBarDidSelectItem(index: selectedIndex)
            }
        }
    }
    
    func reloadCollectionView() {
        collectionView.removeFromSuperview()
        var frame = self.view.bounds
        frame.origin.y = 64 + offSetY
        frame.size.height -= 64 + offSetY
        collectionView.frame = frame
        self.view.addSubview(collectionView)
        self.view.sendSubview(toBack: collectionView)
        collectionView.reloadData()
    }
    
    //添加约束
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
    
    //通过下标设置显示的视图
    func setSelectedViewController(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        let x = collectionView.bounds.size.width * CGFloat(selectedIndex)
        collectionView.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
    }
    
    //MARK: - tabBar delegate
    func menuBarDidSelectItem(index: Int) {
        print(index)
        setSelectedViewController(selectedIndex: index)
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
            cell.view?.removeFromSuperview()
            cell.view = vc.view
            cell.contentView.addSubview((cell.view)!)
            addViewContraint(subView: cell.view!, superView: cell.contentView, constant: 0)
        }
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
        laxMenuBar?.selectedIndex = index
    }
    
}
