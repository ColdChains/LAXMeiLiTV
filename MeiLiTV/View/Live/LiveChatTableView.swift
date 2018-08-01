//
//  LiveChatTableView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/5/23.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class LiveChatTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "ChatTableViewCell"
    var liveChatManager = LiveChatManager.init()
    
    var roomModel: RoomModel?
    var dataArr = [LiveChatModel]()
    
    var isTouch = false
    var barrage: BarrageView?
    
    func initView() {
        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView.init()
//        self.estimatedRowHeight = 20
//        self.rowHeight = UITableViewAutomaticDimension
        self.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func startLiveChat() {
        
        liveChatManager.setMessageReceive { [unowned self] (model) in
            if model != nil {
                self.showChatMessage(model: model!)
                // 弹幕
                self.barrage?.messageQueue.append(model!.txt)
            }
        }
        liveChatManager.setInfoCallbackBlock { [unowned self] (model) in
            if model != nil {
                self.showChatMessage(model: model!)
            }
        }
        if let name = self.roomModel?.room_name {
            liveChatManager.sysInfoCallback("欢迎来到" + name + "的直播间")
        }
        liveChatManager.connect(withRoomID: "\(roomModel!.room_id)", groupId: "-9999")
        
    }
    
    func endLiveChat() {
        liveChatManager.stop()
    }

    func showChatMessage(model: STTModel) {
        if model.txt == nil {
            return
        }
        
        if dataArr.count > 2000 {
            dataArr.removeSubrange(Range.init(uncheckedBounds: (lower: 0, upper: 1000)))
            self.reloadData()
        }
        
        let chat = LiveChatModel()
        chat.txt = model.txt //+ "==========================================================="
        chat.nn = model.nn
        chat.type = model.type
        
        if model.type == "chatmsg" {
            if model.txt.contains("emot:") {
            }
            let bStr = try! NSMutableAttributedString.init(data: model.txt.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            bStr.addAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 16)], range: NSRange.init(location: 0, length: bStr.length))
            chat.attrTxt = bStr;
            
            let aStr = NSMutableAttributedString.init(string: model.nn! + "：", attributes: [NSForegroundColorAttributeName: UIColor.init(red: 0, green: 128 / 255, blue: 1, alpha: 1)])
            let cStr = try! NSMutableAttributedString.init(data: model.txt.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            cStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGray, range: NSRange.init(location: 0, length: cStr.length))
            aStr.append(cStr)
            aStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSRange.init(location: 0, length: cStr.length))
            
            chat.attrMsg = aStr
            chat.txtHeight = aStr.string.boundingRect(with: CGSize.init(width: self.frame.size.width - 20, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil).size.height + 6
        }
        
        
        dataArr.append(chat)

        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            let index = IndexPath.init(row: dataArr.count - 1, section: 0)
            self.insertRows(at: [index], with: .bottom)
            if !isTouch {
                self.scrollToRow(at: index, at: .none, animated: true)
            }
        }
        
    }
    
    // MARK: - Protocol
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ChatTableViewCell
        let model = dataArr[indexPath.row]
        if model.type == "sysInfo" {
            cell.chatTextLabel.text = model.txt
            cell.chatTextLabel.textColor = UIColor.orange
        } else if model.type == "uenter" {
            if let name = model.nn {
                cell.chatTextLabel.text = name + " 进入房间"
                cell.chatTextLabel.textColor = UIColor.orange
            }
        } else {
            cell.chatTextLabel.attributedText = model.attrMsg
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArr[indexPath.row];
        if let height = model.txtHeight {
            return height + 6
        }
        return 20
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTouch = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isTouch = false
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
//        view.backgroundColor = UIColor.orange
//        return view
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView.init(frame: CGRect.init())
//    }

}
