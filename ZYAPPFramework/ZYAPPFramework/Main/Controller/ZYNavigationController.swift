//
//  ZYNavigationController.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit
import SHFullscreenPopGestureSwift

class ZYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sh_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30
        self.delegate = self;
        navigationBar.backIndicatorImage = UIImage()
        navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationBar.tintColor = kHexColor(rgb: 0xf8f8f8)
        navigationBar.barTintColor = kHexColor(rgb: 0xf8f8f8)
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : kFont(size: 18)]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : kFont(size: 18)]
    }
}

extension ZYNavigationController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        resetBarItemSpacesWithController(viewController: viewController)
        
        /// 隐藏导航栏底部分割线
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        if self.viewControllers.count == 1 {
//            self.tabBarController?.tabBar.isHidden = false;
//        } else {
//            self.tabBarController?.tabBar.isHidden = true;
//        }
    }
}

extension ZYNavigationController {
    //MARK: private
    /// 修改导航栏左右item边距
    func resetBarItemSpacesWithController(viewController : UIViewController) {
        if Double(ZYSystem.systemVersion)! < 11.0 {
            return
        }
        let space: CGFloat = ZYTheme.screenWidth > 375 ? 20 : 16;
        guard let leftItems = viewController.navigationItem.leftBarButtonItems else {
            return
        }
        
        for buttonItem in leftItems {
            if let customView = buttonItem.customView {
                var itemBtn: UIView?
                if customView is UIButton {
                    itemBtn = buttonItem.customView
                } else {
                    itemBtn = buttonItem.customView?.subviews.first
                }
                if var newFrame = itemBtn?.frame {
                    newFrame.origin.x = -space
                    itemBtn?.frame = newFrame
                }
            }
        }

        guard let rightItems = viewController.navigationItem.rightBarButtonItems else {
            return
        }
        
        for buttonItem in rightItems {
            if let customView = buttonItem.customView {
                var itemBtn: UIView?
                if customView is UIButton {
                    itemBtn = buttonItem.customView
                } else {
                    itemBtn = buttonItem.customView?.subviews.first
                }
                if var newFrame = itemBtn?.frame {
                    newFrame.origin.x = space
                    itemBtn?.frame = newFrame
                }
            }
        }
    }
}
