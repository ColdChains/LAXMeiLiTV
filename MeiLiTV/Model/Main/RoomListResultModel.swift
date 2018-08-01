//
//  MainModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class RoomModel: BaseJSONModel {
    
    var avatar_mid: String?
    var avatar_small: String?
    var game_name: String?
    var jumpUrl: String?
    var nickname: String?
    var room_name: String?
    var room_src: String?
    var subject: String?
    var vertical_src: String?
    
    var cate_id: Int = 0
    var child_id: Int = 0
    var isVertical: Int = 0
    var online: Int = 0
    var owner_uid: Int = 0
    var ranktype: Int = 0
    var room_id: Int = 0
    var show_status: Int = 0
    var vod_quality: Int = 0
    
    var anchor_city: String?
    var game_url: String?
    var specific_catalog: String?
    var url: String?
    
    var fans: Int = 0
    var is_noble_rec: Int = 0
    var show_time: Int = 0
    var specific_status: Int = 0
    
}

class RoomListModel: BaseJSONModel {
    
    var icon_url: String?
    var push_vertical_screen: String?
    
    var tag_id: Int = 0
    var tag_name: String?
    
    var room_list: Array<RoomModel>?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let array = dict["room_list"] as? [Any];
        self.room_list = try RoomModel.arrayOfModels(fromDictionaries: array, error: ()) as? Array<RoomModel>
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: Data!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
}

class RoomListResultModel: BaseJSONModel {

