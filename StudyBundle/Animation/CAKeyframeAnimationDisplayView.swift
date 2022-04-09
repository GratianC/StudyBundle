//
//  CAKeyframeAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/9.
//

import UIKit

class CAKeyframeAnimationDisplayView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        _ = opacityButton
        _ = pathButton
        _ = groupButton
    }
    
    @objc
    private func opacityButtonClick() {
        
        let values = [0.95, 0.9, 0.88, 0.85, 0.35, 0.05, 0.00]
        let animation = Quick.creatKeyframeAnimation("opacity", values, 3, .forwards, nil, true)
        opacityButton.layer.add(animation, forKey: nil)
    }

    @objc
    private func pathButtonClick() {
        
        let pathLine = CGMutablePath()
        pathLine.move(to: CGPoint(x: 50, y: 50))
//        pathLine.addLine(to: CGPoint(x: 300, y: 50))
        pathLine.addArc(center: CGPoint(x: 200, y: 200), radius: 150, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
//        let animation = Quick.creatKeyframeAnimation("position", nil, 2, .forwards, pathLine, true)
        let animation = Quick.creatKeyframeAnimation("position", nil, 2, .forwards, pathLine, true)
        pathButton.layer.add(animation, forKey: nil)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.addArc(center: self.center, radius: 25 / 2, startAngle: CGFloat.pi , endAngle: CGFloat.pi*2, clockwise: false)
            ctx.setLineWidth(2)
            UIColor.randomColor.set()
            ctx.strokePath()
        }
    }
    
    @objc
    private func groupButtonClick() {
        
        let rotate = Quick.creatBasicAnimation("transform.rotation", nil, CGFloat.pi, nil, 0, .forwards, true)
        let scale = Quick.creatBasicAnimation("transform.scale", nil, 0.0, nil, 0, .forwards, true)
        let move = Quick.creatBasicAnimation("transform.translation", nil, CGPoint(x: 217, y: -230), nil, 0, .forwards, true)
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [rotate, scale, move]
        animationGroup.duration = 2
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = true
        groupButton.layer.add(animationGroup, forKey: nil)
    }
  
    // MARK: LAZY
    lazy var opacityButton: UIButton = {
        let postionButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        postionButton.setTitle("Opacity", for: .normal)
        postionButton.addTarget(self, action: #selector(opacityButtonClick), for: .touchUpInside)
        postionButton.backgroundColor = .blue
        addSubview(postionButton)
        return postionButton
    }()
    
    lazy var pathButton: UIButton = {
        let pathButton = UIButton(frame: CGRect(x: 20, y: 70, width: 200, height: 50))
        pathButton.setTitle("Path", for: .normal)
        pathButton.addTarget(self, action: #selector(pathButtonClick), for: .touchUpInside)
        pathButton.backgroundColor = .randomColor
        addSubview(pathButton)
        return pathButton
    }()
    
    lazy var groupButton: UIButton = {
        let groupButton = UIButton(frame: CGRect(x: 20, y: 120, width: 200, height: 50))
        groupButton.setTitle("Group", for: .normal)
        groupButton.addTarget(self, action: #selector(groupButtonClick), for: .touchUpInside)
        groupButton.backgroundColor = .randomColor
        addSubview(groupButton)
        return groupButton
    }()

}
