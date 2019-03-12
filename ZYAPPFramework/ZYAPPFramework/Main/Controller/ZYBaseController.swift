//
//  ZYBaseController.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

class ZYBaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true;
        sh_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30;
        if let vcCount = self.navigationController?.viewControllers.count, vcCount > 1 {
            setNormalBackItem()
        }
    }
}

extension ZYBaseController {
    //MARK: private
    
    /// 设置导航栏默认返回按钮(<)
    fileprivate func setNormalBackItem() {
        self.navigationItem.hidesBackButton = true;
        let backButton: UIButton = self.backButton()
        let backView = UIView(frame: backButton.bounds)
        backButton.addTarget(self, action: #selector(backItemAction), for: UIControl.Event.touchUpInside)
        backView.addSubview(backButton)
        let negativeSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = ZYTheme.screenWidth > 375 ? -20 : -16
        let leftBarButtonItem = UIBarButtonItem(customView: backView)
        self.navigationItem.leftBarButtonItems = [negativeSpace, leftBarButtonItem]
    }
    
    /// 导航栏返回按钮
    fileprivate func backButton() -> UIButton {
        let backButton = UIButton(type: UIButton.ButtonType.custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
        backButton.setImage(UIImage(named: "navigation_back_normal"), for: UIControl.State.normal)
        backButton.setImage(UIImage(named: "navigation_back_highlighted"), for: UIControl.State.highlighted)
        
        return backButton;
    }
    
    @objc fileprivate func backItemAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
