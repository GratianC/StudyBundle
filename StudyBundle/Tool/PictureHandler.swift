//
//  PictureHandler.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import Foundation
import ImageIO
import UIKit
import MobileCoreServices
import Accelerate

class PictureHandler {
    
    
    /// 拆解GIF文件至UIImage数组
    /// - Parameter fileName: bundle内文件名
    /// - Returns: UIImage数组
    internal class final func resolveGIFToUIImage(_ fileName: String) -> [UIImage]? {
        
        if let gifPath = Bundle.main.path(forResource: fileName, ofType: "gif") {
            if let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) {
                // 由于Swift是ARC的关系,不加optionsDic也不会导致CGImageRef占用缓存得不到释放
                let optionsDic = [kCGImageSourceShouldCache : kCFBooleanFalse]
                let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, optionsDic as CFDictionary)
                guard let _ = gifDataSource else { return nil}
                let gifImageCount = CGImageSourceGetCount(gifDataSource!)
                var imageList = [UIImage]()
                for i in 0...gifImageCount-1 {
                    if let imageRef = CGImageSourceCreateImageAtIndex(gifDataSource!, i, optionsDic as CFDictionary) {
                        let image = UIImage(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up)
                        imageList.append(image)
                    }
                }
                return imageList
            }
        }
        return nil
    }
    
    /// 拆解GIF文件成逐帧图片
    /// - Parameter fileName: 文件名
    internal class final func resolveGIFToLocal(_ fileName:String) {
        
        // 获取目标图片地址
        if let gifPath = Bundle.main.path(forResource: fileName, ofType: "gif") {
            // 转化为ImageIO使用的数据类型
            if let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) {
                let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, nil)
                guard let _ = gifDataSource else { return }
                // 获取gif图片张数
                let gifImageCount = CGImageSourceGetCount(gifDataSource!)
                // 获取应用Document目录
                let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                for i in 0...gifImageCount-1 {
                    // 返回Gif中某一帧图片的CGImage类型数据,参数1为GIF原始数据,参数2为GIF子帧序号,参数3为GIF数据提取选择参数
                    if let imageRef = CGImageSourceCreateImageAtIndex(gifDataSource!, i, nil) {
                        // 参数1为构建UIImage的内容,参数2为手机物理像素和手机显示分辨率的换算系数,参数3为UIImage的图像方向，
                        // 通过这个方法就可以在某种手机分辨率下构建制定方向的图像
                        let image = UIImage(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up)
                        // 将image数据类型存储为PNG格式的data数据
                        if let imageData = image.pngData() {
                            let imagePath = documentDirectory + "/\(i).png"
                            try? imageData.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
                        }
                    }
                }
            }
        }
    }
    
    internal class final func composeGIFImage() {
        
        // 读取所需要图片,读取asset占用缓存
        // imageName 的缺点
        // 第一次读取的图片保存到缓冲区, 然后永不销毁. 如果这个图片过大, 占用几百 kb, 这一块的内存将不会释放, 必然导致内存的浪费, 而且这个浪费的周期与APP的生命周期同步.
        // imageWithContentsOfFile:
        // 或initWithContentsOfFile:方法创建一个图像对象，其中初始数据不在包中。
        // 这些方法每次从磁盘加载图像数据，因此不应该使用它们重复加载相同的图像。
        var imageList = [UIImage]()
        for i in 0...69 {
            if let image = name_image("\(i)") {
                imageList.append(image)
            }
        }
        // 获取应用Document目录
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let gifPath = documentDirectory + "/meme.gif"
        let url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, gifPath as CFString, .cfurlposixPathStyle, false)
        // 创建GIF文件
        // 方法的作用是创建一个图片的目标,描述了够成当前图片目标对象的一系列参数,如URL地址，图片类型，图片帧数，配置参数等
        guard let destion = CGImageDestinationCreateWithURL(url!, kUTTypeGIF , imageList.count, nil) else {
            return
        }
        // 设置GIF图片属性
        // 每帧之间播放时间为0.1
        let cgimagePropertiesDic = [kCGImagePropertyGIFDelayTime : 0.1]
        let cgimagePropertiesDestDic = [kCGImagePropertyGIFDictionary : cgimagePropertiesDic]
        // 依次为GIF图片对象添加每一帧元素
        for image in imageList {
            CGImageDestinationAddImage(destion, image.cgImage!, cgimagePropertiesDestDic as CFDictionary)
        }
        var gifPropertiesDic = [String : Any]()
        gifPropertiesDic.updateValue(kCGImagePropertyColorModelRGB, forKey: kCGImagePropertyColorModel as String)
        gifPropertiesDic.updateValue(16, forKey: kCGImagePropertyDepth as String)
        gifPropertiesDic.updateValue(1, forKey: kCGImagePropertyGIFLoopCount as String)
        CGImageDestinationSetProperties(destion, gifPropertiesDic as CFDictionary)
        CGImageDestinationFinalize(destion)
    }
    
    internal class func blurImageFromImage(image: UIImage) -> UIImage? {
        
        let blurRadix: UInt32 = 7
        
        if let img = image.cgImage,  let inProvider: CGDataProvider = img.dataProvider, let bitmapData: CFData = inProvider.data {
            var inputBuffer = vImage_Buffer()
            inputBuffer.data = (UnsafeMutableRawPointer)(mutating: CFDataGetBytePtr(bitmapData))
            inputBuffer.width = (vImagePixelCount)(img.width)
            inputBuffer.height = (vImagePixelCount)(img.height)
            inputBuffer.rowBytes = img.bytesPerRow
            let pixelBuffer = malloc(img.bytesPerRow * img.height)
            var outputBuffer = vImage_Buffer()
            outputBuffer.data = pixelBuffer
            outputBuffer.width = (vImagePixelCount)(img.width)
            outputBuffer.height = (vImagePixelCount)(img.height)
            outputBuffer.rowBytes = img.bytesPerRow
            vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, nil, 0, 0, blurRadix, blurRadix, nil, UInt32(kvImageEdgeExtend))
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let w: Int = (Int)(outputBuffer.width)
            let h: Int = (Int)(outputBuffer.height)
            if let ctx: CGContext = CGContext (data: outputBuffer.data, width: w, height: h, bitsPerComponent: 8, bytesPerRow: outputBuffer.rowBytes, space: colorSpace, bitmapInfo:img.bitmapInfo.rawValue, releaseCallback: nil, releaseInfo: nil), let imageRef = ctx.makeImage() {
                let imageNew = UIImage(cgImage: imageRef)
                free(pixelBuffer)
                return imageNew
            }
            free(pixelBuffer)
            return nil
        }
        return nil
    }
}
