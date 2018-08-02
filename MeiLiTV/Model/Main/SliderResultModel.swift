//
//  MainSliderModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/13.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation

class SliderModel: BaseJSONModel {
    
    var id = 0
    var title: String?
    var pic_url: String?
    var tv_pic_url: String?
    
    var room: RoomModel?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let dic = dict["room"] as? [String: Any];
        self.room = try RoomModel.init(dictionary: dic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: Data!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
}

class SliderResultModel: BaseJSONModel {
    
    var data: Array<SliderModel>?
    var error: Int?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let array = dict["data"] as? [Any];
        self.data = try SliderModel.arrayOfModels(fromDictionaries: array, error: ()) as? Array<SliderModel>
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
            id = 916519;
            "pic_url" = "https://staticlive.douyucdn.cn/upload/signs/2017041310431510000.jpg";
            room =             {
                "cate_id" = 136;
                "cate_limit" =                 {
                    "limit_num" = 0;
                    "limit_threshold" = 0;
                    "limit_time" = 0;
                    "limit_type" = 0;
                };
                cdnsWithName =                 (
                    {
                        cdn = ws;
                        name = "\U4e3b\U7ebf\U8def";
                },
                    {
                        cdn = tct;
                        name = "\U5907\U7528\U7ebf\U8def5";
                },
                    {
                        cdn = ws2;
                        name = "\U5907\U7528\U7ebf\U8def2";
                },
                    {
                        cdn = dl;
                        name = "\U5907\U7528\U7ebf\U8def3";
                }
                );
                "column_id" = 3;
                "credit_illegal" = 0;
                "cur_credit" = 12;
                fans = 22665;
                "game_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/b78528a4925fe48077c88ed433deeaf8.jpg";
                "game_name" = "\U6c7d\U8f66";
                "game_url" = "/directory/game/car";
                isVertical = 0;
                "is_pass_player" = 0;
                "is_white_list" = 0;
                "low_credit" = 4;
                nickname = "\U86d9\U8d5blive";
                online = 11023;
                "open_full_screen" = 0;
                "owner_avatar" = "https://apic.douyucdn.cn/upload/avatar/face/201609/06/e5f6c61ce7811122aa76697e34520d5b_big.jpg?rltime";
                "owner_uid" = 45660659;
                "owner_weight" = "36.4kg";
                "room_id" = 916519;
                "room_name" = "\U63ed\U79d8ChinaGT\U4e2d\U56fd\U8d85\U7ea7\U8dd1\U8f66\U9526\U6807\U8d5b";
                "room_src" = "https://rpic.douyucdn.cn/a1704/13/11/916519_170413114008.jpg";
                "show_details" = "\U559c\U6b22\U901f\U5ea6\U4e0e\U6fc0\U60c5 \U5c31\U4e0e\U6211\U4e00\U8d77\U4e0a \U6b22\U8fce\U5173\U6ce8\U516c\U4f17\U53f7\U86d9\U8d5blive ,\U7c89\U4e1d\U8bf7\U52a0QQ\U7fa4\Uff1a472903478";
                "show_status" = 1;
                "show_time" = 1492048291;
                "specific_catalog" = wasailive;
                "specific_status" = 1;
                url = "/wasailive";
                "vertical_src" = "https://rpic.douyucdn.cn/a1704/13/11/916519_170413114008.jpg";
                "vod_quality" = 0;
            };
            title = "\U5c0f\U59d0\U59d0\U5e26\U4f60\U901bChina GT";
            "tv_pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704131043145513.jpg";
    },
        {
            id = 50485;
            "pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704071637129696.jpg";
            room =             {
                "cate_id" = 19;
                "cate_limit" =                 {
                    "limit_num" = 0;
                    "limit_threshold" = 0;
                    "limit_time" = 0;
                    "limit_type" = 0;
                };
                cdnsWithName =                 (
                    {
                        cdn = ws;
                        name = "\U4e3b\U7ebf\U8def";
                },
                    {
                        cdn = tct;
                        name = "\U5907\U7528\U7ebf\U8def5";
                },
                    {
                        cdn = ws2;
                        name = "\U5907\U7528\U7ebf\U8def2";
                },
                    {
                        cdn = dl;
                        name = "\U5907\U7528\U7ebf\U8def3";
                }
                );
                "column_id" = 15;
                "credit_illegal" = 0;
                "cur_credit" = 12;
                fans = 37383;
                "game_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/602c38f19a4fe9af40fdb64a00ce9ed5.jpg";
                "game_name" = "\U4e3b\U673a\U6e38\U620f";
                "game_url" = "/directory/game/TVgame";
                isVertical = 0;
                "is_high_game" = 1;
                "is_pass_player" = 0;
                "is_white_list" = 0;
                "low_credit" = 4;
                nickname = "\U80d6\U54e5Viper";
                online = 2652;
                "open_full_screen" = 0;
                "owner_avatar" = "https://apic.douyucdn.cn/upload/avanew/face/201611/28/10/1c99157252a645ae650a624d1b9d60f2_big.jpg?rltime";
                "owner_uid" = 1106809;
                "owner_weight" = "14.88t";
                "room_id" = 50485;
                "room_name" = "\U80d6\U54e5Viper\Uff0c\U9a91\U780d\U4e09\U56fd\U51b3\U6218\U8346\U5dde\U767e\U56e2\U5927\U6218";
                "room_src" = "https://rpic.douyucdn.cn/a1704/13/11/50485_170413114006.jpg";
                "show_details" = "\U76f4\U64ad\U65f6\U95f4\Uff1a\U65e9\U666810\U70b9\U201414\U70b9\Uff0c\U508d\U665a18\U70b9\U201422\U70b9\U3002 2016\U5e7412\U670810\U65e5\U8fbe\U6210\U6bcf\U5929\U76f4\U64ad8\U5c0f\U65f6\U8fde\U7eed389\U5929\U7684\U6210\U5c31\U3002\U3010\U98ce\U8463\U3011\U76f4\U64ad\U95f4\Uff1a555400 \U3002QQ4\U7fa4\Uff1a603308046\U3002\U30021,2,3\U7fa4\U90fd\U6ee1\U7684\U4e0d\U884c\U4e86\Uff0c\U6709\U7a7a\U4f4d\U518d\U5199\U51fa\U6765\U3002";
                "show_status" = 1;
                "show_time" = 1492049368;
                "specific_catalog" = Viper;
                "specific_status" = 1;
                url = "/Viper";
                "vertical_src" = "https://rpic.douyucdn.cn/a1704/13/11/50485_170413114006.jpg";
                "vod_quality" = 0;
            };
            title = "\U80d6\U54e5\U7684\U6e38\U620f\U65f6\U95f4";
            "tv_pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704071637151713.jpg";
    },
        {
            id = 996664;
            "pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201703071406132170.jpg";
            room =             {
                "cate_id" = 195;
                "cate_limit" =                 {
                    "limit_num" = 0;
                    "limit_threshold" = 0;
                    "limit_time" = 30;
                    "limit_type" = 0;
                };
                cdnsWithName =                 (
                    {
                        cdn = ws;
                        name = "\U4e3b\U7ebf\U8def";
                },
                    {
                        cdn = tct;
                        name = "\U5907\U7528\U7ebf\U8def5";
                },
                    {
                        cdn = ws2;
                        name = "\U5907\U7528\U7ebf\U8def2";
                },
                    {
                        cdn = dl;
                        name = "\U5907\U7528\U7ebf\U8def3";
                }
                );
                "column_id" = 11;
                "credit_illegal" = 0;
                "cur_credit" = 12;
                fans = 58409;
                "game_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/ac9e22d6b80cb57b878e6fa3cca15400.jpg";
                "game_name" = "\U9c7c\U6559";
                "game_url" = "/directory/game/yj";
                isVertical = 0;
                "is_pass_player" = 0;
                "is_white_list" = 0;
                "low_credit" = 4;
                nickname = "\U8c4c\U8c46yuki\U9171";
                online = 6708;
                "open_full_screen" = 0;
                "owner_avatar" = "https://apic.douyucdn.cn/upload/avanew/face/201703/18/20/5e35fefdac438a65490565ae6cfd722a_big.jpg?rltime";
                "owner_uid" = 59330162;
                "owner_weight" = "7.18t";
                "room_id" = 996664;
                "room_name" = "yuki\U306e\U65e5\U672c\U8a9e:\U4f60\U5f00\U5fc3\U5c31\U597d\Uff5e";
                "room_src" = "https://rpic.douyucdn.cn/a1704/13/11/996664_170413114007.jpg";
                "show_details" = "\U5fae\U535a\Uff1a\U8c4c\U8c46yuki\U917166\n\U4e0a\U534810\U70b9\U523012\U70b9\U534a\U76f4\U64ad   \U65e5\U8bed\U5b66\U4e60\U5206\U4eab  \nQQ\U7fa4\U2014\U2014yuki\U7ec4\U7fa4\Uff1a566307909 \Uff08\U6ee1\Uff09yuki\U7ec4\U5b66\U4e602\U90e8:207356339  yuki\U7ec4\U5b66\U4e601\U90e8\Uff1a91896020 \n\U98de\U673a\U00d72\Uff1d\U623f\U7ba1";
                "show_status" = 1;
                "show_time" = 1492049051;
                "specific_catalog" = "";
                "specific_status" = 0;
                url = "/996664";
                "vertical_src" = "https://rpic.douyucdn.cn/a1704/13/11/996664_170413114007.jpg";
                "vod_quality" = 0;
            };
            title = "\U53ee\U549a~yuki\U9171\U5f00\U8bfe";
            "tv_pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201703071406148410.jpg";
    },
        {
            id = 261950;
            "pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704052030234123.jpg";
            room =             {
                "cate_id" = 6;
                "cate_limit" =                 {
                    "limit_num" = 0;
                    "limit_threshold" = 0;
                    "limit_time" = 0;
                    "limit_type" = 0;
                };
                cdnsWithName =                 (
                    {
                        cdn = ws;
                        name = "\U4e3b\U7ebf\U8def";
                },
                    {
                        cdn = tct;
                        name = "\U5907\U7528\U7ebf\U8def5";
                },
                    {
                        cdn = ws2;
                        name = "\U5907\U7528\U7ebf\U8def2";
                },
                    {
                        cdn = dl;
                        name = "\U5907\U7528\U7ebf\U8def3";
                }
                );
                "column_id" = 1;
                "credit_illegal" = 0;
                "cur_credit" = 12;
                fans = 47658;
                "game_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/180ac281ab3f980bbfdff366d9636072.jpg";
                "game_name" = "CS:GO";
                "game_url" = "/directory/game/CSGO";
                isVertical = 0;
                "is_pass_player" = 0;
                "is_white_list" = 0;
                "low_credit" = 4;
                nickname = "SSVT\U4e36\U5c0f\U67d2";
                online = 3232;
                "open_full_screen" = 0;
                "owner_avatar" = "https://apic.douyucdn.cn/upload/avatar/face/201608/05/b600d28dcb8f3eea2b7f86f5e03b8cc5_big.jpg?rltime";
                "owner_uid" = 2073363;
                "owner_weight" = "4.17t";
                "room_id" = 261950;
                "room_name" = "\U3010\U5c0f\U67d2\U3011EPL  \U7f8e\U6d32\U533a\Uff08\U539f\U753b\Uff09";
                "room_src" = "https://rpic.douyucdn.cn/a1704/13/11/261950_170413114030.jpg";
                "show_details" = "\U5b8c\U7f8e\U4e16\U754c\U5b98\U65b9\U4e3b\U64ad\Uff01\U4eca\U65e5\U4e0a\U8f66\U8fde\U63a5\Uff1a\U6c34\U53cb\U7fa4\Uff1a 578194687\Uff01 \U4e00\U5207\U6d3b\U52a8\U5c3d\U5728\U7fa4\U5185\Uff0c\U60f3\U53c2\U52a0\U7684\U4e00\U5b9a\U8981\U52a0\U7fa4\U54df\Uff01";
                "show_status" = 1;
                "show_time" = 1492040560;
                "specific_catalog" = CSGOx7;
                "specific_status" = 1;
                url = "/CSGOx7";
                "vertical_src" = "https://rpic.douyucdn.cn/a1704/13/11/261950_170413114030.jpg";
                "vod_quality" = 0;
            };
            title = "CSGO\U9ec4\U91d1\U9020\U68a6\U5bfc\U5e08\U2014\U5c0f\U67d2";
            "tv_pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704052030257160.jpg";
    },
        {
            id = 1949356;
            "pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704101558497971.jpg";
            room =             {
                "cate_id" = 195;
                "cate_limit" =                 {
                    "limit_num" = 0;
                    "limit_threshold" = 0;
                    "limit_time" = 30;
                    "limit_type" = 0;
                };
                cdnsWithName =                 (
                    {
                        cdn = ws;
                        name = "\U4e3b\U7ebf\U8def";
                },
                    {
                        cdn = tct;
                        name = "\U5907\U7528\U7ebf\U8def5";
                },
                    {
                        cdn = ws2;
                        name = "\U5907\U7528\U7ebf\U8def2";
                },
                    {
                        cdn = dl;
                        name = "\U5907\U7528\U7ebf\U8def3";
                }
                );
                "column_id" = 11;
                "credit_illegal" = 0;
                "cur_credit" = 12;
                fans = 1669;
                "game_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/ac9e22d6b80cb57b878e6fa3cca15400.jpg";
                "game_name" = "\U9c7c\U6559";
                "game_url" = "/directory/game/yj";
                isVertical = 0;
                "is_pass_player" = 0;
                "is_white_list" = 0;
                "low_credit" = 4;
                nickname = "\U4e8c\U66f4\U89c6\U9891";
                online = 5811;
                "open_full_screen" = 0;
                "owner_avatar" = "https://apic.douyucdn.cn/upload/avanew/face/201704/01/13/16d5c6282697cc3b6ee3daab4f3333dd_big.jpg?rltime";
                "owner_uid" = 129137040;
                "owner_weight" = "4.3kg";
                "room_id" = 1949356;
                "room_name" = "\U4e8c\U66f4\U4e0e\U4f60\U4e00\U8d77\U53d1\U73b0\U751f\U6d3b\U7684\U7f8e";
                "room_src" = "https://rpic.douyucdn.cn/a1704/13/11/1949356_170413113958.jpg";
                "show_details" = "";
                "show_status" = 1;
                "show_time" = 1492051074;
                "specific_catalog" = egsp;
                "specific_status" = 0;
                url = "/1949356";
                "vertical_src" = "https://rpic.douyucdn.cn/a1704/13/11/1949356_170413113958.jpg";
                "vod_quality" = 0;
            };
            title = "\U4e8c\U66f4-\U53d1\U73b0\U8eab\U8fb9\U7684\U7f8e";
            "tv_pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201704101558512331.jpg";
    },
        {
            id = 443012;
            "pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201702281600066847.jpg";
            room =             {
                "cate_id" = 183;
                "cate_limit" =                 {
                    "limit_num" = 0;
                    "limit_threshold" = 0;
                    "limit_time" = 30;
                    "limit_type" = 0;
                };
                cdnsWithName =                 (
                    {
                        cdn = ws;
                        name = "\U4e3b\U7ebf\U8def";
                },
                    {
                        cdn = tct;
                        name = "\U5907\U7528\U7ebf\U8def5";
                },
                    {
                        cdn = ws2;
                        name = "\U5907\U7528\U7ebf\U8def2";
                },
                    {
                        cdn = dl;
                        name = "\U5907\U7528\U7ebf\U8def3";
                }
                );
                "column_id" = 11;
                "credit_illegal" = 0;
                "cur_credit" = 12;
                fans = 44440;
                "game_icon_url" = "https://staticlive.douyucdn.cn/upload/game_cate/7bf223b646cc1782e8390ecffda29c27.jpg";
                "game_name" = "\U56fd\U6f2b";
                "game_url" = "/directory/game/gm";
                isVertical = 0;
                "is_pass_player" = 0;
                "is_white_list" = 0;
                "low_credit" = 4;
                nickname = "\U82e5\U68ee\U753b\U6c5f\U6e56\U52a8\U6f2b";
                online = 1147;
                "open_full_screen" = 0;
                "owner_avatar" = "https://apic.douyucdn.cn/upload/avatar/026/78/03/48_avatar_big.jpg?rltime";
                "owner_uid" = 26780348;
                "owner_weight" = "625.842kg";
                "room_id" = 443012;
                "room_name" = "\U300a\U676f\U83ab\U505c\U300b\U5468\U4e09\U66f4\U65b0\U300a\U4e0d\U826f\U4eba2\U300b\U5468\U56db\U66f4";
                "room_src" = "https://rpic.douyucdn.cn/a1704/13/11/443012_170413113410.jpg";
                "show_details" = "\U3010\U753b\U6c5f\U6e56\U7cfb\U5217\U3011\U300a\U753b\U6c5f\U6e56\U4e4b\U676f\U83ab\U505c\U300b\U6bcf\U5468\U4e09\U8ddf\U65b0\Uff0c\U300a\U753b\U6c5f\U6e56\U4e4b\U4e0d\U826f\U4eba2\U300b\U6bcf\U5468\U56db\U66f4\U65b0\U3002\U300a\U753b\U6c5f\U6e56\U4e4b\U7075\U4e3b\U300b\U300a\U4fa0\U5c9a\U300b\U7b2c\U516d\U5b63\U5df2\U7ecf\U66f4\U5b8c\U3002";
                "show_status" = 1;
                "show_time" = 1491962662;
                "specific_catalog" = "";
                "specific_status" = 0;
                url = "/443012";
                "vertical_src" = "https://rpic.douyucdn.cn/a1704/13/11/443012_170413113410.jpg";
                "vod_quality" = 0;
            };
            title = "\U753b\U6c5f\U6e56\U4e4b\U4e0d\U826f\U4eba2";
            "tv_pic_url" = "https://staticlive.douyucdn.cn/upload/signs/201702281600088430.jpg";
    }
    );
    error = 0;
}
  */
