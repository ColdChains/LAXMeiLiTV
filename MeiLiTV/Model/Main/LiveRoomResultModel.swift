//
//  LiveRoomResultModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/19.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveRoomModel: BaseJSONModel {
    
    var room_id: String?
    var tag_name: String?
    var room_src: String?
    var vertical_src: String?
    var room_name: String?
    var avatar: String?
    var show_status: String?
    var nickname: String?
    var hls_url: String?
    var show_details: String?
    
    var is_vertical: Int = 0
    var cate2_id: Int = 0
    var online: Int = 0
    var is_pass_player: Int = 0
    var is_ticket: Int = 0
    
}

class LiveRoomResultModel: BaseJSONModel {

    var error: Int?
    var msg: String?
    var data: LiveRoomModel?
    
    override init() {
        super.init()
    }
    
    required init(dictionary dict: [AnyHashable : Any]!) throws {
        try super.init(dictionary: dict)
        let dic = dict["data"] as?[AnyHashable : Any];
        self.data = try LiveRoomModel.init(dictionary: dic)
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
    error: 0,
    msg: "OK",
    data: {
        room_id: "442078",
        tag_name: "企鹅直播",
        room_src: "https://staticlive.douyucdn.cn/upload/web_pic/c4c1473272daa6da3adcfb6b2e5cdc35_thumb.png",
        is_vertical: 0,
        vertical_src: "https://staticlive.douyucdn.cn/upload/web_pic/c4c1473272daa6da3adcfb6b2e5cdc35_thumb.png",
        cate2_id: 207,
        room_name: "直播NBA季后赛  爵士-快船",
        avatar: "https://apic.douyucdn.cn/upload/avatar/026/66/75/76_avatar_middle.jpg?rltime",
        show_status: "1",
        online: 95,
        nickname: "科比pp",
        hls_url: "http://hls1a.douyucdn.cn/live/442078rJVYIvHQ9L_550/playlist.m3u8?wsSecret=118b24c0fea3b7cfbca5f6ffcb6c408d&wsTime=1492569304",
        is_pass_player: 0,
        is_ticket: 0,
        show_details: ""
    }
}
 */
