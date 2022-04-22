//
//  CircleView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/13.
//

import Foundation
import UIKit

protocol CircleViewDelegate: AnyObject {
    func circleAnimationStop()
}

class CircleView: UIView {
    
    /// 线宽
    private var lineWidth: CGFloat = 3
    /// 填充颜色
    private var strokeColor = UIColor(red: 25.0 / 255.0, green: 155.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
    /// 圆圈Layer
    private var circle = CAShapeLayer()
    /// 动画结束代理
    weak var delegate: CircleViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(frame: CGRect, _ lineWidth: CGFloat = 3) {
        super.init(frame: frame)
        self.lineWidth = lineWidth
        
        // 贝塞尔曲线起始角度
        let startAngle = CGFloat.pi * -0.5
        // 贝塞尔曲线结束角度
        let endAngle = CGFloat.pi * 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: (frame.height / 2) - 2 , startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circle.path = circlePath.cgPath
        circle.lineCap = CAShapeLayerLineCap.round
        circle.fillColor = UIColor.clear.cgColor
        circle.lineWidth = lineWidth
        self.layer.addSublayer(circle)
    }
    
    /// 圆圈动画
    func strokeChart() {
        
        circle.strokeColor = strokeColor.cgColor
        let pathAnimation = Quick.creatBasicAnimation("strokeEnd", 0, 1, nil, 3, .forwards, false)
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pathAnimation.setValue("strokeEndAnimationcircle", forKey: "circleAnimationKey")
        pathAnimation.delegate = self
        circle.add(pathAnimation, forKey: "strokeEndAnimationCircle")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CircleView: CAAnimationDelegate {
    
    /// 动画结束回调
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.circleAnimationStop()
    }
}
