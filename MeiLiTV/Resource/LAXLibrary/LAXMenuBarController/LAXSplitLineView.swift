//
//  SplitLineView.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/17.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

//分割线视图
class LAXSplitLineView: UIView {
    
    var x: CGFloat = 0 {
        didSet {
            var rect = self.frame
            rect.origin.x = x
            self.frame = rect
        }
    }
    
    var y: CGFloat = 0 {
        didSet {
            var rect = self.frame
            rect.origin.y = y
            self.frame = rect
        }
    }
    
    var width: CGFloat = 0 {
        didSet {
            var rect = self.frame
            rect.size.width = width
            self.frame = rect
        }
    }
    
    var height: CGFloat = 0 {
        didSet {
            var rect = self.frame
            rect.size.height = height
            self.frame = rect
        }
    }
    
    var lineColor: UIColor? {
        didSet {
            self.backgroundColor = lineColor
        }
    }
    
    init(y: CGFloat) {
        super.init(frame: CGRect.init(x: 0, y: y, width: UIScreen.main.bounds.width, height: 1))
        self.backgroundColor = UIColor.lightGray
    }
    
    init(color: UIColor) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        self.backgroundColor = color
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func defaultSplitLineView(y: CGFloat) -> UIView {
        let view = UIView.init(frame: CGRect.init(x: 0, y: y, width: UIScreen.main.bounds.width, height: 1))
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    class func getSplitLineView(frame: CGRect) -> UIView {
        let view = UIView.init(frame: frame)
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
}
