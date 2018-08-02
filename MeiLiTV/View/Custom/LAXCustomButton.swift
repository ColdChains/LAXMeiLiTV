//
//  LAXBlueButton.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LAXCustomButton: UIButton {
    
    var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        
    }

}
