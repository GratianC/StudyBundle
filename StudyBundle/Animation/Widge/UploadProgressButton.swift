//
//  UploadProgressButton.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/12.
//

import UIKit

class UploadProgressButton: UIButton {

    /// 背景视图
    private var backgroundView = UIView()
    /// 边框视图
    private var borderView = UIView()
    /// titleLabel
    private var reTitleLabel = UILabel()
    /// 圆圈视图
    private var circleView: CircleView?
    /// 蓝色
    private let freshBlue = UIColor(red: 25.0 / 255.0, green: 155.0 / 255.0, blue: 200/0 / 255.0, alpha: 1)
    /// 绿色
    private let freshGreen = UIColor(red: 150.0 / 255.0, green: 203.0 / 255.0, blue: 25.0 / 255.0, alpha: 1)
    private var button_x: CGFloat = 0
    private var button_y: CGFloat = 0
    private var button_w: CGFloat = 0
    private var button_h: CGFloat = 0
    
    init(frame: CGRect, _ buttonTitle: String) {
        
        super.init(frame: frame)
        
        button_x = frame.origin.x
        button_y = frame.origin.y
        button_w = frame.width
        button_h = frame.height
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: button_w, height: button_h)
        backgroundView.backgroundColor = freshBlue
//        backgroundView.isUserInteractionEnabled = false
        
        borderView.frame = CGRect(x: 0, y: 0, width: button_w, height: button_h)
        borderView.backgroundColor = UIColor.clear
        borderView.layer.borderColor = freshGreen.cgColor
        borderView.layer.borderWidth = 3
//        borderView.isUserInteractionEnabled = false
        
        reTitleLabel.frame = CGRect(x: 0, y: 0, width: button_w, height: button_h)
        reTitleLabel.text = buttonTitle
        reTitleLabel.textAlignment = .center
        reTitleLabel.backgroundColor = UIColor.clear
        // 开启自视图的响应之后Button点击事件会回传响应父视图的点击事件，关闭则不会
        // 但是关闭后点击第二次会导致Bad Access(code = 1,···)崩溃，暂时原因不明
        reTitleLabel.isUserInteractionEnabled = true
        
        addSubview(backgroundView)
        addSubview(borderView)
        addSubview(reTitleLabel)
    }
    
    /// 按钮至圆圈起始动画
    private func startAnimationReduce() {
        
        reTitleLabel.removeFromSuperview()
        let cornerAnimation = Quick.creatBasicAnimation("cornerRadius", 5, button_h / 2, nil, 0, .forwards, false)
        let boundsAnimation = Quick.creatBasicAnimation("bounds", nil, CGRect(x: 0, y: 0                                                                                      , width: button_h, height: button_h), nil, 0, .forwards, false)
        let opacityAnimation = Quick.creatBasicAnimation("opacity", nil, 0, nil, 0, .forwards, false)
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.repeatCount = 1
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animationGroup.animations = [cornerAnimation, boundsAnimation, opacityAnimation]
        
        let borderAnimation = Quick.creatBasicAnimation("borderColor", nil, UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 244.0 / 255.0, alpha: 1), nil, 0, .forwards, false)
        let animationGroupAll = CAAnimationGroup()
        animationGroupAll.duration = 1
        animationGroupAll.repeatCount = 1
        animationGroupAll.isRemovedOnCompletion = false
        animationGroupAll.fillMode = .forwards
        animationGroupAll.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animationGroupAll.animations = [cornerAnimation, boundsAnimation, borderAnimation]
        animationGroupAll.delegate = self
        animationGroupAll.setValue("allMyAnimationsBoard", forKey: "groupBorderKey")
        CATransaction.begin()
        backgroundView.layer.add(animationGroup, forKey: "backgroundAnimation")
        borderView.layer.add(animationGroupAll, forKey: "allMyAnimationsBoard")
        CATransaction.commit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        startAnimationReduce()
    }
}

extension UploadProgressButton: CAAnimationDelegate {
    
    /// 动画结束回调
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if (flag) {
            if let animationType = anim.value(forKey: "groupBorderKey") as? String {
                if (animationType == "allMyAnimationsBoard") {
                    circleView = CircleView(frame: self.bounds)
                    circleView!.delegate = self
                    addSubview(circleView!)
                    circleView!.strokeChart()
                }
            }
            if let animationType = anim.value(forKey: "borderAnimationSpreadkey") as? String {
                if (animationType == "buttonAnimationSpread") {
                    reTitleLabel.text = "Complete"
                    addSubview(reTitleLabel)
                }
            }
        }
    }
}

extension UploadProgressButton: CircleViewDelegate {
    
    func circleAnimationStop() {
        circleView?.removeFromSuperview()
        startAnimationSpread()
    }
    
    /// 圆圈至原始按钮动画
    private func startAnimationSpread() {
        
        let cornerAnimation = Quick.creatBasicAnimation("cornerRadius", button_h / 2.0, 0, nil, 0, .forwards, false)
        let boundsAnimation = Quick.creatBasicAnimation("bounds", nil, CGRect(x: 0, y: 0, width: button_w, height: button_h), nil, 0, .forwards, false)
        let opacityAnimation = Quick.creatBasicAnimation("opacity", nil, 1, nil, 0, .forwards, false)
        let backgroundColorAnimation = Quick.creatBasicAnimation("backgroundColor", nil, freshGreen.cgColor, nil, 0, .forwards, false)
        
        let group = CAAnimationGroup()
        group.duration = 1
        group.repeatCount = 1
        group.isRemovedOnCompletion = false
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        group.fillMode = .forwards
        group.animations = [cornerAnimation, boundsAnimation, opacityAnimation, backgroundColorAnimation]
        
        let borderAnimation = Quick.creatBasicAnimation("borderColor", nil, freshGreen.cgColor, nil, 0, .forwards, false)
        let borderAnimationGroup = CAAnimationGroup()
        borderAnimationGroup.duration = 1
        borderAnimationGroup.repeatCount = 1
        borderAnimationGroup.isRemovedOnCompletion = false
        borderAnimationGroup.delegate = self
        borderAnimationGroup.fillMode = .forwards
        borderAnimationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        borderAnimationGroup.animations = [cornerAnimation, boundsAnimation, opacityAnimation, borderAnimation]
        borderAnimationGroup.setValue("buttonAnimationSpread", forKey: "borderAnimationSpreadkey")
        CATransaction.begin()
        backgroundView.layer.add(group, forKey: "backgroundViewSpread")
        borderView.layer.add(borderAnimationGroup, forKey: "borderViewSpread")
        CATransaction.commit()
    }
}
