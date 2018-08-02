//
//  LiveViewModel.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/29.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

class LiveViewModel {
    
    // 获取分类菜单
    class func getLiveMenuData(successBlock: @escaping ((_ model: LiveMenuResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        
        let date = NSDate.init()
        let time = String.init(format: "%d", date.timeIntervalSince1970)
        let dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(URLString_Base + URLString_Live_Menu, parameters: dict, progress: nil, success: { (task, object) in
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
                let model = try! LiveMenuResultModel.init(dictionary: object as? [AnyHashable : Any])
                successBlock(model)
                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
    }
    
    // 获取常用分类列表
    class func getLiveTypeData(successBlock: @escaping ((_ model: LiveTypeResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        
        let date = NSDate.init()
        let time = String.init(format: "%d", date.timeIntervalSince1970)
        let dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(URLString_Base + URLString_Live_Type, parameters: dict, progress: nil, success: { (task, object) in
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
                let model = try! LiveTypeResultModel.init(dictionary: object as? [AnyHashable : Any])
                successBlock(model)
                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
    }
    
    // 获取某类直播列表
    class func getLiveListData(tagId: Int, subTagId: Int?, offset: Int, successBlock: @escaping ((_ model: LiveListResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        
        let date = NSDate.init()
        let time = String.init(format: "%d", date.timeIntervalSince1970)
        var dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        dict["limit"] = "\(DefaultLoadCount)"
        dict["offset"] = "\(offset)"
        
        var str = ""
        if tagId >= 0 {
            // 有id请求该类型的全部数据
            str = URLString_Live_List_ColumnRoom + "\(tagId)"
        } else {
            // 无id请求全部数据
            str = URLString_Live_List
        }
        // 如果有subTagId请求分类下的数据
        if subTagId != nil {
            str = URLString_Live_List + "\(subTagId!)"
        }
        
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(URLString_Base + str, parameters: dict, progress: nil, success: { (task, object) in
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
                let model = try! LiveListResultModel.init(dictionary: object as? [AnyHashable : Any])
                successBlock(model)
                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
    }
    
    // 获取子分类
    class func getLiveSubTypeData(tagName: String, successBlock: @escaping ((_ model: LiveListResultModel) -> Void), failBlock: @escaping ((_ error: String) -> Void)) {
        let date = NSDate.init()
        let time = String.init(format: "%d", date.timeIntervalSince1970)
        var dict: Dictionary<String, String> = ["aid":"ios", "client_sys":"ios", "time":time]
        dict["shortName"] = tagName
        
        NetworkActivityIndicator.show()
        LAXAFManager.shared.get(URLString_Base + URLString_Live_Type, parameters: dict, progress: nil, success: { (task, object) in
            NetworkActivityIndicator.hide()
            print(object as Any)
            
            if (object as? [AnyHashable : Any])?["error"] as? Int == 0 {
//                let model = try! LiveListResultModel.init(dictionary: object as? [AnyHashable : Any])
//                successBlock(model)
//                return
            }
            failBlock("加载失败")
            
        }) { (task, error) in
            NetworkActivityIndicator.hide()
            failBlock(error.localizedDescription)
        }
        
//            NSArray * modelArray = [ChannelSubTypeModel arrayOfModelsFromDictionaries:datas error:nil];
//            [_subChannelsArray addObjectsFromArray:modelArray];
//            //刷新显示
//            _subChannelsView.hidden = NO;
//            _subChannelSelectView.dataArray = _subChannelsArray;
//            [_subChannelSelectView reloadData];
//            _subChannelSelectView.tagId = _tagId;
        
    }
    
}
