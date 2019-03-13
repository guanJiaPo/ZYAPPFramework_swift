//
//  UIButton+Category.swift
//  UESwift
//
//  Created by 石志愿 on 2018/6/11.
//  Copyright © 2018年 石志愿. All rights reserved.
//

import UIKit

enum ZYButtonImagePosition: Int {
    /// 左图右字
    case left
    /// 右图左字
    case right
    /// 上图下字
    case top
    /// 下图上字
    case bottom
}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState:UIControl.State) {
        self.setBackgroundImage(UIImage.imageWithColor(color: color), for: forState)
    }
    

    /// 调整图片方向
    ///
    /// - Parameters:
    ///   - position: 图片位置
    ///   - space: 文字与图片的间距
    func adjustImagePosition(position: ZYButtonImagePosition, space: CGFloat) {
        let imageWidth = self.imageView?.intrinsicContentSize.width ?? 0;
        let imageHeight = self.imageView?.intrinsicContentSize.height ?? 0;
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0;
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0;
        switch position {
        case ZYButtonImagePosition.left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2, bottom: 0, right: space / 2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
        case ZYButtonImagePosition.right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space / 2, bottom: 0, right: -labelWidth - space/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space / 2, bottom: 0, right: imageWidth + space / 2)
        case ZYButtonImagePosition.top:
            self.imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space / 2, left: 0, bottom: 0, right: -labelWidth)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space / 2, right: 0)
        case ZYButtonImagePosition.bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space / 2, right: -labelWidth)
            self.titleEdgeInsets = UIEdgeInsets(top: -imageHeight - space / 2, left: -imageWidth, bottom: 0, right: 0)
        }
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
