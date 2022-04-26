//
//  CAReplicatorLayerAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/26.
//

import UIKit

class CAReplicatorLayerAnimationDisplayView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: 414, height: 200)
        replicatorLayer.instanceCount = 20
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        replicatorLayer.instanceDelay = 0.2
        replicatorLayer.masksToBounds = true
        replicatorLayer.backgroundColor = UIColor.black.cgColor
        
        let layer = CALayer()
        layer.frame =  CGRect(x: 14, y: 200, width: 10, height: 100)
        layer.backgroundColor = UIColor.red.cgColor
        replicatorLayer.addSublayer(layer)
        self.layer.addSublayer(replicatorLayer)
        let animation = Quick.creatBasicAnimation("position.y", 200, 180, nil, 0.5, .forwards, false)
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
