//
//  FSE+UIImage.swift
//  Swift-Base
//
//  Created by Kruperfone on 23.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

public extension UIImage {
    
    convenience public init(fs_color color: UIColor) {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        UIGraphicsEndImageContext()
        let image = context.makeImage()!
        self.init(cgImage: image)
    }
    
    public func fs_aspectFillImageWithSize(_ size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let scale = max(size.width / self.size.width, size.height / self.size.height)
        let newSize = CGSize(width: ceil(self.size.width * scale), height: ceil(self.size.height * scale))
        let frame = CGRect(x: ceil((size.width - newSize.width) / 2.0),
                               y: ceil((size.height - newSize.height) / 2.0),
                               width: newSize.width,
                               height: newSize.height)
        self.draw(in: frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func fs_aspectFitImageWithSize(_ size: CGSize) -> UIImage {
        let scale = min(size.width / self.size.width, size.height / self.size.height)
        let targetSize = CGSize(width: ceil(self.size.width * scale), height: ceil(self.size.height * scale))
        
        return self.fs_aspectFillImageWithSize(targetSize)
    }
    
    public final func fs_scaled(toSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        self.draw(in: CGRect(x: 0.0,
                             y: 0.0,
                             size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    public final func fs_scaled(toWidth width: CGFloat) -> UIImage? {
        let scaleFactor = width / self.size.width
        
        let scaledSize: CGSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)
        
        UIGraphicsBeginImageContext(scaledSize)
        
        self.draw(in: CGRect(x: 0.0,
                             y: 0.0,
                             size: scaledSize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    public var fs_base64: String {
        let imageData = self.pngData()!
        let base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
}
