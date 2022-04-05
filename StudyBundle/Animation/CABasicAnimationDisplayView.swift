//
//  CABasicAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/5.
//

import UIKit

class CABasicAnimationDisplayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
        _ = postionButton
        _ = scaleButton
    }
    
    @objc
    private func remove() {
        removeFromSuperview()
    }
    
    /// 位置动画
    @objc
    private func postionButtonClick() {
        
        // 位置
        let animation = CABasicAnimation()
        animation.keyPath = "position"
        let positionX = postionButton.frame.origin.x + 0.5 * postionButton.frame.size.width
        let positionY = postionButton.frame.origin.y + 0.5 * postionButton.frame.size.height + 100
        // 改变控件原来的位置
//        animation.toValue = NSValue(cgPoint: CGPoint(x: positionX, y: positionY))
        // 在原来位置的基础上移动
        animation.byValue = CGPoint(x: positionX, y: positionY)
        animation.duration = 2.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        postionButton.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func scaleButtonClick() {
        
        // 缩放
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale.x"
        animation.fromValue = 1
        animation.toValue = 0.8
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        scaleButton.layer.add(animation, forKey: nil)
    }
    
    // MAKR: LAZY
    lazy var postionButton: UIButton = {
        let postionButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        postionButton.setTitle("PositionButton", for: .normal)
        postionButton.addTarget(self, action: #selector(postionButtonClick), for: .touchUpInside)
        postionButton.backgroundColor = .blue
        addSubview(postionButton)
        return postionButton
    }()
    
    lazy var scaleButton: UIButton = {
        let scaleButton = UIButton(frame: CGRect(x: 20, y: 70, width: 200, height: 50))
        scaleButton.setTitle("ScaleButton", for: .normal)
        scaleButton.addTarget(self, action: #selector(scaleButtonClick), for: .touchUpInside)
        scaleButton.backgroundColor = .yellow
        addSubview(scaleButton)
        return scaleButton
    }()
}
