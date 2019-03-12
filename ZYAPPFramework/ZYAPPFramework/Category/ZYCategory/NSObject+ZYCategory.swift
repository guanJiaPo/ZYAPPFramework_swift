//
//  NSObjectCategory.swift
//  UESwift
//
//  Created by 石志愿 on 2018/3/9.
//  Copyright © 2018年 石志愿. All rights reserved.
//

import Foundation
import HandyJSON

extension NSObject: HandyJSON {
    
    
}

extension NSObject {
    /// 是否为模拟器
    var isSimulator: Bool{
        get {
            var isSim = false
            #if arch(i386) || arch(x86_64)
            isSim = true
            #endif
            return isSim
        }
    }
}
