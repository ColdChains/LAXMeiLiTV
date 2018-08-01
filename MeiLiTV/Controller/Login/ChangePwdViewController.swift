//
//  ChangePwdViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/11.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class ChangePwdViewController: UIViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var okPwdTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        LAXAnimation.lifangtiAnimation(with: LAXDirectionLeft)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changeAction(_ sender: UIButton) {
        LAXAnimation.lifangtiAnimation(with: LAXDirectionRight)
        self.dismiss(animated: true, completion: nil)
    }
    
}
