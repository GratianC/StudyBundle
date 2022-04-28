//
//  UIView+Ex.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/28.
//

import Foundation
import UIKit

extension UIView {
    
    func imageFromUIView() -> UIImage? {
        
        UIGraphicsBeginImageContext(frame.size)
        if let content = UIGraphicsGetCurrentContext() {
            layer.render(in: content)
            let imageNew = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageNew
        }
        return nil
    }
}
