//
//  CATransform3DCoverFlowAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/26.
//

import UIKit

class CATransform3DCoverFlowAnimationDisplayView: BaseView {

    let imageView1 = Quick.creatImageView(CGRect(x: 100, y: 100, width: 200, height: 250), name_image("0"), .scaleAspectFill, .clear)
    let imageView2 = Quick.creatImageView(CGRect(x: 100, y: 100, width: 200, height: 250), name_image("1"), .scaleAspectFill, .clear)
    let imageView3 = Quick.creatImageView(CGRect(x: 100, y: 150, width: 300, height: 200), name_image("2"), .scaleAspectFill, .clear)
    var imageViewArray: [UIImageView]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        imageViewArray = [imageView1, imageView2, imageView3]
        for i in imageViewArray! {
            i.layer.anchorPoint.y = 0.0
            addSubview(i)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        for i in 0..<imageViewArray!.count {
            var imageTransform = CATransform3DIdentity
            imageTransform.m34 = -0.005
            imageTransform = CATransform3DTranslate(imageTransform, 0.0, 50.0, 0.0)
            imageTransform = CATransform3DScale(imageTransform, 0.95, 0.6, 1.0)
            
            if i == 0 {
                imageTransform = CATransform3DRotate(imageTransform, CGFloat.pi / 8, 0.0, 1.0, 0.0)
            } else if i == 1 {
                imageTransform = CATransform3DRotate(imageTransform, -CGFloat.pi / 8, 0.0, 1.0, 0.0)
            }
            let imageView = imageViewArray![i]
            let animation = Quick.creatBasicAnimation("transform", NSValue(caTransform3D: imageView.layer.transform), NSValue(caTransform3D: imageTransform), nil, 0.5, .forwards, false)
            
            let animationBounds = CABasicAnimation()
            animationBounds.keyPath = "position"
            if i == 0 {
                animationBounds.toValue = NSValue(cgPoint: CGPoint(x: 100, y: 10))
            } else if i == 1 {
                animationBounds.toValue = NSValue(cgPoint: CGPoint(x: 300, y: 10))
            } else {
                animationBounds.toValue = NSValue(cgPoint: CGPoint(x: 200, y: 20))
            }
            let animGroup = CAAnimationGroup()
            animGroup.duration = 0.5
            animGroup.repeatCount = 1
            animGroup.isRemovedOnCompletion = false
            animGroup.fillMode = .forwards
            animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animGroup.animations = [animation, animationBounds]
            imageView.layer.add(animGroup, forKey: "\(i)")
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
