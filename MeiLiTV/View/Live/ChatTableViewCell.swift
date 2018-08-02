//
//  ChatTableViewCell.swift
//  LAXDouyu
//
//  Created by 冰凉的枷锁 on 2017/4/18.
//  Copyright © 2017年 liuaoxiang. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
