//
//  AutoScrollView.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import UIKit

enum ScrollBackgroundContentSizeMode {
    case origion
    case screen
}

///自动滚动背景视图
@objc class AutoScrollBackgroundView: UIView {
    
    ///滚动使用图片数组
    var images: [UIImage]?
    ///左右视图滚动比例
    var ratio: [CGFloat]?
    ///供扩展内容Size配置项
    var mode: ScrollBackgroundContentSizeMode = .origion
    ///定时器
    var _timer: Timer?
    ///左边滚动视图图片的高度
    var leftImgHeight: CGFloat = 0
    ///右边滚动视图图片的高度
    var rightImgHeight: CGFloat = 0
    ///左边最大滚动OffsetY值
    var leftMaxOffsetY: CGFloat = 0
    ///右边最大滚动OffserY值，本View右边采用减Y值滚动
    var rightMaxOffsetY: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        checkArguments()
        setupView()
    }
    
    ///有复用需求时可以增加配置项
    init(frame: CGRect, images: [UIImage]?, ratio: [CGFloat] = [0.4, 0.4], mode : ScrollBackgroundContentSizeMode?) {
        super.init(frame: frame)
        self.images = images
        self.ratio = ratio
        if let next = mode { self.mode = next }
        checkArguments()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///配置滚动视图
    func setupView() {
        
        if (mode == .origion ) {
            let width = screen_width / 2
            scrollLeft.frame = CGRect(x: 0, y: 0, width: width, height: screen_height)
            scrollRight.frame = CGRect(x: width, y: 0, width: width, height: screen_height)
            
            scrollLeft.showsVerticalScrollIndicator = false
            scrollLeft.showsHorizontalScrollIndicator = false
            scrollRight.showsVerticalScrollIndicator = false
            scrollRight.showsHorizontalScrollIndicator = false
            
            let image1 = images![0]
            let image2 = images![1]
            // 获取伸缩后实际图片高度
            leftImgHeight =  (width *  image1.size.height)/image1.size.width
            rightImgHeight =  (width * image2.size.height)/image1.size.width
            
            for i in 0...1 {
                scrollLeft.addSubview(Quick.creatImageView(CGRect(x: 0, y: CGFloat(i) * leftImgHeight, width: scrollLeft.bounds.width, height: leftImgHeight), image1, .scaleAspectFill, .clear))
                scrollRight.addSubview(Quick.creatImageView(CGRect(x: 0, y: CGFloat(i) * rightImgHeight, width: scrollRight.bounds.width, height: rightImgHeight), image2, .scaleAspectFill, .clear))
            }
            
            let leftOffsetByRatio = leftImgHeight * ratio![0]
            let rightOffsetByRatio = rightImgHeight * ratio![1] + rightImgHeight
            scrollLeft.contentOffset = CGPoint(x: 0, y: leftOffsetByRatio)
            scrollRight.contentOffset = CGPoint(x: 0, y: rightOffsetByRatio)
            
            leftMaxOffsetY = leftOffsetByRatio + leftImgHeight
            rightMaxOffsetY = rightOffsetByRatio - rightImgHeight
        }
    }
    
    ///检查滚动视图图片以及比例配置项，暂时采用默认配置
    func checkArguments() {
        
        guard let nextImgs = images, let nextRatio = ratio, nextImgs.count == nextRatio.count else {
            images = [name_image("image_left")!, name_image("image_right")!]
            ratio = [0.0, 0.0]
            return
        }
    }
    
    ///加入父视图时启动定时器
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        _timer = Timer(timeInterval: 0.1, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
        RunLoop.current.add(_timer!, forMode: .default)
    }
    
    ///移出父视图停止定时器
    override func removeFromSuperview() {
        super.removeFromSuperview()
        _timer?.invalidate()
        _timer = nil
    }
    
    ///定时器滚动事件
    @objc func scroll() {
        
        if (self.scrollLeft.contentOffset.y < leftMaxOffsetY) {
            scrollLeft .setContentOffset(CGPoint(x:0, y:scrollLeft.contentOffset.y + 10), animated: true)
        } else {
            scrollLeft.setContentOffset(CGPoint(x: 0, y: scrollLeft.contentOffset.y - leftImgHeight), animated: false)
        }
        
        if (scrollRight.contentOffset.y > rightMaxOffsetY) {
            scrollRight .setContentOffset(CGPoint(x:0, y:scrollRight.contentOffset.y - 10), animated: true)
        } else {
            scrollRight.setContentOffset(CGPoint(x: 0, y: scrollRight.contentOffset.y + rightImgHeight), animated: false)
        }
    }
    
    
    
    //MARK: LAZY
    ///左边滚动视图
    lazy var scrollLeft: UIScrollView = {
        let scrollLeft = UIScrollView()
        scrollLeft.isUserInteractionEnabled = false
        addSubview(scrollLeft)
        return scrollLeft
    }()
    
    ///右边滚动视图
    lazy var scrollRight: UIScrollView = {
       let scrollRight = UIScrollView()
        scrollRight.isUserInteractionEnabled = false
        addSubview(scrollRight)
        return scrollRight
    }()
}
