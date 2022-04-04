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
}
