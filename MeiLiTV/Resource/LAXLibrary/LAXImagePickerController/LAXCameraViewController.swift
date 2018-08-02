//
//  LAXCameraViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/1.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController = UIImagePickerController()
    var didFinishPickingBlock: ((_ image: UIImage?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.modalTransitionStyle = .flipHorizontal
        imagePickerController.allowsEditing = true
        showCamera()
    }
    
    func showCamera() {//UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            
//            imagePickerController.showsCameraControls=false
//            let myView = PlayerViewController().view
//            myView?.alpha = 0.9
//            self.imagePickerController.cameraOverlayView = myView
            
            self.show(imagePickerController, sender: nil)
        } else {
            let alert = UIAlertController.init(title: "提示", message: "没有检测到摄像头", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.show(alert, sender: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
//    
//    var imagePicker =  UIImagePickerController()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //检测相机是否可用
//        let isAvailable = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
//        //必须首先设置sourceType 然后再设置其他属性 否则会出异常，提示sourceType 必须是 UIImagePickerControllerSourceTypeCamera
//        imagePicker.sourceType = .photoLibrary
//        if isAvailable {
//            imagePicker.sourceType = .camera
//            //如果有前置摄像头则调用前置摄像头
//            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front
//            //是否显示控制栏
//            imagePicker.showsCameraControls=false
//            
//        }
//        //自定义相机界面
//        
////        if myView != nil{
////            myView?.imagePicker=imagePicker
////            myView?.frame = (imagePicker.cameraOverlayView?.frame)!
////            // imagePicker.cameraOverlayView=myView
////        }
//        
//        //代理
//        imagePicker.delegate = self
//        //打开相机
//        self.present(imagePicker, animated: true,  completion: {
//            let myView = PlayerViewController().view
//            myView?.alpha = 0.9
//            self.imagePicker.cameraOverlayView = myView
//        })
//        //是否可编辑
//        imagePicker.allowsEditing=false
//        
//    }
    
    func changeCamera() {
//        if 0 == 0 {
//            [UIView transitionWithView:self.imagePikerViewController.view duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionCurlDown animations:^{
//                self.imagePikerViewController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//                } completion:NULL];
//        }else{
//            [UIView transitionWithView:self.imagePikerViewController.view duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionCurlUp animations:^{
//                [self.imagePikerViewController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
//                } completion:NULL];
//        }
    }
    
    func takePhoto() {
        imagePickerController.takePicture()
    }

}
