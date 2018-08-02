//
//  MyselfCollectionViewCell.swift
//  LAXLvMaMa
//
//  Created by 冰凉的枷锁 on 2016/10/20.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

class MineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var model: MineModel? {
        didSet {
            self.nameLabel.text = model?.title
            if let str = model?.image_placeholder {
                self.headImageView.image = UIImage.init(named: str)
            }
            if let str = model?.image_url {
                self.headImageView.sd_setImage(with: URL.init(string: str), placeholderImage: UIImage.init(named: Image_Placeholder))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
