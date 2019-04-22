//
//  ZYTheme.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

/******************* 屏幕尺寸 *****************/
struct ZYTheme {

    //MARK: 屏幕宽度
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    //MARK: 屏幕高度
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    //MARK: 屏幕分辨率
    static var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    
    //MARK: 1像素
    static var onePixels: CGFloat {
        return 1 / screenScale
    }
    
    //MARK: 状态栏高度
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    //MARK: 导航栏高度
    static var navBarHeight: CGFloat {
        return 44
    }
    
    //MARK: 导航栏总高度（状态栏 + 导航栏）
    static var navTotalHeight: CGFloat {
        return statusBarHeight + navBarHeight
    }
    
    //MARK: 屏幕安全区边距
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        }
        return UIEdgeInsets.zero
    }
    
    //MARK: 虚拟home键高度
    static var safeAreaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaInsets.bottom
        }
        return 0
    }
}

/******************* 设备类型 *****************/
extension ZYTheme {
    
    //MARK: 是否为iPad
    static var iPad: Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }
    
    //MARK: 是否为模拟器
    static var isSimulator: Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }
}

/******************* 固定颜色 *****************/
extension ZYTheme {
    
    //MARK: 主题色
    static var themeColor: UIColor {
        return kHexColor(rgb: 0x4A6AFF)
    }
    
    //MARK: 主标题色
    static var titleColor: UIColor {
        return kHexColor(rgb: 0x333333)
    }
    
    //MARK: 副标题色
    static var subTitleColor: UIColor {
        return kHexColor(rgb: 0x9092a5)
    }
    
    //MARK: 分割线色
    static var lineColor: UIColor {
        return kHexColor(rgb: 0xC2CADC)
    }
}