    var error: Int?
    var data: Array<RoomListModel>?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let array = dict["data"] as? [Any];
        self.data = try RoomListModel.arrayOfModels(fromDictionaries: array, error: ()) as? Array<RoomListModel>
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
            "icon_url" = "";
            "push_vertical_screen" = "";
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/002/65/63/32_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/002/65/63/32_avatar_small.jpg";
                    "cate_id" = 1;
                    "child_id" = 32;
                    "game_name" = "\U82f1\U96c4\U8054\U76df";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5b8c\U7f8eOBAndy";
                    online = 184251;
                    "owner_uid" = 2656332;
                    ranktype = 0;
                    "room_id" = 79663;
                    "room_name" = "\U5b8c\U7f8eOB\Uff1a\U82b1\U751f/\U8d8a\U91ce/\U97e6\U795e/SKT";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/79663_170411085533.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868697;
                    "specific_catalog" = XYW;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/79663_170411085533.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201610/22/13/67d72ffdbcfd99ba0d0eab64b379a055_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201610/22/13/67d72ffdbcfd99ba0d0eab64b379a055_small.jpg";
                    "cate_id" = 1;
                    "child_id" = 34;
                    "game_name" = "\U82f1\U96c4\U8054\U76df";
                    "icon_data" =                     {
                        "icon_height" = 100;
                        "icon_url" = "https://staticlive.douyucdn.cn/upload/icon/c9b8db12cf33e90532525b05d6e9f294.png";
                        "icon_width" = 100;
                        status = 4;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U53eb\U6211\U4e45\U54e5\U54e5";
                    online = 107389;
                    "owner_uid" = 13165979;
                    ranktype = 0;
                    "room_id" = 271934;
                    "room_name" = "\U4e45\U54e5\Uff1a\U5047\U88c5\U6253\U4e0d\U8fc7\U662f\U4ec0\U4e48\Uff1f";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/271934_170411085844.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868859;
                    "specific_catalog" = skt9;
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/271934_170411085844.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201603/d6d0a88653f417a33e6182c514639ebb_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201603/d6d0a88653f417a33e6182c514639ebb_small.jpg";
                    "cate_id" = 181;
                    "child_id" = 224;
                    "game_name" = "\U738b\U8005\U8363\U8000";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5c0f\U5c0f\U9752\U86d9\U7b11i";
                    online = 89265;
                    "owner_uid" = 8930628;
                    ranktype = 0;
                    "room_id" = 573449;
                    "room_name" = "\U86d9\U795e\Uff1a 1\U62539 \U4f60\U61c2\U5417\Uff1f";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/573449_170411085844.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868826;
                    "specific_catalog" = wzrenzhichu;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/573449_170411085844.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/default/07_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/default/07_small.jpg";
                    "cate_id" = 215;
                    "child_id" = 215;
                    "game_name" = "\U8d22\U7ecf";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U897f\U85cf\U9ad8\U539f";
                    online = 1232;
                    "owner_uid" = 46699506;
                    ranktype = 0;
                    "room_id" = 734565;
                    "room_name" = "\U8d8b\U52bf\U4e3a\U738b\Uff0c\U9ad8\U629b\U4f4e\U5438";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/734565_170411085212.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871707;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/734565_170411085212.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = "";
            "tag_name" = "\U6700\U70ed";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/c35ddfc66e845e152ba49efb0abc74fb.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201611/05/14/30386abfb679b0e9faa289a014f34fad_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201611/05/14/30386abfb679b0e9faa289a014f34fad_small.jpg";
                    "cate_id" = 133;
                    "child_id" = 278;
                    "game_name" = "\U751f\U6d3b\U79c0";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5f20\U6d0bgg";
                    online = 1282;
                    "owner_uid" = 2274343;
                    ranktype = 0;
                    "room_id" = 534167;
                    "room_name" = "\U6597\U9c7c\U7b2c\U4e00\U5c0f\U4fdd\U5b89\Uff0c\U804a\U804a\U5457\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/534167_170411085836.jpg";
                    "show_status" = 1;
                    "show_time" = 1491870059;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/534167_170411085836.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201611/08/19/cfb7fb37464640a620b9e6d2ed14165a_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201611/08/19/cfb7fb37464640a620b9e6d2ed14165a_small.jpg";
                    "cate_id" = 133;
                    "child_id" = 278;
                    "game_name" = "\U751f\U6d3b\U79c0";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6002\U8d31\U82cf";
                    online = 1110;
                    "owner_uid" = 82272786;
                    ranktype = 0;
                    "room_id" = 1857484;
                    "room_name" = "\U5bb6\U5ead\U4e3b\U7537\U7684\U4e00\U5929";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/1857484_170411085825.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871660;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/1857484_170411085825.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/033/32/70/96_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/033/32/70/96_avatar_small.jpg";
                    "cate_id" = 133;
                    "child_id" = 249;
                    "game_name" = "\U751f\U6d3b\U79c0";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5ba0\U7269\U4fa6\U63a2\U793e";
                    online = 1081;
                    "owner_uid" = 33327096;
                    ranktype = 0;
                    "room_id" = 522070;
                    "room_name" = "\U96ea\U6a47\U72ac\U4e4b\U963f\U62c9\U65af\U52a0";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/522070_170411085230.jpg";
                    "show_status" = 1;
                    "show_time" = 1491869083;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/522070_170411085230.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201704/11/00/9c53c9038122b305422b4e72991fab86_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201704/11/00/9c53c9038122b305422b4e72991fab86_small.jpg";
                    "cate_id" = 133;
                    "child_id" = 249;
                    "game_name" = "\U751f\U6d3b\U79c0";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U8c22\U5e55\U540e\U7684\U96e8\U591c";
                    online = 1072;
                    "owner_uid" = 70034544;
                    ranktype = 0;
                    "room_id" = 1998176;
                    "room_name" = "\U8fb9\U683c\U72ac\U820d \U4e13\U4e1a\U8bad\U517b\U8fb9\U5883\U7267\U7f8a\U72ac CKU\U72ac\U820d";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/1998176_170411085911.jpg";
                    "show_status" = 1;
                    "show_time" = 1491799674;
                    "specific_catalog" = borcol;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/1998176_170411085911.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 133;
            "tag_name" = "\U751f\U6d3b\U79c0";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/26d993d79c1daa53d1b083980e97559e.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201703/29/19/f15a3b76c029142607076b0cd9adfe92_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201703/29/19/f15a3b76c029142607076b0cd9adfe92_small.jpg";
                    "cate_id" = 2;
                    "child_id" = 167;
                    "game_name" = "\U7089\U77f3\U4f20\U8bf4";
                    "icon_data" =                     {
                        "icon_height" = 100;
                        "icon_url" = "https://staticlive.douyucdn.cn/upload/icon/2163965fa417666a5baff307004b509d.png";
                        "icon_width" = 100;
                        status = 4;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5c0f\U5b89\U4e36666";
                    online = 14186;
                    "owner_uid" = 24495100;
                    ranktype = 0;
                    "room_id" = 415697;
                    "room_name" = "\U5c0f\U5b89\Uff1a\U4e0d\U5077\U4e0d\U62a2\U7684\U810f\U56fd\U738b\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/415697_170411085537.jpg";
                    "show_status" = 1;
                    "show_time" = 1491865987;
                    "specific_catalog" = xiaoan666;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/415697_170411085537.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/001/26/56/73_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/001/26/56/73_avatar_small.jpg";
                    "cate_id" = 2;
                    "child_id" = 167;
                    "game_name" = "\U7089\U77f3\U4f20\U8bf4";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U7089\U77f3\U4e36\U4ece\U96f6\U5f00\U59cb";
                    online = 6613;
                    "owner_uid" = 1265673;
                    ranktype = 0;
                    "room_id" = 59852;
                    "room_name" = "\U96f6\U54e5\Uff1a\U65b0\U7248\U6069\U4f50\U65af\U810f\U7267\U641e\U4e8b\U60c5";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/59852_170411085237.jpg";
                    "show_status" = 1;
                    "show_time" = 1491865266;
                    "specific_catalog" = clks;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/59852_170411085237.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201702/15/15/f5d6e1602e99c82b6d54c159afe00abb_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201702/15/15/f5d6e1602e99c82b6d54c159afe00abb_small.jpg";
                    "cate_id" = 2;
                    "child_id" = 167;
                    "game_name" = "\U7089\U77f3\U4f20\U8bf4";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = xkjipo1;
                    online = 2843;
                    "owner_uid" = 13548741;
                    ranktype = 0;
                    "room_id" = 261860;
                    "room_name" = "\U6708\U5f71\Uff1a\U5947\U8ff9\U8d3c\U767b\U9876";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/261860_170411085244.jpg";
                    "show_status" = 1;
                    "show_time" = 1491844762;
                    "specific_catalog" = yueyinggg;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/261860_170411085244.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201703/31/07/004d99c0e1dcea4e62556e4c19d3d659_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201703/31/07/004d99c0e1dcea4e62556e4c19d3d659_small.jpg";
                    "cate_id" = 2;
                    "child_id" = 155;
                    "game_name" = "\U7089\U77f3\U4f20\U8bf4";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U7f8e\U5982\U51a0\U7389\U7684\U6a58\U6e9c\U6e9c";
                    online = 2421;
                    "owner_uid" = 10070719;
                    ranktype = 0;
                    "room_id" = 640166;
                    "room_name" = "\U5c0f\U6a58\Uff1a\U4e00\U70b9\U4e00\U70b9\U7684\U8fc8\U5411\U9ad8\U80dc \U76ee\U680712\U3002";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/640166_170411085237.jpg";
                    "show_status" = 1;
                    "show_time" = 1491865358;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/640166_170411085237.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 2;
            "tag_name" = "\U7089\U77f3\U4f20\U8bf4";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/f719087663581b7a723c4d39f8721bc1.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201609/29/08/f0c579f5c6be82ad9d90647325fe1c8e_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201609/29/08/f0c579f5c6be82ad9d90647325fe1c8e_small.jpg";
                    "cate_id" = 181;
                    "child_id" = 12;
                    "game_name" = "\U738b\U8005\U8363\U8000";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U817f\U7530";
                    online = 15447;
                    "owner_uid" = 71932838;
                    ranktype = 0;
                    "room_id" = 1139455;
                    "room_name" = "\U7530\U59d0\U6392\U4f4d\U8d5b \U6c34\U53cb\U8d5b\U65f6\U95f4";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/1139455_170411085539.jpg";
                    "show_status" = 1;
                    "show_time" = 1491862176;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/1139455_170411085539.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201703/29/05/de395d9238ca2b0b1c2c0491e6d4080e_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201703/29/05/de395d9238ca2b0b1c2c0491e6d4080e_small.jpg";
                    "cate_id" = 181;
                    "child_id" = 468;
                    "game_name" = "\U738b\U8005\U8363\U8000";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U4e3b\U64ad\U9f99\U6770\U54e5\U54e5";
                    online = 10987;
                    "owner_uid" = 45829640;
                    ranktype = 0;
                    "room_id" = 644376;
                    "room_name" = "\U5144\U5f1f\U4eec\Uff0c\U8ba9\U4f60\U4eec\U4e45\U7b49\U4e86\Uff01\Uff01\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/644376_170411085211.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871866;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/644376_170411085211.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201704/06/18/fafba97110b261eed3aee73609e4d08d_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201704/06/18/fafba97110b261eed3aee73609e4d08d_small.jpg";
                    "cate_id" = 181;
                    "child_id" = 224;
                    "game_name" = "\U738b\U8005\U8363\U8000";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U7834\U76c6\U662f\U8fd9\U6837\U7834\U7684";
                    online = 13276;
                    "owner_uid" = 29432291;
                    ranktype = 0;
                    "room_id" = 1928445;
                    "room_name" = "\U7834\U76c6\Uff1a\U4e1c\U7687\U592a\U4e00\Uff0c1V5\U6700\U5f3a\U5766\U514b";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/1928445_170411085846.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868280;
                    "specific_catalog" = popen;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/1928445_170411085846.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201608/11/c137582d9e43200ef83bf025fdff1f94_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201608/11/c137582d9e43200ef83bf025fdff1f94_small.jpg";
                    "cate_id" = 181;
                    "child_id" = 12;
                    "game_name" = "\U738b\U8005\U8363\U8000";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U8001\U5b9e\U61a8\U539a\U7684\U6d9b\U54e5\U6d9b\U5f1f";
                    online = 6904;
                    "owner_uid" = 32231280;
                    ranktype = 0;
                    "room_id" = 506510;
                    "room_name" = "\U79c3\U9a74\U6d9b\Uff1a\U5c11\U6797\U5bfa\U7b2c\U4e00\U9ad8\U6e10\U79bb\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/506510_170411085223.jpg";
                    "show_status" = 1;
                    "show_time" = 1491870204;
                    "specific_catalog" = twotupiao;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/506510_170411085223.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 181;
            "tag_name" = "\U738b\U8005\U8363\U8000";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/d3e0073bfb714186ab0c818744601963.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201610/22/13/67d72ffdbcfd99ba0d0eab64b379a055_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201610/22/13/67d72ffdbcfd99ba0d0eab64b379a055_small.jpg";
                    "cate_id" = 1;
                    "child_id" = 34;
                    "game_name" = "\U82f1\U96c4\U8054\U76df";
                    "icon_data" =                     {
                        "icon_height" = 100;
                        "icon_url" = "https://staticlive.douyucdn.cn/upload/icon/c9b8db12cf33e90532525b05d6e9f294.png";
                        "icon_width" = 100;
                        status = 4;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U53eb\U6211\U4e45\U54e5\U54e5";
                    online = 107389;
                    "owner_uid" = 13165979;
                    ranktype = 0;
                    "room_id" = 271934;
                    "room_name" = "\U4e45\U54e5\Uff1a\U5047\U88c5\U6253\U4e0d\U8fc7\U662f\U4ec0\U4e48\Uff1f";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/271934_170411085844.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868859;
                    "specific_catalog" = skt9;
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/271934_170411085844.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201702/28/14/88845599399604a12a2f90b57b907423_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201702/28/14/88845599399604a12a2f90b57b907423_small.jpg";
                    "cate_id" = 1;
                    "child_id" = 36;
                    "game_name" = "\U82f1\U96c4\U8054\U76df";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U79c0\U79c0\U5927\U9b54\U738b\U4e36";
                    online = 10943;
                    "owner_uid" = 2342931;
                    ranktype = 0;
                    "room_id" = 68190;
                    "room_name" = "\U72ec\U521b\U98ce\U9a91VN\Uff1a\U97e9\U670d\U6392\U4f4d\U8d5b";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/68190_170411085534.jpg";
                    "show_status" = 1;
                    "show_time" = 1491867608;
                    "specific_catalog" = ShowVN;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/68190_170411085534.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201610/02/14/b0122fdd62fd3d493b025b82ed97fef6_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201610/02/14/b0122fdd62fd3d493b025b82ed97fef6_small.jpg";
                    "cate_id" = 1;
                    "child_id" = 33;
                    "game_name" = "\U82f1\U96c4\U8054\U76df";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6d6a\U6b7b\U7684\U706f\U706f";
                    online = 8052;
                    "owner_uid" = 43214745;
                    ranktype = 0;
                    "room_id" = 600290;
                    "room_name" = "\U4e16\U754c\U7b2c\U4e00\U8d75\U4fe1\Uff08\U5149\U901f\U8d70A\Uff09";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/600290_170411085247.jpg";
                    "show_status" = 1;
                    "show_time" = 1491833748;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/600290_170411085247.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201704/10/16/c7d4c1264a8db110675b90cad7747d3d_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201704/10/16/c7d4c1264a8db110675b90cad7747d3d_small.jpg";
                    "cate_id" = 1;
                    "child_id" = 168;
                    "game_name" = "\U82f1\U96c4\U8054\U76df";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U7ef4\U591a\U5229\U4e9a\U83f2\U513f";
                    online = 1728;
                    "owner_uid" = 60862643;
                    ranktype = 0;
                    "room_id" = 1469457;
                    "room_name" = "\U60a8\U7684\U7f51\U763e\U5c11\U5973\U5df2\U4e0a\U7ebf~";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/1469457_170411085821.jpg";
                    "show_status" = 1;
                    "show_time" = 1491872169;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/1469457_170411085821.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 1;
            "tag_name" = "\U82f1\U96c4\U8054\U76df";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/a887fa9dc9d6901b5fd5c86c8e169436.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/002/31/09/33_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/002/31/09/33_avatar_small.jpg";
                    "cate_id" = 3;
                    "child_id" = 94;
                    "game_name" = DOTA2;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U53eb\U6211\U8001\U9648\U5c31\U597d\U4e86";
                    online = 4054;
                    "owner_uid" = 2310933;
                    ranktype = 0;
                    "room_id" = 74960;
                    "room_name" = "\U963f\U5ddd\U7684\U76f4\U64ad\U95f4\Uff1a\U5927\U9003\U6740\Uff0c\U5e72\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/74960_170411085844.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868829;
                    "specific_catalog" = achuan;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/74960_170411085844.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201704/11/05/e4a42197a54dc856b888d1225564f830_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201704/11/05/e4a42197a54dc856b888d1225564f830_small.jpg";
                    "cate_id" = 3;
                    "child_id" = 175;
                    "game_name" = DOTA2;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6b64\U7537\U6709\U59bb\U8bf7\U52ff\U52fe\U5f15\U4e36";
                    online = 2523;
                    "owner_uid" = 6466852;
                    ranktype = 0;
                    "room_id" = 160179;
                    "room_name" = "\U93d6\U6218\U8944\U9633   \U4eca\U5929\U8981\U51cc\U66686\U70b9\U624d\U4e0b\U73ed";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/160179_170411085539.jpg";
                    "show_status" = 1;
                    "show_time" = 1491862796;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/160179_170411085539.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/013/26/35/64_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/013/26/35/64_avatar_small.jpg";
                    "cate_id" = 3;
                    "child_id" = 170;
                    "game_name" = DOTA2;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U767b\U5cf0\U5973\U738b";
                    online = 2350;
                    "owner_uid" = 13263564;
                    ranktype = 0;
                    "room_id" = 474266;
                    "room_name" = "TI\U7eaa\U5f55\U7247 ZSMJ YYF PIS";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/474266_170411085302.jpg";
                    "show_status" = 1;
                    "show_time" = 1491768971;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/474266_170411085302.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201609/07/e52c86850a87870238c222176a6fd1df_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201609/07/e52c86850a87870238c222176a6fd1df_small.jpg";
                    "cate_id" = 3;
                    "child_id" = 92;
                    "game_name" = DOTA2;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = painlc;
                    online = 2192;
                    "owner_uid" = 4815906;
                    ranktype = 0;
                    "room_id" = 572877;
                    "room_name" = "\U5361\U5361\U5361\U5361\U5361\U5c14\U3001invoker \U6211\U56de\U6765\U4e86";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/572877_170411085826.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871636;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/572877_170411085826.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 3;
            "tag_name" = DOTA2;
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/17dc1cd2164e3b50424ca0d9d80b2155.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/021/68/04/76_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/021/68/04/76_avatar_small.jpg";
                    "cate_id" = 148;
                    "child_id" = 189;
                    "game_name" = "\U5b88\U671b\U5148\U950b";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5b88\U671b\U4e36\U96e8\U5b63";
                    online = 5196;
                    "owner_uid" = 21680476;
                    ranktype = 0;
                    "room_id" = 491964;
                    "room_name" = "\U300e\U96e8\U5b63\U300f500\U5f3a76\U5e2e\U4e0a\U5206";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/491964_170411085911.jpg";
                    "show_status" = 1;
                    "show_time" = 1491800909;
                    "specific_catalog" = xiaoyuji;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/491964_170411085911.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201703/15/11/dcc4859aacdadd04038681afa04b52e7_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201703/15/11/dcc4859aacdadd04038681afa04b52e7_small.jpg";
                    "cate_id" = 148;
                    "child_id" = 310;
                    "game_name" = "\U5b88\U671b\U5148\U950b";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6c88\U6b32\U75af";
                    online = 4985;
                    "owner_uid" = 23359861;
                    ranktype = 0;
                    "room_id" = 978014;
                    "room_name" = "\U6c88\U6b32\U75af\Uff1a\U7528\U5c0f\U7f8e\U4e0a\U4e2a\U5b97\U5e08\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/978014_170411085535.jpg";
                    "show_status" = 1;
                    "show_time" = 1491866978;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/978014_170411085535.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201611/25/19/75dd55cc9ef3d7a4bb5f55cba09993e3_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201611/25/19/75dd55cc9ef3d7a4bb5f55cba09993e3_small.jpg";
                    "cate_id" = 148;
                    "child_id" = 310;
                    "game_name" = "\U5b88\U671b\U5148\U950b";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6cea\U7eb5\U80fd\U4e7e\U7ec8\U6709\U8ff9";
                    online = 2786;
                    "owner_uid" = 1418075;
                    ranktype = 0;
                    "room_id" = 115810;
                    "room_name" = "\U3010\U6cea\U7eb5\U3011\Uff1a\U73a9\U73a9\U5b88\U671b\Uff0c\U6253\U6253\U67aa\U706b\U3002";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/115810_170411085858.jpg";
                    "show_status" = 1;
                    "show_time" = 1491837810;
                    "specific_catalog" = leizong;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/115810_170411085858.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/default/09_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/default/09_small.jpg";
                    "cate_id" = 148;
                    "child_id" = 310;
                    "game_name" = "\U5b88\U671b\U5148\U950b";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U4e00\U4e2a\U6709\U68a6\U60f3\U7684\U6bdb";
                    online = 2657;
                    "owner_uid" = 33348193;
                    ranktype = 0;
                    "room_id" = 926405;
                    "room_name" = "\U3010\U7fbd\U6bdb\U3011\U70b8\U9c7c\U70b8\U9c7c \U89e3\U7b54\U5404\U79cd\U526fT\U6253\U6cd5";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/926405_170411085526.jpg";
                    "show_status" = 1;
                    "show_time" = 1491869843;
                    "specific_catalog" = yumaozz;
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/926405_170411085526.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 148;
            "tag_name" = "\U5b88\U671b\U5148\U950b";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/94691f7a259e7e85c4c65e5849cd94dc.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/default/05_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/default/05_small.jpg";
                    "cate_id" = 33;
                    "child_id" = 58;
                    "game_name" = "\U7a7f\U8d8a\U706b\U7ebf";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U7b71\U5c0f\U82e5\U6615";
                    online = 2439;
                    "owner_uid" = 82521827;
                    ranktype = 0;
                    "room_id" = 2006725;
                    "room_name" = "\U8fdb\U6765\U9886\U9650\U91cf\U7248\U738b\U8005\U4e4b\U5fc3\Uff0c\U8d76\U7d27\U7684";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/2006725_170411085211.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871808;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/2006725_170411085211.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201606/07/fbb063bf0582291ffbe814e7f6e78d8f_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201606/07/fbb063bf0582291ffbe814e7f6e78d8f_small.jpg";
                    "cate_id" = 33;
                    "child_id" = 55;
                    "game_name" = "\U7a7f\U8d8a\U706b\U7ebf";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U4e3b\U64ad\U8087\U5b87662412";
                    online = 2435;
                    "owner_uid" = 52046024;
                    ranktype = 0;
                    "room_id" = 662412;
                    "room_name" = "\U8087\U4e00\U53d1\Uff1a\U770b\U6211\U7684AK\U5427\U3002";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/662412_170411085825.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871670;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/662412_170411085825.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201701/15/14/1df8e6c50d839347afb8c22667c01907_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201701/15/14/1df8e6c50d839347afb8c22667c01907_small.jpg";
                    "cate_id" = 33;
                    "child_id" = 58;
                    "game_name" = "\U7a7f\U8d8a\U706b\U7ebf";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6a58\U865e\U521d\U68a6Shirley";
                    online = 2419;
                    "owner_uid" = 21101675;
                    ranktype = 0;
                    "room_id" = 489775;
                    "room_name" = "\U65e0\U6b32\U65e0\U6c42 \U966a\U7740\U6211\U5c31\U597d\U2764";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/489775_170411085833.jpg";
                    "show_status" = 1;
                    "show_time" = 1491870722;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/489775_170411085833.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/009/11/32/67_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/009/11/32/67_avatar_small.jpg";
                    "cate_id" = 33;
                    "child_id" = 54;
                    "game_name" = "\U7a7f\U8d8a\U706b\U7ebf";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = malinmate;
                    online = 2856;
                    "owner_uid" = 9113267;
                    ranktype = 0;
                    "room_id" = 201604;
                    "room_name" = "CF\U5ddd\U666e\U54e5 \U6765\U641e\U7b11\U7684";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/201604_170411085542.jpg";
                    "show_status" = 1;
                    "show_time" = 1491842982;
                    "specific_catalog" = tege;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/201604_170411085542.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 33;
            "tag_name" = "\U7a7f\U8d8a\U706b\U7ebf";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/180ac281ab3f980bbfdff366d9636072.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/001/17/11/83_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/001/17/11/83_avatar_small.jpg";
                    "cate_id" = 6;
                    "child_id" = 313;
                    "game_name" = "CS:GO";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U8d56\U5c0f\U5cf0";
                    online = 6571;
                    "owner_uid" = 1171183;
                    ranktype = 0;
                    "room_id" = 93936;
                    "room_name" = "\U3010\U535e\U5bb6\U519b\U3011\U6211\U56de\U6765\U5566~~";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/93936_170411085900.jpg";
                    "show_status" = 1;
                    "show_time" = 1491834622;
                    "specific_catalog" = tylooxf;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/93936_170411085900.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201603/8a23cd8d793088a049701781312ac9b2_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201603/8a23cd8d793088a049701781312ac9b2_small.jpg";
                    "cate_id" = 6;
                    "child_id" = 110;
                    "game_name" = "CS:GO";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "WCA2016\U7535\U5b50\U7ade\U6280\U5927\U8d5b";
                    online = 3102;
                    "owner_uid" = 13566725;
                    ranktype = 0;
                    "room_id" = 229131;
                    "room_name" = "WCA2017\U5168\U7403\U603b\U51b3\U8d5b\U4e2d\U56fd\U533a\U9884\U9009\U8d5b";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/229131_170411085923.jpg";
                    "show_status" = 1;
                    "show_time" = 1491026944;
                    "specific_catalog" = WCA2016;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/229131_170411085923.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201701/07/23/f8d4596bf733b1db0c2b83ef3502bab3_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201701/07/23/f8d4596bf733b1db0c2b83ef3502bab3_small.jpg";
                    "cate_id" = 6;
                    "child_id" = 106;
                    "game_name" = "CS:GO";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U66ae\U6f47\U6d12\U4e37";
                    online = 1372;
                    "owner_uid" = 9421701;
                    ranktype = 0;
                    "room_id" = 598997;
                    "room_name" = "\U66ae\U6f47\U6d12\U7684CSGO\U6210\U957f\U4e4b\U8def";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/598997_170411085238.jpg";
                    "show_status" = 1;
                    "show_time" = 1491864773;
                    "specific_catalog" = xiaosa70;
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/598997_170411085238.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/default/13_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/default/13_small.jpg";
                    "cate_id" = 6;
                    "child_id" = 108;
                    "game_name" = "CS:GO";
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = Jason9271;
                    online = 842;
                    "owner_uid" = 30596071;
                    ranktype = 0;
                    "room_id" = 495840;
                    "room_name" = "\U5f00\U8f66\Uff01\U6328\U63cd\U4e5f\U8981\U5f00\U8f66\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/495840_170411085855.jpg";
                    "show_status" = 1;
                    "show_time" = 1491846453;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/495840_170411085855.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 6;
            "tag_name" = "CS:GO";
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/fc05518ce228b8758c2f7928562382ed.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201612/15/07/ff3af5d21c0c6e5843565b4146653086_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201612/15/07/ff3af5d21c0c6e5843565b4146653086_small.jpg";
                    "cate_id" = 265;
                    "child_id" = 473;
                    "game_name" = H1Z1;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5609\U5b9d\U5440";
                    online = 3597;
                    "owner_uid" = 55965211;
                    ranktype = 0;
                    "room_id" = 749694;
                    "room_name" = "\U58f0\U4f18\U5609:\U987a\U4e30\U5feb\U9012\U8def\U4e0a\U7684\U4e00\U679a\U5409\U7965\U7269";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/749694_170411085844.jpg";
                    "show_status" = 1;
                    "show_time" = 1491868858;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/749694_170411085844.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201703/09/03/9ab64d3f2f550656b22986e83b30281a_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201703/09/03/9ab64d3f2f550656b22986e83b30281a_small.jpg";
                    "cate_id" = 265;
                    "child_id" = 473;
                    "game_name" = H1Z1;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U838e\U62c9\U9171\U4e36";
                    online = 3365;
                    "owner_uid" = 28390254;
                    ranktype = 0;
                    "room_id" = 472562;
                    "room_name" = "\U2764\U838e\U838e\U9171\U2764\U838e\U6c0f\U5feb\U9012\U6b63\U5e38\U8425\U4e1a\U4e2d~";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/472562_170411085222.jpg";
                    "show_status" = 1;
                    "show_time" = 1491870634;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/472562_170411085222.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201704/08/20/b4748764ae6ae521a8ed60d9bb679450_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201704/08/20/b4748764ae6ae521a8ed60d9bb679450_small.jpg";
                    "cate_id" = 265;
                    "child_id" = 474;
                    "game_name" = H1Z1;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U5b89\U82cf\U4e0d\U7f81\U9b42\U9a91";
                    online = 921;
                    "owner_uid" = 14743561;
                    ranktype = 0;
                    "room_id" = 555041;
                    "room_name" = "\U4e0d\U7f81 \U4eca\U5929\U505a886\U7687\U5bb6\U6218\U795e\U8fdb\U9636\U4efb\U52a1\Uff01\Uff01\Uff01";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/555041_170411085223.jpg";
                    "show_status" = 1;
                    "show_time" = 1491870274;
                    "specific_catalog" = BuJi;
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/555041_170411085223.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/002/50/29/99_avatar_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/002/50/29/99_avatar_small.jpg";
                    "cate_id" = 265;
                    "child_id" = 473;
                    "game_name" = H1Z1;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U8fd9\U4e2aID\U5f88\U6d41\U5f0a";
                    online = 44090;
                    "owner_uid" = 2502999;
                    ranktype = 0;
                    "room_id" = 99039;
                    "room_name" = "\U3010ID\U3011\U6211\U513f\U53db\U9006 \U4f24\U900f\U6211\U7684\U5fc3";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/99039_170411085236.jpg";
                    "show_status" = 1;
                    "show_time" = 1491865921;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/99039_170411085236.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 265;
            "tag_name" = H1Z1;
    },
        {
            "icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/0cd803160cfc26acfd0831dfe7b3de92.jpg";
            "push_vertical_screen" = 0;
            "room_list" =             (
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201610/22/08/39cef8a78980d1f82afb53f6f4fcc5a1_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201610/22/08/39cef8a78980d1f82afb53f6f4fcc5a1_small.jpg";
                    "cate_id" = 40;
                    "child_id" = 60;
                    "game_name" = DNF;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6770\U54e5\U52a9\U60a8\U5706\U68a6";
                    online = 5707;
                    "owner_uid" = 22883411;
                    ranktype = 0;
                    "room_id" = 323470;
                    "room_name" = "\U5df2\U51fa15\U628a\U5996\U5200,\U5f3a\U5316\U5929\U7a7a\U7f50\U5b50\U76d2\U5b50\U641e\U8d77";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/323470_170411085530.jpg";
                    "show_status" = 1;
                    "show_time" = 1491869346;
                    "specific_catalog" = ouhuangJOJO;
                    "specific_status" = 1;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/323470_170411085530.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201704/02/03/34669192c294d33a4b903cf91bd55a55_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201704/02/03/34669192c294d33a4b903cf91bd55a55_small.jpg";
                    "cate_id" = 40;
                    "child_id" = 59;
                    "game_name" = DNF;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U4f1a\U53d1\U5149\U7684\U695a\U715c";
                    online = 2539;
                    "owner_uid" = 30596023;
                    ranktype = 0;
                    "room_id" = 1888802;
                    "room_name" = "\U695a\U715c\Uff1a\U6df1\U6e0a\U6d3e\U5bf9\U5c0f\U738b\U5b50 \U4e13\U4e1a\U89e3\U6bd2\U5305\U6cbb\U767e\U75c5";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/1888802_170411085536.jpg";
                    "show_status" = 1;
                    "show_time" = 1491866518;
                    "specific_catalog" = daodaohenku;
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/1888802_170411085536.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avanew/face/201703/25/18/9107fef23f1de54477a5e48d753e1ab6_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avanew/face/201703/25/18/9107fef23f1de54477a5e48d753e1ab6_small.jpg";
                    "cate_id" = 40;
                    "child_id" = 59;
                    "game_name" = DNF;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U7d20\U7d20mm";
                    online = 884;
                    "owner_uid" = 22589486;
                    ranktype = 0;
                    "room_id" = 320900;
                    "room_name" = "\U2764\U65e5\U5e38\U505a\U586b\U7a7a\U9898";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/320900_170411085512.jpg";
                    "show_status" = 1;
                    "show_time" = 1491871850;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/320900_170411085512.jpg";
                    "vod_quality" = 0;
            },
                {
                    "avatar_mid" = "https://apic.douyucdn.cn/upload/avatar/face/201607/23/14e7135eed9eb1191aae2403cc69933c_middle.jpg";
                    "avatar_small" = "https://apic.douyucdn.cn/upload/avatar/face/201607/23/14e7135eed9eb1191aae2403cc69933c_small.jpg";
                    "cate_id" = 40;
                    "child_id" = 59;
                    "game_name" = DNF;
                    "icon_data" =                     {
                        "icon_height" = 0;
                        "icon_url" = "";
                        "icon_width" = 0;
                        status = 5;
                    };
                    isVertical = 0;
                    jumpUrl = "";
                    nickname = "\U6597\U9b5a\U4e36\U5c0f\U53ef";
                    online = 5343;
                    "owner_uid" = 6142003;
                    ranktype = 0;
                    "room_id" = 145201;
                    "room_name" = "\U5c0f\U53ef\Uff1a4\U7b491\U6211\U7684\U5929\U8981\U6bd5\U4e1a";
                    "room_src" = "https://rpic.douyucdn.cn/a1704/11/08/145201_170411085850.jpg";
                    "show_status" = 1;
                    "show_time" = 1491865573;
                    "specific_catalog" = "";
                    "specific_status" = 0;
                    subject = "";
                    "vertical_src" = "https://rpic.douyucdn.cn/a1704/11/08/145201_170411085850.jpg";
                    "vod_quality" = 0;
            }
            );
            "tag_id" = 40;
            "tag_name" = DNF;
    }
    );
    error = 0;
}
 */
