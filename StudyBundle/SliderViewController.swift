//
//  SliderViewController.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/28.
//

import UIKit

class SliderViewController: UIViewController {
    
    internal var blurView: UIView?
    internal var contentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        blurView = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        view.addSubview(blurView!)
        contentView = UIView(frame: CGRect(x: -screen_width * 0.6, y: 0, width: screen_width * 0.6, height: screen_height))
        contentView!.backgroundColor = UIColor(red: 255.0 / 255.0, green: 127.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        view.addSubview(contentView!)
    }
    
    func sliderVCDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            self.contentView!.frame = CGRect(x: -screen_width * 0.6, y: 0, width: screen_width * 0.6, height: screen_height)
            self.contentView!.alpha = 0.9
        } completion: { _ in
            self.view.alpha = 0.0
        }
    }
    
    func sliderLeftViewAnimationStart() {
        
        var windowView = UIView()
        windowView = UIApplication.shared.keyWindow!.rootViewController!.view
        blurView?.layer.contents = PictureHandler.blurImageFromImage(image:windowView.imageFromUIView()!)?.cgImage
        self.view.alpha = 1
        UIView.animate(withDuration: 0.5) {
            self.contentView!.frame = CGRect(x: 0, y: 0, width: screen_width * 0.6, height: screen_height)
            self.contentView!.alpha = 0.9
        } completion: { _ in
            
        }

    }
}
