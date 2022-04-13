//
//  WaterRipleButton.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/12.
//

import UIKit

class WaterRipleButton: UIButton {
    
    /// 水波纹半径
    private var viewRaidus: CGFloat = 0
    /// 已执行次数
    private var countNum = 0
    /// 动画执行定时器
    private var timer: Timer?
    /// 动画起始点X
    private var circleCenterX: CGFloat = 0
    /// 动画起始点Y
    private var circleCenterY: CGFloat = 0
    /// 动画颜色
    private var targetAnimationColor = UIColor(red: 216.0/255.0, green: 114.0/255.0, blue: 213.0/255.0, alpha: 0.8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 50/255.0, green: 185/255.0, blue: 17/255.0, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startRipleAnimation(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isUserInteractionEnabled = false
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            circleCenterX = touchPoint.x
            circleCenterY = touchPoint.y
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .default)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        if let ctx = UIGraphicsGetCurrentContext() {
            let endAngle = CGFloat.pi * 2
            ctx.addArc(center: CGPoint(x: circleCenterX, y: circleCenterY), radius: viewRaidus, startAngle: 0, endAngle: endAngle, clockwise: false)
            targetAnimationColor.setStroke()
            targetAnimationColor.setFill()
            ctx.fillPath()
        }
    }
    
    /// 定时器任务
    @objc
    private func timerAction() {
        
        countNum += 1
        let disMissTime = DispatchTime.now() + Double(Int(0*NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: disMissTime) {
            self.viewRaidus += 5
            self.setNeedsDisplay()
        }
        if (countNum>50) {
            countNum = 0
            viewRaidus = 0
            timer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: disMissTime) {
                self.viewRaidus = 0
                self.setNeedsDisplay()
            }
            self.isUserInteractionEnabled = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        startRipleAnimation(touches, with: event)
    }
}
