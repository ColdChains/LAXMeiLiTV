//
//  LiveLoadingView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/5/22.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveLoadingView: UIView {
    
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadingViewStartLoading() {
        self.isHidden = false
        loadingLabel.text = "加载中..."
        // 加载动画
        loadingImageView.animationImages = [UIImage.init(named: "image_loading_player01")!, UIImage.init(named: "image_loading_player02")!, UIImage.init(named: "image_loading_player03")!]
        loadingImageView.animationDuration = 1;
        loadingImageView.startAnimating()
    }
    
    func loadingViewEndLoading() {
        self.isHidden = true
        loadingImageView.stopAnimating()
    }
    
    func loadingViewFailed() {
        self.isHidden = true
        loadingLabel.text = "加载失败"
        loadingImageView.stopAnimating()
        loadingImageView.image = UIImage.init(named: "image_loading_failed")
    }
    
}
