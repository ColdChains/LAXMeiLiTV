//
//  SettingViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/28.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class SettingViewController: LAXNavigationController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "SettingTableViewCell"
    
    var dataArray: Array<String> = ["仅WIFI播放视频", "关于魅力TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init())
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SettingTableViewCell
            return cell
        } else {
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
//            cell.textLabel?.font = UIFont.systemFont(ofSize: DefaultFontSize)
            cell.textLabel?.text = dataArray[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if let dict = Bundle.main.infoDictionary {
                var title = "关于"
                if let name = dict["CFBundleDisplayName"] {
                    title += name as! String
                }
                var message = "版本号:"
                if let number = dict["CFBundleShortVersionString"] {
                    message += number as! String
                }
                message += "\n开发者:ColdChains\n联系QQ:1665674135\n山东理工大学 计算机学院"
                self.showAlertViewDefault(title: title, message: message)
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print("exit")
    }
    
}

