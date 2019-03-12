//
//  UIViewCategory.swift
//  UESwift
//
//  Created by 石志愿 on 2018/5/28.
//  Copyright © 2018年 石志愿. All rights reserved.
//

import UIKit

// MARK: HUD
extension UIView {
    
    /// 在keyWindow上展示信息, 自动隐藏
    func showMessage(message:String?) {
        showMessage(message: message, toView: nil)
    }
    
    /// 在指定View上展示信息, 自动隐藏
    func showMessage(message:String?, toView:UIView?) {
        if message == nil { return }
        var view = toView;
        if view == nil {
            view = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to:view!, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = message
        hud.label.font = UIFont.systemFont(ofSize: 14)
        //小矩形的背景色
        hud.bezelView.color = UIColor.clear
        //显示的文字
        hud.label.text = message
        //设置背景,加遮罩
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func showLoading() {
        showLoading(message: nil)
    }
    
    func showLoading(message:String?) {
        let hud = MBProgressHUD.showAdded(to:UIApplication.shared.keyWindow!, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = message
        hud.label.font = UIFont.systemFont(ofSize: 14)
        hud.bezelView.color = UIColor.clear
        //设置背景,加遮罩
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
    }
    
    func hiddenLoading() {
        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    }
}

// MARK: 分割线
extension UIView {
    func addBroder(frame:CGRect, borderCorlor:UIColor) {
        let layer = CALayer()
        layer.backgroundColor = borderCorlor.cgColor
        layer.frame = frame
        self.layer.addSublayer(layer)
    }
    func addTopBorder(borderWidth:CGFloat, borderCorlor:UIColor) {
        let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: borderWidth)
        addBroder(frame: frame, borderCorlor: borderCorlor)
    }
    func addBottomBorder(borderWidth:CGFloat, borderCorlor:UIColor) {
        let frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        addBroder(frame: frame, borderCorlor: borderCorlor)
    }
    func addLeftBorder(borderWidth:CGFloat, borderCorlor:UIColor) {
        let frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height)
        addBroder(frame: frame, borderCorlor: borderCorlor)
    }
    func addRightBorder(borderWidth:CGFloat, borderCorlor:UIColor) {
        let frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height)
        addBroder(frame: frame, borderCorlor: borderCorlor)
    }
}

//MARK: 圆角
extension UIView {
    
    func setCornerRadius(cornerRadius:CGFloat) {
        self.setCornerRadius(cornerRadius: cornerRadius, size: size)
    }
    
    func setCornerRadius(cornerRadius:CGFloat, size:CGSize) {
        self.setCornerRadius(cornerRadius: cornerRadius, roundingCorner: UIRectCorner.allCorners, size: size)
    }
    
    func setCornerRadius(cornerRadius:CGFloat, roundingCorner:UIRectCorner, size:CGSize) {
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), byRoundingCorners: roundingCorner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setCornerRadius(cornerRadius:CGFloat, borderColor:UIColor?, borderWidth:CGFloat, size:CGSize) {
        self.setCornerRadius(cornerRadius: cornerRadius, roundingCorner: UIRectCorner.allCorners, borderColor:borderColor, borderWidth:borderWidth, size:size)
    }
    
    func setCornerRadius(cornerRadius:CGFloat, roundingCorner:UIRectCorner, borderColor:UIColor?, borderWidth:CGFloat, size:CGSize) {
        let padding = borderWidth / 2
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: padding, y: padding, width: size.width - 2 * padding, height: size.height - 2 * padding), byRoundingCorners: roundingCorner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        maskLayer.path = maskPath.cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = borderColor?.cgColor
        maskLayer.lineWidth = borderWidth
        self.layer.addSublayer(maskLayer)
    }
}

// MARK - controller
extension UIView {
    func viewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

// MARK: frame
extension UIView {
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY: CGFloat {
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    var size: CGSize {
        get{
            return self.frame.size
        }
        set{
            var tempFrame = self.frame
            tempFrame.size = newValue
            self.frame = tempFrame
        }
    }
    
    var top: CGFloat {
        get{
            return self.frame.minY
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var bottom: CGFloat {
        get{
            return self.frame.maxY
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    var left: CGFloat {
        get{
            return self.frame.minX
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var right: CGFloat {
        get{
            return self.frame.maxX
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
}
