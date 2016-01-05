//
//  FSHelpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 08.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//


import UIKit

//MARK: - Application Directory

public func FSApplicationDirectoryPath (directoryToSearch:NSSearchPathDirectory) -> String {
    return NSSearchPathForDirectoriesInDomains(directoryToSearch, NSSearchPathDomainMask.UserDomainMask, true).first!
}

public func FSApplicationDirectoryURL (directoryToSearch:NSSearchPathDirectory) -> NSURL {
    return NSURL(string: FSApplicationDirectoryPath(directoryToSearch))!
}

//MARK: - Interface

public let FSScreenBounds: CGRect = UIScreen.mainScreen().bounds

public func FSIsIPad () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
}

public func FSIsIPhone () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
}

public func FSScaleFactor () -> CGFloat {
    return UIScreen.mainScreen().scale
}

public func FSIsRetina () -> Bool {
    return FSScaleFactor() == 2
}

public func FSDeviceOrientation () -> UIDeviceOrientation {
    return UIDevice.currentDevice().orientation
}

//MARK: - System Version

public func FSSystemVersionEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

public func FSSystemVersionGreatherThan(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

public func FSSystemVersionGreatherThanOrEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

public func FSSystemVersionLessThan(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

public func FSSystemVersionLessThanOrEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}

//MARK: - Images and colors

public func FSRGBA (r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}

public func FSImageFromColor (color:UIColor) -> UIImage {
    
    let rect:CGRect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    let context:CGContextRef = UIGraphicsGetCurrentContext()!
    
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    
    let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

public func FSRandomColor () -> UIColor {
    let red     = CGFloat(arc4random_uniform(255))/255.0
    let green   = CGFloat(arc4random_uniform(255))/255.0
    let blue    = CGFloat(arc4random_uniform(255))/255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}

//MARK: - GCD

public func FSDispatch_after_short (delay:Double, block:dispatch_block_t) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block);
}

//MARK: - Other

public func FSGetInfoDictionaryValue (key: String) -> AnyObject? {
    return NSBundle.mainBundle().infoDictionary?[key]
}

public func FSDLog(message: String, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
    #if DEBUG
        print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}
