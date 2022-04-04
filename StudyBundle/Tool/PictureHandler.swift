//
//  PictureHandler.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import Foundation
import ImageIO
import UIKit

class GIFHandler {
    
    
    /// 拆解GIF文件至UIImage数组
    /// - Parameter fileName: bundle内文件名
    /// - Returns: UIImage数组
    internal class final func resolveGIFToUIImage(_ fileName: String) -> [UIImage]? {
        
        if let gifPath = Bundle.main.path(forResource: fileName, ofType: "gif") {
            if let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) {
                let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, nil)
                guard let _ = gifDataSource else { return nil}
                let gifImageCount = CGImageSourceGetCount(gifDataSource!)
                var imageList = [UIImage]()
                for i in 0...gifImageCount-1 {
                    if let imageRef = CGImageSourceCreateImageAtIndex(gifDataSource!, i, nil) {
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
}
