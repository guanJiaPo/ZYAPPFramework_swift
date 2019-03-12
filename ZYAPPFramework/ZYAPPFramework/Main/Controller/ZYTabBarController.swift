//
//  ZYTabBarController.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class ZYTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = kHexColor(rgb: 0xEFF0F6)
        setTabBarControllers() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - private
    
    fileprivate func setTabBarControllers() {
        let homeNavController = getNavigationController(className: "ZYHomeController")
        homeNavController.tabBarItem = ESTabBarItem.init(ZYTabBarContentView(), title: "首页", image: UIImage(named: "tabBar_home_normal"), selectedImage: UIImage(named: "tabBar_home_selected"))
        
        let profileNavController = getNavigationController(className: "ZYProfileController")
        profileNavController.tabBarItem = ESTabBarItem.init(ZYTabBarContentView(), title: "我的", image: UIImage(named: "tabBar_profile_normal"), selectedImage: UIImage(named: "tabBar_profile_selected"))
        
        self.viewControllers = [homeNavController,profileNavController];
    }
    
    fileprivate func getNavigationController(className : String) -> ZYNavigationController {
        //动态获取命名空间: 命名空间就是用来区分完全相同的类
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        //swift中字符串转化为一个类
        let claName:AnyClass =  NSClassFromString(namespace + "." + className)!
        
        //指定claName是一个控制器类
        let claVC = claName as! UIViewController.Type
        
        //创建控制器
        let controller = claVC.init()
        
        return ZYNavigationController(rootViewController: controller)
    }
}
