//
//  CAGradientAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/19.
//

import UIKit

enum GratidentDisplayType: Int {
    case Scan = 0
    case Note
}

class CAGradientAnimationDisplayView: BaseView {
    
    private var layerArray = [CAGradientLayer]()
    private var colorArray = [UIColor]()
    init(frame: CGRect, _ type: inout GratidentDisplayType) {
        super.init(frame: frame)
        
        if (type == .Scan) {
            type = .Note
            let color1 = UIColor.randomColor
            let color2 = UIColor.randomColor
            let color3 = UIColor.randomColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.frame
            gradientLayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
            gradientLayer.locations = [0.0, 0.1, 0.2]
            let gradientAnimation = Quick.creatBasicAnimation("locations", [0.0, 0.1, 0.2], [0.8, 0.9, 1.0], nil, 3, .forwards, false)
            gradientAnimation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
            gradientLayer.add(gradientAnimation, forKey: nil)
            layer.addSublayer(gradientLayer)
        } else {
            type = .Scan

            let audioBarNum = 15
            for i in 0...audioBarNum {
                colorArray.append(UIColor.randomColor)
                let h: CGFloat = 150
                let w: CGFloat = (frame.width - 10) / CGFloat(audioBarNum)
                let x: CGFloat = 20
                let y: CGFloat = 50
                let view = UIView(frame: CGRect(x: w * CGFloat(i) + x, y: y, width: w - x, height: h))
                addSubview(view)
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = view.bounds
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 0, y: 1)
                view.layer.addSublayer(gradientLayer)
                layerArray.append(gradientLayer)
            }
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(colorChange), userInfo: nil, repeats: true)
        }
    }
    
    @objc
    private func colorChange() {
        for layer in layerArray {
            let index = Int(arc4random_uniform(15))
            let color = colorArray[index]
            let colors = [UIColor.clear.cgColor, color.cgColor]
            let layer = layer
            layer.colors = colors
            layer.locations = [0.0, 1.0]
            let beginValue = Float(arc4random() % 10) / Float(10)
            let gradientAnimation = Quick.creatBasicAnimation("locations", [beginValue, beginValue], [1.0, 1.0], nil, 0.4, .forwards, false)
            layer.add(gradientAnimation, forKey: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
