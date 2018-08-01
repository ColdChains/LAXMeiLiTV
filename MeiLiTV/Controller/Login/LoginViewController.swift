//
//  LoginViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/9.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - custum func
    

    //MARK: - IBAction
    @IBAction func registerAction(_ sender: UIButton) {
        LAXAnimation.lifangtiAnimation(with: LAXDirectionRight)
        let vc = RegisterViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func changePwdAction(_ sender: UIButton) {
        LAXAnimation.lifangtiAnimation(with: LAXDirectionRight)
        let vc = ChangePwdViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        LAXAnimation.bowenAnimation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
