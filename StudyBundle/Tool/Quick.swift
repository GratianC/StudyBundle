//
//  Quick.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import Foundation
import UIKit

class Quick {

    internal class func creatImageView(_ frame: CGRect, _ image: UIImage?, _ contentMode: UIView.ContentMode, _ backgroundColor: UIColor?) -> UIImageView {
        let view = UIImageView(frame: frame)
        view.image = image
        view.contentMode = contentMode
        view.backgroundColor = backgroundColor
        return view
    }
    
    internal class func creatBasicAnimation(_ keyPath: String, _ fromValue: Any?, _ toValue: Any?, _ byValue: Any?, _ duration: CFTimeInterval, _ fillMode: CAMediaTimingFillMode, _ isRemovedOnCompletion: Bool) -> CABasicAnimation {
        
        let animation = CABasicAnimation()
        animation.keyPath = keyPath
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.byValue = byValue
        animation.duration = duration
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        return animation
    }
    
    internal class func creatKeyframeAnimation(_ keyPath: String, _ values: [Any]?, _ duration: CFTimeInterval, _ fillMode: CAMediaTimingFillMode, _ path: CGPath?, _ isRemovedOnCompletion: Bool) -> CAKeyframeAnimation {
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = keyPath
        animation.values = values
        animation.fillMode = fillMode
        animation.path = path
        animation.duration = duration
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        return animation
    }
}
