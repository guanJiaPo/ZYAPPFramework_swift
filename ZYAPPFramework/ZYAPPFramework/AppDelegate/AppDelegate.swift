//
//  AppDelegate.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootController()
        return true
    }
}


extension AppDelegate {
    //MARK: private
    fileprivate func setupRootController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootController = ZYTabBarController()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
