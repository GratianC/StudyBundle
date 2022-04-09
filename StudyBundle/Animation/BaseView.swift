//
//  BaseView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/9.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        
        backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
    }

    @objc
    private func remove() {
        removeFromSuperview()
    }
    
}
