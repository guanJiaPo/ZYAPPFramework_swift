//
//  ZYAlertBaseView.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/4/22.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

enum ZYAlertViewStyle: Int {
    case bottom = 0
    case center = 1
}

class ZYAlertBaseView: UIView {
    
    /// 点击空白区域隐藏试图，默认 true
    var bgCancel: Bool = true
    
    /// contentView 水平方向左右间距 默认0
    var horizontalSpace: CGFloat = 0 {
        didSet {
            self.contentView.frame = CGRect(x: horizontalSpace, y: self.bounds.height, width: self.bounds.width - horizontalSpace * 2, height: contentHeight)
        }
    }
    
    /// 弹窗显示位置
    private var style: ZYAlertViewStyle = .bottom
    
    /// 内容高度
    private var contentHeight: CGFloat = 0
    
    convenience init(style: ZYAlertViewStyle, contentHeight: CGFloat) {
        self.init(frame: UIScreen.main.bounds)
        self.style = style
        self.contentHeight = contentHeight
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame:UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 子视图需要添加到contentView上
    lazy private(set) var contentView: UIView = {
        let tempView = UIView(frame: CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: contentHeight))
        return tempView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = kHexColor(rgb: 0x000000)
        view.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private func setUI() {
        self.addSubview(backgroundView)
        self.addSubview(self.contentView)
    }
    
    //MARK: public method
    @objc private func hide() {
        if self.bgCancel {
            self.dismiss()
        }
    }
    
    /// 添加到keyWindow
    func presentToWindow() {
        if let window = UIApplication.shared.keyWindow {
            self.present(toView: window)
        }
    }
    
    /// 添加到superView
    func present(toView superView: UIView) {
        superView.addSubview(self)
        self.showAnimation()
    }
    
    /// 动画弹出(已经添加到父视图)
    func showView() {
        self.showAnimation()
    }
    
    /// 动画消失 不从父视图移除
    func hiddenView() {
        self.hiddenView(completion: nil)
    }
    
    /// 动画消失 不从父视图移除
    func hiddenView(completion: (()->())?) {
        self.hiddenAnimation(remove: false, completion: completion)
    }
    
    /// 动画消失 从父视图移除
    func dismiss() {
        self.dismiss(completion: nil)
    }
    
    /// 动画消失 先调用completion再从父视图移除
    func dismiss(completion: (()->())?) {
        self.hiddenAnimation(remove: true, completion: completion)
    }
    
    //MARK: private method
    
    private func showAnimation() {
        self.contentView.frame = CGRect(x: self.contentView.x, y: self.height, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        
        var contentY: CGFloat = 0;
        switch (self.style) {
        case .bottom:
            contentY = self.frame.size.height - self.contentView.frame.size.height;
            break;
        case .center:
            contentY = (self.frame.size.height - self.contentView.frame.size.height) * 0.5;
            break;
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.frame = CGRect(x: self.contentView.x, y: contentY, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
            self.backgroundView.alpha = 0.2
        }) { (finish) in
            
        }
    }
    
    /// 隐藏
    private func hiddenAnimation(remove: Bool, completion: (()->())?) {
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.frame = CGRect(x: self.contentView.x, y: self.bounds.height, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
            self.backgroundView.alpha = 0
        }) { (finish) in
            completion?()
            if remove {
                self.removeFromSuperview()
            }
        }
    }
}
