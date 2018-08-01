//
//  Color+Custom.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/11.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorWithString(value: String, alpha: CGFloat) -> UIColor{
        var  str = value.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if value.hasPrefix("#"){
            str = value.substring(from: value.index(after: value.startIndex))
        }
        let redStr = (str as NSString ).substring(to: 2)
        let greenStr = ((str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let blueStr = ((str as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string:redStr).scanHexInt32(&r)
        Scanner(string: greenStr).scanHexInt32(&g)
        Scanner(string: blueStr).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
}
