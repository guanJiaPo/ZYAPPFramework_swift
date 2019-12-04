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
    
    // MARK: - 查找顶层控制器
    /// 获取顶层控制器 根据window
    func appearController() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return appearController(currentVC: vc)
    }
    
    /// 根据控制器获取 顶层控制器
    func appearController(currentVC VC: UIViewController?) -> UIViewController? {
        if VC == nil {
            return nil
        }
        if let presentVC = VC?.presentedViewController {
            //modal出来的 控制器
            return appearController(currentVC: presentVC)
        }else if let tabVC = VC as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return appearController(currentVC: selectVC)
            }
            return nil
        } else if let naiVC = VC as? UINavigationController {
            // 控制器是 nav
            return appearController(currentVC:naiVC.visibleViewController)
        } else {
            // 返回顶控制器
            return VC
        }
    }
}
