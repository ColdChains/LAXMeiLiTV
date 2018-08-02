//
//  MainCollectionViewCell.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/2.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onLineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: RoomModel? {
        didSet {
            titleLabel.text = model?.room_name
            nameLabel.text = model?.nickname
            
            if let online = model?.online {
                if online >= 10000 {
                    onLineLabel.text = String.init(format: "%.1f万", Float(online) / 10000.0)
                } else {
                    onLineLabel.text = String.init(format: "%ld", online)
                }
            }
            
            if let str = model?.room_src {
                headImageView.sd_setImage(with: URL.init(string: str), placeholderImage: UIImage.init(named: Image_Placeholder_Rect))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
