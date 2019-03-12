//
//  UECircleProgress.swift
//  UESwift
//
//  Created by 石志愿 on 2018/8/1.
//  Copyright © 2018年 石志愿. All rights reserved.
//

/********************************* 圆形进度条 **************************/

import UIKit

class ZYCircleProgress: UIView {

    //MARK: - public
    var progress: CGFloat {
        didSet{
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.progressLayer.strokeEnd = progress
            CATransaction.commit()
            if progress > 0 && progress < 1 {
                self.circleLayer.path = pathForEndCircle(with: progress)
            } else {
                self.circleLayer.path = nil;
            }
        }
    }
    var fillColor: UIColor {
        didSet{
            self.fillLayer.backgroundColor = fillColor.cgColor
        }
    }
    var progressColor: UIColor {
        didSet{
          self.progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    convenience init(with frame: CGRect, progressColor: UIColor, fillColor: UIColor, lineWidth: CGFloat) {
        self.init(with: frame, progressColor: progressColor, fillColor: fillColor, lineWidth: lineWidth, clockwise: true, endCircle: false)
    }
    
    convenience init(with frame: CGRect, progressColor: UIColor, fillColor: UIColor, lineWidth: CGFloat, clockwise: Bool) {
        self.init(with: frame, progressColor: progressColor, fillColor: fillColor, lineWidth: lineWidth, clockwise: clockwise, endCircle: false)
    }
    
    init(with frame: CGRect, progressColor: UIColor, fillColor: UIColor, lineWidth: CGFloat, clockwise: Bool, endCircle: Bool) {
        self.progressColor = progressColor
        self.fillColor = fillColor
        self.clockwise = clockwise
        self.endCircle = endCircle
        self.lineWidth = lineWidth
        self.progress = 0.0
        super.init(frame: frame)
        setUp()
        if endCircle {
            self.layer.addSublayer(self.circleLayer)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - private
    private var clockwise = true // 是否顺时针
    private var endCircle = false // 末尾是否加圆点
    private var lineWidth: CGFloat = 2
    private let fillLayer = CAGradientLayer()
    private let progressLayer = CAShapeLayer()
    
    private func setUp() {
        fillLayer.frame = self.bounds
        fillLayer.cornerRadius = fillLayer.bounds.width * 0.5
        fillLayer.backgroundColor = self.fillColor.cgColor
        self.layer.addSublayer(fillLayer)
        
        progressLayer.frame = self.bounds.insetBy(dx: self.layer.borderWidth, dy: self.layer.borderWidth)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = self.progressColor.cgColor
        progressLayer.opacity = 0.8 // 透明度
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = self.lineWidth
        let startAngle = self.clockwise ? -0.5 * CGFloat.pi : CGFloat.pi * 1.5;
        let endAngle = self.clockwise ? CGFloat.pi * 1.5 : -0.5 * CGFloat.pi;
        progressLayer.strokeEnd = 0
        let bezierPath = UIBezierPath(arcCenter: self.center, radius: (self.bounds.width - self.lineWidth) * 0.5, startAngle: startAngle, endAngle: endAngle, clockwise: self.clockwise)
        progressLayer.path = bezierPath.cgPath
        self.layer.addSublayer(progressLayer)
    }
    
    private func pathForEndCircle(with progress: CGFloat) -> CGPath {
        let startAngle = -0.5 * CGFloat.pi;
        let radius = (self.layer.bounds.width - self.lineWidth) * 0.5;
        let endX = self.center.x + radius * cos(startAngle + self.progress * 2 * CGFloat.pi);
        let endY = self.center.y + radius * sin(startAngle + self.progress * 2 * CGFloat.pi);
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: endX, y: endY), radius: 2, startAngle: startAngle + 0.001, endAngle: CGFloat.pi * 1.5, clockwise: true)
        return bezierPath.cgPath
    }
    
    private lazy var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = self.progressLayer.frame
        circleLayer.fillColor = self.progressColor.cgColor
        circleLayer.strokeColor = self.progressColor.cgColor
        circleLayer.opacity = 1 // 透明度
        circleLayer.lineCap = CAShapeLayerLineCap.round
        circleLayer.lineWidth = 2
        circleLayer.strokeEnd = 0
        if self.progress > 0 && self.progress < 1 {
            circleLayer.path = pathForEndCircle(with: self.progress);
        }
        return circleLayer
    }()
}
