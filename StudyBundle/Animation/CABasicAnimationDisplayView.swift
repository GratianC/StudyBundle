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
        _ = rotationButton
        _ = translationButton
        _ = cornerRadiusButton
        _ = borderWidthButton
        _ = backgroundColorButton
    }
    
    @objc
    private func remove() {
        removeFromSuperview()
    }
    
    /// 位置动画
    @objc
    private func postionButtonClick() {
        
        // 位置
        let positionX = postionButton.frame.origin.x + 0.5 * postionButton.frame.size.width
        let positionY = postionButton.frame.origin.y + 0.5 * postionButton.frame.size.height + 100
        let animation = Quick.creatBasicAnimation("position", nil, nil, CGPoint(x: positionX, y: positionY), 2, .forwards, true)
        animation.keyPath = "position"
        // 改变控件原来的位置
//        animation.toValue = NSValue(cgPoint: CGPoint(x: positionX, y: positionY))
        // 在原来位置的基础上移动
//        animation.byValue = CGPoint(x: positionX, y: positionY)
        postionButton.layer.add(animation, forKey: nil)
    }
    
    /// 缩放动画
    @objc
    private func scaleButtonClick() {
        
        // 缩放
        let animation = Quick.creatBasicAnimation("transform.scale.x", 1, 0.8, nil, 2, .forwards, true)
        scaleButton.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func rotationButtonClick() {
        
        // 旋转
        let animation = Quick.creatBasicAnimation("transform.rotation", nil, CGFloat.pi/2, nil, 2, .forwards, true)
        rotationButton.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func translationButtonClick() {
        
        // 移动
        let animation = Quick.creatBasicAnimation("transform.translation.y", nil, 100, nil, 2, .forwards, true)
        translationButton.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func cornerRadiusButtonClick() {
        
        // 圆角
        let animation = Quick.creatBasicAnimation("cornerRadius", nil, 15, nil, 2, .forwards, true)
        cornerRadiusButton.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func borderWidthButtonClick() {
        
        // 边框
        let animation = Quick.creatBasicAnimation("borderWidth", nil, 10, nil, 2, .forwards, true   )
        borderWidthButton.layer.borderColor = UIColor.gray.cgColor
        borderWidthButton.layer.cornerRadius = 10
        borderWidthButton.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func backgroundColorButtonClick() {
        
        // 颜色渐变
        let animation = Quick.creatBasicAnimation("backgroundColor", UIColor.green.cgColor, UIColor.red.cgColor, nil, 2, .forwards, true)
        backgroundColorButton.layer.add(animation, forKey: "")
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
    
    lazy var rotationButton: UIButton = {
        let rotationButton = UIButton(frame: CGRect(x: 20, y: 120, width: 200, height: 50))
        rotationButton.setTitle("RotationButton", for: .normal)
        rotationButton.addTarget(self, action: #selector(rotationButtonClick), for: .touchUpInside)
        rotationButton.backgroundColor = .gray
        addSubview(rotationButton)
        return rotationButton
    }()
    
    lazy var translationButton: UIButton = {
        let translationButton = UIButton(frame: CGRect(x: 20, y: 170, width: 200, height: 50))
        translationButton.setTitle("TranslationButton", for: .normal)
        translationButton.addTarget(self, action: #selector(translationButtonClick), for: .touchUpInside)
        translationButton.backgroundColor = .red
        addSubview(translationButton)
        return translationButton
    }()
    
    lazy var cornerRadiusButton: UIButton = {
        let cornerRadiusButton = UIButton(frame: CGRect(x: 20, y: 220, width: 200, height: 50))
        cornerRadiusButton.setTitle("CornerRadiusButton", for: .normal)
        cornerRadiusButton.addTarget(self, action: #selector(cornerRadiusButtonClick), for: .touchUpInside)
        cornerRadiusButton.backgroundColor = .black
        addSubview(cornerRadiusButton)
        return cornerRadiusButton
    }()
    
    lazy var borderWidthButton: UIButton = {
        let borderWidthButton = UIButton(frame: CGRect(x: 20, y: 270, width: 200, height: 50))
        borderWidthButton.setTitle("BorderWidthButton", for: .normal)
        borderWidthButton.addTarget(self, action: #selector(borderWidthButtonClick), for: .touchUpInside)
        borderWidthButton.backgroundColor = .green
        addSubview(borderWidthButton)
        return borderWidthButton
    }()
    
    lazy var backgroundColorButton: UIButton = {
        let backgroundColorButton = UIButton(frame: CGRect(x: 20, y: 320, width: 200, height: 50))
        backgroundColorButton.setTitle("BackgroundColorButton", for: .normal)
        backgroundColorButton.addTarget(self, action: #selector(backgroundColorButtonClick), for: .touchUpInside)
        backgroundColorButton.backgroundColor = .purple
        addSubview(backgroundColorButton)
        return backgroundColorButton
    }()
}