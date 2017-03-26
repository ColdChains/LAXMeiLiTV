//
//  PersonalViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/3/14.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class PersonalViewController: LAXNavigationController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "PersonalTableViewCell"
    
    var dataArray: Array<String> = ["姓名", "性别", "出生日期", "出生地", "现居地"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 30))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init())
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PersonalTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print("exit")
    }
    
}
