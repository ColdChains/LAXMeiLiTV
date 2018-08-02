//
//  LAXAlertView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/31.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation
import UIKit

class LAXAlertView {
    
    class func showAlertViewWarning(message: String?) -> UIAlertController {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }
    
    class func showAlertViewSelect(message: String?, selectOK: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let ok = UIAlertAction.init(title: "确定", style: .default) {(alert) in
            selectOK()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        return alert
    }
    
    class func showActionSheetSelect(title: String?, message: String?, one: String?, two: String?, selectone: @escaping () -> Void, selecttwo: @escaping () -> Void) -> UIAlertController {
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
        return sheet
    }
        
}
