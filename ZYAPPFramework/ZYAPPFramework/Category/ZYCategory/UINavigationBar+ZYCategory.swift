//
//  UINavigationBar+ZYCategory.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/11.
//  Copyright © 2019 石志愿. All rights reserved.
//

import Foundation

extension UINavigationBar {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if Double(ZYSystem.systemVersion)! < 11.0 {
            return super.hitTest(point, with: event)
        }
        
        var view = super.hitTest(point, with: event)
        
        if point.x <= UIScreen.main.bounds.size.width * 0.5 {
            if let itmes = self.topItem?.leftBarButtonItems {
                for buttonItem in itmes {
                    if let customView = buttonItem.customView {
                        var itemBtn: UIView?
                        if customView is UIButton {
                            itemBtn = buttonItem.customView
                        } else {
                            itemBtn = buttonItem.customView?.subviews.last
                        }
                        if let item = itemBtn as? UIButton {
                            let newRect = item.convert(item.hitFrame, to: self)
                            if newRect.contains(point) {
                                view = item
                                break
                            }
                        }
                       
                    }
                }
            }
        } else {
            if let itmes = self.topItem?.rightBarButtonItems {
                for buttonItem in itmes {
                    if let customView = buttonItem.customView {
                        var itemBtn: UIView?
                        if customView is UIButton {
                            itemBtn = buttonItem.customView
                        } else {
                            itemBtn = buttonItem.customView?.subviews.last
                        }
                        if let item = itemBtn as? UIButton {
                            let newRect = item.convert(item.hitFrame, to: self)
                            if newRect.contains(point) {
                                view = item
                                break
                            }
                        }
                        
                    }
                }
            }
        }
        
        return view
    }
}
