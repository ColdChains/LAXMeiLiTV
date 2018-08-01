//
//  LoginView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/19.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LoginView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func closeAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.alpha = 0
        }) { (b) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func weixinAction(_ sender: UIButton) {
        
    }
    
    @IBAction func qqAction(_ sender: UIButton) {
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
    }
    
}
