//
//  Quick.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import Foundation
import UIKit

class Quick {

    /// 创建一个ImageView视图
    internal class func creatImageView(_ frame: CGRect, _ image: UIImage?, _ contentMode: UIView.ContentMode, _ backgroundColor: UIColor?) -> UIImageView {
        let view = UIImageView(frame: frame)
        view.image = image
        view.contentMode = contentMode
        view.backgroundColor = backgroundColor
        return view
    }
    
    /// 创建一个BasicAnimation
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
    
    /// 创建一个KeyframeAnimation
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
    
    /// 创建一个AnimationGroup
    internal class func creatAnimationGroup(_ duration: CFTimeInterval, _ repeatCount: Float = 1, _ isRemovedOnCompletion: Bool, _ delegate: CAAnimationDelegate?, _ fillMode: CAMediaTimingFillMode, _ timingFunction: CAMediaTimingFunction?, _ animations: [CAAnimation]) -> CAAnimationGroup {
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.repeatCount = repeatCount
        group.isRemovedOnCompletion = isRemovedOnCompletion
        group.delegate = delegate
        group.fillMode = fillMode
        group.timingFunction = timingFunction
        group.animations = animations
        return group
    }
    
    /// 创建一个EmitterCell
    /// - Parameters:
    ///   - name: cell名称
    ///   - emissionLongtitude: 指定了纬度,纬度角代表了x-z轴平面上与x轴之间的夹角
    ///   - velocity: 粒子速度
    ///   - velocityRange: 粒子速度范围
    ///   - emissionRange: 发射器发射角度
    ///   - yAcceleration: y方向加速度分量
    ///   - scaleSpeed: 缩放比例
    ///   - color: 粒子的颜色,默认白色
    ///   - contents: 粒子内容，一般为CGImageRef
    /// - Returns: 一个EmitterCell
    internal class func creatEmitterCell(_ name: String, _ emissionLongtitude: CGFloat, _ velocity: CGFloat, _ velocityRange: CGFloat, _ emissionRange: CGFloat, _ yAcceleration: CGFloat, _ scaleSpeed: CGFloat, _ color: CGColor?, _ contents: Any?) -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        cell.name = name
        cell.emissionLongitude = emissionLongtitude
        cell.velocity = velocity
        cell.velocityRange = velocityRange
        cell.yAcceleration = yAcceleration
        cell.scaleSpeed = scaleSpeed
        cell.emissionRange = emissionRange
        cell.color = color
        cell.contents = contents
        return cell
    }
    
    /// 创建一个EmitterLayer
    internal class func creatEmitterLayer(_ position: CGPoint, _ emitterSize: CGSize, _ renderMode: CAEmitterLayerRenderMode, _ emitterMode: CAEmitterLayerEmitterMode, _ emitterShape: CAEmitterLayerEmitterShape, _ cells: [CAEmitterCell]) -> CAEmitterLayer {
        
        let layer = CAEmitterLayer()
        layer.position = position
        layer.emitterSize = emitterSize
        layer.renderMode = renderMode
        layer.emitterMode = emitterMode
        layer.emitterShape = emitterShape
        layer.emitterCells = cells
        return layer
    }
}
