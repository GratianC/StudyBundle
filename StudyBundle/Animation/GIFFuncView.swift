//
//  GIFFuncView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import UIKit

class GIFFuncView: UIView {
    
   
    
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
        _ = gifResolveButton
        _ = gifComposeButton
        _ = gifPresentButton
    }
    
    @objc
    private func remove() {
        removeFromSuperview()
    }
    
    @objc
    private func gifResolveButtonClick() {
        PictureHandler.resolveGIFToLocal("meme1")
    }
    
    @objc
    private func gifComposeButtonClick() {
        PictureHandler.composeGIFImage()
    }

    @objc
    private func gifPresentButtonClick() {
        
        /// 动图展示数组
        let imageList = PictureHandler.resolveGIFToUIImage("meme1")
        gifDisplayView.animationImages = imageList
        gifDisplayView.animationDuration = 5
        gifDisplayView.animationRepeatCount = 1
        gifDisplayView.startAnimating()
    }
    
    // MARK: LAZY
    
    lazy var gifResolveButton: UIButton = {
        let gifResolveButton = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        gifResolveButton.setTitle("gifResolveButton", for: .normal)
        gifResolveButton.addTarget(self, action: #selector(gifResolveButtonClick), for: .touchUpInside)
        gifResolveButton.backgroundColor = .gray
        addSubview(gifResolveButton)
        return gifResolveButton
    }()
    
    lazy var gifComposeButton: UIButton = {
        let gifComposeButton = UIButton(frame: CGRect(x: 20, y: 70, width: 200, height: 50))
        gifComposeButton.setTitle("gifComposeButton", for: .normal)
        gifComposeButton.addTarget(self, action: #selector(gifComposeButtonClick), for: .touchUpInside)
        gifComposeButton.backgroundColor = .orange
        addSubview(gifComposeButton)
        return gifComposeButton
    }()
    
    lazy var gifPresentButton: UIButton = {
       let gifPresentButton = UIButton(frame: CGRect(x: 20, y: 120, width: 200, height: 50))
        gifPresentButton.setTitle("gifPresentButton", for: .normal)
        gifPresentButton.addTarget(self, action: #selector(gifPresentButtonClick), for: .touchUpInside)
        gifPresentButton.backgroundColor = .blue
        addSubview(gifPresentButton)
        return gifPresentButton
    }()
    
    lazy var gifDisplayView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 200, y: 180, width: 200, height: 200))
        addSubview(imageView)
        return imageView
    }()
}
