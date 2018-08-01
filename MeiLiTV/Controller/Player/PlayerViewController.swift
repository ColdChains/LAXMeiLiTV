//
//  PlayerViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/15.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class PlayerViewController: LAXImagePickerController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: LAXTextView!
    
    var manager: LAXLocationManager = LAXLocationManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化登录
        if !LiveDemoManager.isLogin {
            LiveDemoManager.initUser()
        }
        
        didFinishPickingBlock = { (image) in
            self.imageView.image = image
        }
        
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
        manager.getLocation(success: { (str) in
            self.locationLabel.text = str
        }) { (str) in
            self.showAlertViewWarning(message: str)
        }
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
    }
    
    @IBAction func returnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeImageAction(_ sender: UIButton) {
        showImagePickerController()
    }
    
    @IBAction func startLiveAction(_ sender: UIButton) {
        
        if self.textView.text == "" {
            self.showAlertLabelView(message: "请输入标题")
            return
        }
        // 开始直播
//        let vc = TCPushSettingViewController()
//        vc.titleTextView.text = self.textView.text
//        vc.coverImageView.image = self.imageView.image
//        vc.locationLabel.text = self.locationLabel.text
//        vc.startPush()
        
    }

}
