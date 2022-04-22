//
//  CAShapeLayerAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/19.
//

import UIKit

class CAShapeLayerAnimationDisplayView: BaseView {

    private enum ShapeType: Int {
        case LineChar = 0
        case BarChart
    }
    
    private var greenColor = UIColor(red: 77.0 / 255.0, green: 186.0 / 255.0, blue: 122.0 / 255.0, alpha: 1)
    private var charLineLayer = CAShapeLayer()
    private var type = ShapeType.BarChart
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        charLineLayer.lineCap = CAShapeLayerLineCap.round
        charLineLayer.lineJoin = CAShapeLayerLineJoin.round
        charLineLayer.fillColor = UIColor.white.cgColor
        charLineLayer.lineWidth = 10
        charLineLayer.strokeEnd = 0.0
        layer.addSublayer(charLineLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final internal func drawLineChart() {
       
        charLineLayer.strokeEnd = 1
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if (type == .LineChar) {
            let line = UIBezierPath()
            line.lineWidth = 10.0
            line.lineCapStyle = CGLineCap.round
            line.lineJoinStyle = CGLineJoin.round
            line.move(to: CGPoint(x: 70, y: 260))
            line.addLine(to: CGPoint(x: 140, y: 100))
            line.addLine(to: CGPoint(x: 210, y: 240))
            line.addLine(to: CGPoint(x: 280, y: 170))
            line.addLine(to: CGPoint(x: 350, y: 220))
            charLineLayer.path = line.cgPath
            charLineLayer.strokeColor = greenColor.cgColor
            let pathAnimation = Quick.creatBasicAnimation("strokeEnd", 0.5, 1.0, nil, 2, .forwards, false)
            pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            charLineLayer.add(pathAnimation, forKey: nil)
        } else if (type == .BarChart) {
            let line = UIBezierPath()
            line.lineWidth = 30
            line.lineCapStyle = .square
            line.lineJoinStyle = .round
            for i in 0...4 {
                let x: CGFloat = CGFloat(60 + 70 * i)
                let y: CGFloat = CGFloat(100 + 20 * i)
                line.move(to: CGPoint(x: x, y: 215))
                line.addLine(to: CGPoint(x: x, y: y))
            }
            charLineLayer.path = line.cgPath
            charLineLayer.strokeColor = greenColor.cgColor
            let pathAnimation = Quick.creatBasicAnimation("strokeEnd", 0.0, 1.0, nil, 2, .forwards, false)
            pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            charLineLayer.add(pathAnimation, forKey: nil)
 
        }
    }
}
