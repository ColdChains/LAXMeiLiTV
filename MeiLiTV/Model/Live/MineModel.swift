//
//  MyselfModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MineModel: BaseJSONModel {

    var title: String?
    var image_placeholder: String?
    var image_url: String?
    
    init(title: String, image: String) {
        super.init()
        self.title = title
        self.image_placeholder = image
    }
    
    required init(data: Data!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        fatalError("init(dictionary:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
