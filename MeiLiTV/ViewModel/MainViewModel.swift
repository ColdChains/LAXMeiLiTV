//
//  MainViewModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

class MainViewModel {
    
    // 获取轮播图
    class func getAutoPlayViewData(successBlock: @escaping ((_ model: SliderResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        
        let date = NSDate.init()
        let time = String.init(format: "%f", date.timeIntervalSince1970)
        var dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        dict["version"] = "2.10"
        
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(URLString_Base + URLString_Main_Slide, parameters: dict, progress: nil, success: { (task, object) in
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
                let model = try! SliderResultModel.init(dictionary: object as? [AnyHashable : Any])
                successBlock(model)
                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
        
    }
    
    // 获取主要信息
    class func getRoomListData(successBlock: @escaping ((_ model: RoomListResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        
        let date = NSDate.init()
        let time = String.init(format: "%f", date.timeIntervalSince1970)
        var dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        dict["tagIds"] = "133_2_"
        
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(URLString_Base + URLString_Main_RoomList, parameters: dict, progress: nil, success: { (task, object) in
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
                let model = try! RoomListResultModel.init(dictionary: object as? [AnyHashable : Any])
                successBlock(model)
                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
        
    }
    
    // 获取直播房间信息
    class func getLiveRoomData(roomId:String, successBlock: @escaping ((_ model: LiveRoomResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        
        let str = "http://m.douyu.com/html5/live?roomId=" + roomId
        print(str)
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(str, parameters: nil, progress: nil, success: { (task, object) in
            
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
                let model = try! LiveRoomResultModel.init(dictionary: object as? [AnyHashable : Any])
                successBlock(model)
                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
    }
    
}
