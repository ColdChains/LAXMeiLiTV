//
//  LiveMenuResultModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveMenuModel: BaseJSONModel {
    
    var cate_id: Int = 0
    var cate_name: String?
    var push_ios: Int = 0
    var push_nearby: Int = 0
    var push_show: Int = 0
    var push_vertical_screen: Int = 0
    var short_name: String?
    
}

class LiveMenuResultModel: BaseJSONModel {
    
    var error: Int?
    var data: Array<LiveMenuModel>?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let array = dict["data"] as? [Any];
        self.data = try LiveMenuModel.arrayOfModels(fromDictionaries: array, error: ()) as? Array<LiveMenuModel>
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: Data!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
}
/*
{
    data =     (
        {
            "cate_id" = 1;
            "cate_name" = "\U70ed\U95e8\U6e38\U620f";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = game;
    },
        {
            "cate_id" = 14;
            "cate_name" = "\U738b\U8005\U8363\U8000";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = wzry;
    },
        {
            "cate_id" = 15;
            "cate_name" = "\U5ba2\U5385\U6e38\U620f";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = ktyx;
    },
        {
            "cate_id" = 9;
            "cate_name" = "\U79fb\U52a8\U6e38\U620f";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = ydyx;
    },
        {
            "cate_id" = 2;
            "cate_name" = "\U9c7c\U4e50\U661f\U5929\U5730";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = ylxtd;
    },
        {
            "cate_id" = 8;
            "cate_name" = "\U989c\U503c";
            "push_ios" = 1;
            "push_nearby" = 1;
            "push_show" = 0;
            "push_vertical_screen" = 1;
            "short_name" = yz;
    },
        {
            "cate_id" = 3;
            "cate_name" = "\U79d1\U6280";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = kj;
    },
        {
            "cate_id" = 11;
            "cate_name" = "\U6587\U5a31\U8bfe\U5802";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = wykt;
    },
        {
            "cate_id" = 13;
            "cate_name" = "\U6b63\U80fd\U91cf";
            "push_ios" = 1;
            "push_nearby" = 0;
            "push_show" = 0;
            "push_vertical_screen" = 0;
            "short_name" = znl;
    }
    );
    error = 0;
}
 */
