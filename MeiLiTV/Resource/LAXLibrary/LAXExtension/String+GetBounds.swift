//
//  NSString+GetBounds.swift
//  LAX_OCExtendSystemClass
//
//  Created by 冰凉的枷锁 on 2017/3/27.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func boundsWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let bounds = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return bounds
    }
    
    func widthWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        return boundsWithConstrainedWidth(width: width, font: font).size.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        return boundsWithConstrainedWidth(width: width, font: font).size.height
    }
    
}
