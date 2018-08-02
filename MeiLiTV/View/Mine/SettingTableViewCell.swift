//
//  SettingTableViewCell.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/28.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var stateSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.stateSwitch.isOn = LAXReachabilityManager.shared.onlyWIFI
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        LAXReachabilityManager.shared.onlyWIFI = sender.isOn
    }
    
}
