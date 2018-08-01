//
//  MainCollectionHeaderView.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/2.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

class MainSectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var nameLabel: UILabel!
    
    var touchupButtonBlock: ((_ model: RoomListModel?) -> Void)?
    
    var model: RoomListModel? {
        didSet {
            nameLabel.text = model?.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setModel(model: RoomListModel?, touchupButtonBlock: @escaping (_ model: RoomListModel?) -> Void) {
        self.model = model
        self.touchupButtonBlock = touchupButtonBlock
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touchupButtonBlock?(model)
    }
    
}
