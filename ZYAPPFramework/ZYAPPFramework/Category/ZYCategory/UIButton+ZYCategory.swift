//
//  UIButton+Category.swift
//  UESwift
//
//  Created by 石志愿 on 2018/6/11.
//  Copyright © 2018年 石志愿. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState:UIControl.State) {
        self.setBackgroundImage(UIImage.imageWithColor(color: color), for: forState)
    }
}

let kHitEdgeInsets = "hitEdgeInsets";
extension UIButton {
    var hitEdgeInsets: UIEdgeInsets {
        get {
            let value = objc_getAssociatedObject(self, kHitEdgeInsets) as? NSValue;
            var edgeInsets: UIEdgeInsets?
            value?.getValue(&edgeInsets)
            return edgeInsets ?? UIEdgeInsets.zero
        }
        set {
            let value = NSValue(uiEdgeInsets: hitEdgeInsets);
            objc_setAssociatedObject(self,kHitEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var hitFrame: CGRect {
        get {
            return CGRect(x: bounds.origin.x + self.hitEdgeInsets.left, y: self.bounds.origin.y + self.hitEdgeInsets.top, width: self.bounds.size.width - self.hitEdgeInsets.left - self.hitEdgeInsets.right, height: self.bounds.size.height - self.hitEdgeInsets.top - self.hitEdgeInsets.bottom)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if !self.isUserInteractionEnabled || !self.isEnabled || self.isHidden || self.alpha < 0.01 {
            return super.point(inside: point, with: event)
        }
        return self.hitFrame.contains(point)
    }
}
