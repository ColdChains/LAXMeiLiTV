//
//  String+RemoveSpace.swift
//  LAX_OCExtendSystemClass
//
//  Created by 冰凉的枷锁 on 2017/3/27.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    mutating func stringByRemoveSpaceOnlyFirstAndLast() {
        self = self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func stringByRemoveSpace() {
        while self.contains("  ") {
            self = self.replacingOccurrences(of: "  ", with: " ")
        }
    }

    mutating func stringByRemoveSpaceAndLine() {
        while self.contains("\r\n") {
            self = self.replacingOccurrences(of: "\r\n", with: " ")
        }
        while self.contains("\n") {
            self = self.replacingOccurrences(of: "\n", with: " ")
        }
        stringByRemoveSpace()
    }

    mutating func stringByRemoveString(str: String) {
        self = self.replacingOccurrences(of: str, with: "")
    }
    
}
