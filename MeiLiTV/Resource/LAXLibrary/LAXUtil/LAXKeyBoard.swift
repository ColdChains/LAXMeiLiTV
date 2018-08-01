//
//  KeyBoard.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/31.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation
import UIKit

class LAXKeyBoard {
    
    static var object : Any!
    static var showKeyBoardBlock: ((_ height: CGFloat) -> Void)!
    static var hideKeyBoardBlock: ((_ height: CGFloat) -> Void)!
    
    class func addKeyBoardNotification(object: Any, showKeyBoardBlock: @escaping (_ height: CGFloat) -> Void, hideKeyBoardBlock: @escaping (_ height: CGFloat) -> Void) {
        self.object = object
        self.showKeyBoardBlock = showKeyBoardBlock
        self.hideKeyBoardBlock = hideKeyBoardBlock
        
        NotificationCenter.default.addObserver(object, selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(object, selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc class func keyBoardWillShow(notification: Notification) {
        if let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]) as? CGRect {
            UIView.animate(withDuration: 0.25, animations: {
                showKeyBoardBlock(rect.height)
            })
        }
    }
    
    @objc class func keyBoardWillHide(notification: Notification) {
        if let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]) as? CGRect {
            UIView.animate(withDuration: 0.25, animations: {
                hideKeyBoardBlock(rect.height)
            })
        }
    }
    
 
}
