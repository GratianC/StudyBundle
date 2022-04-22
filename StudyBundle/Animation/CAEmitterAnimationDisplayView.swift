//
//  CAEmitterAnimationDisplayView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/14.
//

import UIKit

enum EmitterType: Int {
    case Flame = 0
    case Neno
}

class CAEmitterAnimationDisplayView: BaseView {

    init(frame: CGRect, _ type: inout EmitterType) {
        
        super.init(frame: frame)
        backgroundColor = .black
        if (type == .Flame) {
            type = .Neno
        let emitterCell = Quick.creatEmitterCell("fire", 0, 0, 300, CGFloat.pi, 200, 0.3, UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.8).cgColor, UIImage(named: "emitterParticle")?.cgImage)
        emitterCell.birthRate = 200;  //每秒创建20个雪花
        emitterCell.lifetime = 3.5;  //在屏幕上保持3.5秒
        let emitterLayer = Quick.creatEmitterLayer(CGPoint(x: screen_width/2, y: 50), CGSize(width: screen_width , height: 50), .additive, .outline, .point, [emitterCell])
        self.layer.addSublayer(emitterLayer)
//        emitterLayer.setValue(150, forKey: "emitterCells.fire.birthRate")
//        emitterLayer.setValue(3.5, forKey: "emitterCells.fire.lifetime")
        } else if (type == .Neno) {
            type = .Flame
//            let emitterCell = Quick.creatEmitterCell("nenoLight", CGFloat.pi, 50, 50, 0, 0, 0.1, UIColor.white.cgColor, name_image("emitterParticle")?.cgImage)
//            emitterCell.scaleSpeed = -0.2
//            emitterCell.scale = 0.1
//            emitterCell.greenSpeed = -0.1
//            emitterCell.redSpeed = -0.2
//            emitterCell.blueSpeed = 0.1
//            emitterCell.alphaSpeed = -0.2
//            emitterCell.birthRate = 100
//            emitterCell.lifetime = 4
//            let emitterLayer = Quick.creatEmitterLayer(self.center, CGSize(width: 2, height: 2), .backToFront, .outline, .circle, [emitterCell])
//            layer.addSublayer(emitterLayer)
            
            layer.contents = name_image("emitterBackground")?.cgImage
            contentMode = .scaleAspectFill
            
            var cellArray = [CAEmitterCell]()
            for i in 0...3 {
                let flowerCell = CAEmitterCell()
                flowerCell.birthRate = 2
                flowerCell.lifetime = 50
                flowerCell.velocity = 15
                flowerCell.velocityRange = 5
                flowerCell.yAcceleration = 5
                flowerCell.spin = 1
                flowerCell.spinRange = 2
                flowerCell.emissionRange = CGFloat.pi
                flowerCell.contents = name_image("emitterFlower_\(i)")?.cgImage
                flowerCell.scale = 1.5
                flowerCell.scaleRange = 0.2
                cellArray.append(flowerCell)
            }
            let emitterLayer = Quick.creatEmitterLayer(CGPoint(x: screen_width/2, y: 50), CGSize(width: screen_width, height: 0), .backToFront, .volume, .sphere, cellArray)
            layer.addSublayer(emitterLayer)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
