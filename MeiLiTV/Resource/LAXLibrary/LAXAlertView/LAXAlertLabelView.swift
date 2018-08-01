//
//  LAXAlertLabelView.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/21.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

extension UIResponder {
    func showAlertLabelView(message: String) {
        if let window = UIApplication.shared.windows.first {
            window.addSubview(UILabel.defaultAlertLabelAtDown(message: message))
        }
    }
}

extension UILabel {
    class func defaultAlertLabelAtDown(message: String) -> UILabel {
        let label = LAXAlertLabelView.init(y: UIScreen.main.bounds.height / 5 * 4, message: message)
        return label
    }
    class func defaultAlertLabel(message: String) -> UILabel {
        let label = LAXAlertLabelView.init(message: message)
        return label
    }
}

class LAXAlertLabelView: UILabel {
    
    init(y: CGFloat, message: String) {
        
        var rect = message.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width - 20, height: 100), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil)
        
        rect.size.width += 40
        rect.size.height += 10
        rect.origin.x = (UIScreen.main.bounds.width - rect.width) / 2
        rect.origin.y = y
        
        super.init(frame: rect)
        self.backgroundColor = UIColor.init(white: 0.8, alpha: 0.7)
        self.text = message
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 15)
        self.layer.cornerRadius = rect.height / 2
        self.layer.masksToBounds = true
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.ttt), userInfo: nil, repeats: false)
        
    }
    
    init(message: String) {
        
        var rect = message.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width - 20, height: 100), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil)
        
        rect.size.width += 30
        rect.size.height += 10
        rect.origin.x = (UIScreen.main.bounds.width - rect.width) / 2
        rect.origin.y = UIScreen.main.bounds.height / 2
        
        super.init(frame: rect)
        self.backgroundColor = UIColor.init(white: 0.8, alpha: 0.7)
        self.text = message
        self.textAlignment = .center
        self.layer.cornerRadius = rect.height / 2
        self.layer.masksToBounds = true
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.ttt), userInfo: nil, repeats: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ttt() {
        self.removeFromSuperview()
    }
    
}
