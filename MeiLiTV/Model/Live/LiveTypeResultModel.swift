//
//  LiveTypeResultModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/30.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveTypeModel: BaseJSONModel {
    
    var broadcast_limit: Int = 0
    var cate_id: Int = 0
    var count: Int = 0
    var count_ios: Int = 0
    
    var icon_name: String?
    var icon_url: String?
    var pic_name: String?
    var pic_name2: String?
    var pic_url: String?
    var pic_url2: String?
    
    var short_name: String?
    var small_icon_name: String?
    var small_icon_url: String?
    var tag_name: String?
    var url: String?
    
    var is_del: Int = 0
    var is_game_cate: Int = 0
    var is_relate: Int = 0
    var night_rank_score: Int = 0
    var nums: Int = 0
    var open_full_screen: Int = 0
    var orderdisplay: Int = 0
    
    var push_home: Int = 0
    var push_ios: Int = 0
    var push_nearby: Int = 0
    var push_qqapp: Int = 0
    var push_vertical_screen: Int = 0
    var rank_score: Int = 0
    var tag_id: Int = 0
    var vodd_cateids: Int = 0
    
}

class LiveTypeResultModel: BaseJSONModel {
    
    var error: Int?
    var data: Array<LiveTypeModel>?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let array = dict["data"] as? [Any];
        self.data = try LiveTypeModel.arrayOfModels(fromDictionaries: array, error: ()) as? Array<LiveTypeModel>
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
 "broadcast_limit" = 3;
 "cate_id" = 14;
 count = 395;
 "count_ios" = 345;
 "icon_name" = "f719087663581b7a723c4d39f8721bc1.jpg";
 "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/f719087663581b7a723c4d39f8721bc1.jpg";
 "is_del" = 0;
 "is_game_cate" = 1;
 "is_relate" = 1;
 "night_rank_score" = 0;
 nums = 0;
 "open_full_screen" = 0;
 orderdisplay = 2;
 "pic_name" = "b14b8890330ca7cb5185b954808485fc.jpg";
 "pic_name2" = "3b1ae2d3fb371c4ebc487cb9936c6603.jpg";
 "pic_url" = "https://staticlive.douyucdn.cn/upload/game_cate/b14b8890330ca7cb5185b954808485fc.jpg";
 "pic_url2" = "https://staticlive.douyucdn.cn/upload/game_cate/3b1ae2d3fb371c4ebc487cb9936c6603.jpg";
 "push_home" = 1;
 "push_ios" = 1;
 "push_nearby" = 0;
 "push_qqapp" = 1;
 "push_vertical_screen" = 0;
 "rank_score" = 0;
 "short_name" = wzry;
 "small_icon_name" = "bb9148fde757a69259f82b97aebd73af.png";
 "small_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/bb9148fde757a69259f82b97aebd73af.png";
 "tag_id" = 181;
 "tag_name" = "\U738b\U8005\U8363\U8000";
 url = "/directory/game/wzry";
 "vodd_cateids" = 22;
 },
 {
 "broadcast_limit" = 3;
 "cate_id" = 1;
 count = 1291;
 "count_ios" = 817;
 "icon_name" = "d3e0073bfb714186ab0c818744601963.jpg";
 "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/d3e0073bfb714186ab0c818744601963.jpg";
 "is_del" = 0;
 "is_game_cate" = 1;
 "is_relate" = 1;
 "night_rank_score" = 0;
 nums = 20346;
 "open_full_screen" = 0;
 orderdisplay = 5;
 "pic_name" = "c543faae97189c529c37b7741906d5a1.jpg";
 "pic_name2" = "19e443be45873d57b5a9a9a5bd0658f4.jpg";
 "pic_url" = "https://staticlive.douyucdn.cn/upload/game_cate/c543faae97189c529c37b7741906d5a1.jpg";
 "pic_url2" = "https://staticlive.douyucdn.cn/upload/game_cate/19e443be45873d57b5a9a9a5bd0658f4.jpg";
 "push_home" = 1;
 "push_ios" = 1;
 "push_nearby" = 0;
 "push_qqapp" = 1;
 "push_vertical_screen" = 0;
 "rank_score" = 0;
 "short_name" = LOL;
 "small_icon_name" = "";
 "small_icon_url" = "";
 "tag_id" = 1;
 "tag_name" = "\U82f1\U96c4\U8054\U76df";
 url = "/directory/game/LOL";
 "vodd_cateids" = "5,41";
 }
 );
 error = 0;
 }
 */
