//
//  LiveListResultModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/30.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveListModel: BaseJSONModel {
    
}

class LiveListResultModel: BaseJSONModel {
    
    var error: Int?
    var data: Array<RoomModel>?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let array = dict["data"] as? [Any];
        self.data = try RoomModel.arrayOfModels(fromDictionaries: array, error: ()) as? Array<RoomModel>
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
 "anchor_city" = "";
 avatar = "https://apic.douyucdn.cn/upload/avanew/face/201701/21/23/38e9296f121384e5b7f6a260ea938c8d_big.jpg";
 "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201701/21/23/38e9296f121384e5b7f6a260ea938c8d_middle.jpg";
 "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201701/21/23/38e9296f121384e5b7f6a260ea938c8d_small.jpg";
 "cate_id" = 260;
 "child_id" = 433;
 fans = 97170;
 "game_name" = "\U5929\U5929\U72fc\U4eba\U6740";
 "game_url" = "/directory/game/werewolf";
 isVertical = 0;
 "is_noble_rec" = 0;
 jumpUrl = "";
 nickname = "\U6076\U9b54\U7b14\U8c03";
 online = 72682;
 "owner_uid" = 56717566;
 ranktype = 3;
 "room_id" = 1647060;
 "room_name" = "\U7b14\U8c03\Uff1a\U9c7c\U5858\U91cc\U9762\U6478\U722c\U6eda\U6253\Uff01";
 "room_src" = "https://rpic.douyucdn.cn/a1704/30/11/1647060_170430114345.jpg";
 "show_status" = 1;
 "show_time" = 1493516632;
 "specific_catalog" = "";
 "specific_status" = 0;
 subject = "";
 url = "/1647060";
 "vertical_src" = "https://rpic.douyucdn.cn/a1704/30/11/1647060_170430114345.jpg";
 "vod_quality" = 0;
 },
 {
 "anchor_city" = "";
 avatar = "https://apic.douyucdn.cn/upload/avatar/face/201606/29/c87d6d97042f0ed77893ff06fb829879_big.jpg";
 "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201606/29/c87d6d97042f0ed77893ff06fb829879_middle.jpg";
 "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201606/29/c87d6d97042f0ed77893ff06fb829879_small.jpg";
 "cate_id" = 260;
 "child_id" = 433;
 fans = 106299;
 "game_name" = "\U5929\U5929\U72fc\U4eba\U6740";
 "game_url" = "/directory/game/werewolf";
 isVertical = 0;
 "is_noble_rec" = 0;
 jumpUrl = "";
 nickname = "\U8bf7\U53eb\U6211\U9017B\U8001\U4e8e";
 online = 50547;
 "owner_uid" = 367253;
 ranktype = 0;
 "room_id" = 15177;
 "room_name" = "\U8001\U4e8e\Uff1a\U8fd8\U662f\U4f605\U53f7\U4f1a\U73a9\Uff1f\U54c8\U54c8\U54c8\Uff01";
 "room_src" = "https://rpic.douyucdn.cn/a1704/30/11/15177_170430114328.jpg";
 "show_status" = 1;
 "show_time" = 1493519775;
 "specific_catalog" = "";
 "specific_status" = 0;
 subject = "";
 url = "/15177";
 "vertical_src" = "https://rpic.douyucdn.cn/a1704/30/11/15177_170430114328.jpg";
 "vod_quality" = 0;
 }
 );
 error = 0;
 }
 */
