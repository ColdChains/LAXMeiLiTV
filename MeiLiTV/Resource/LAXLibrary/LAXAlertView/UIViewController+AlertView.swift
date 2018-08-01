//
//  UIViewController+AlertView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/1.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertViewDefault(title: String?, message: String?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertViewWarning(message: String?) {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertViewSelect(message: String?, selectOK: @escaping () -> Void) {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let ok = UIAlertAction.init(title: "确定", style: .default) {(alert) in
            selectOK()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActionSheetSelect(title: String?, message: String?, one: String?, two: String?, selectone: @escaping () -> Void, selecttwo: @escaping () -> Void) {
        let sheet = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let action1 = UIAlertAction.init(title: one, style: .default) {(alert) in
            selectone()
        }
        let action2 = UIAlertAction.init(title: two, style: .default) {(alert) in
            selecttwo()
        }
        sheet.addAction(action1)
        sheet.addAction(action2)
        sheet.addAction(cancel)
        self.present(sheet, animated: true, completion: nil)
    }
    
}
