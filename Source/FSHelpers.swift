//
//  FSHelpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 08.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//


import UIKit

//MARK: - Application Directory

public enum FSAppDirectory {
    public static func Path (directoryToSearch: NSSearchPathDirectory) -> String {
        return NSSearchPathForDirectoriesInDomains(directoryToSearch, NSSearchPathDomainMask.UserDomainMask, true).first!
    }
    
    public static func URL (directoryToSearch: NSSearchPathDirectory) -> NSURL {
        return NSURL(string: Path(directoryToSearch))!
    }
    
    public static func PrintDocumentsPath () {
        print("\n*******************************************\nDOCUMENTS\n\(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])\n*******************************************\n")
    }
}

//MARK: - App Version
public let FSAppVersion      = NSBundle.mainBundle().infoDictionary?.fs_objectForKey("CFBundleShortVersionString", orDefault: "0") as! String
public let FSBuildNumber     = NSBundle.mainBundle().infoDictionary?.fs_objectForKey("CFBundleVersion", orDefault: "0") as! String

//MARK: - System Version

public enum FSSystemVersion {
    
    public static func EqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch) == .OrderedSame
    }
    
    public static func GreatherThan(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch) == .OrderedDescending
    }
    
    public static func GreatherThanOrEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch) != .OrderedAscending
    }
    
    public static func LessThan(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch) == .OrderedAscending
    }
    
    public static func LessThanOrEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch) != .OrderedDescending
    }
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
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
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

//MARK: - iOS settings

public protocol FSSettingsAppProtocol {
    var URL: NSURL {get}
    var canOpen: Bool {get}
    func open () -> Bool
}

public extension FSSettingsAppProtocol {
    public var canOpen: Bool {
        return UIApplication.sharedApplication().canOpenURL(URL)
    }
    
    public func open () -> Bool {
        guard canOpen else {return false}
        return UIApplication.sharedApplication().openURL(URL)
    }
}

public enum FSSettingsApp: FSSettingsAppProtocol {
    
    case Settings
    case WiFi
    
    public var URL: NSURL {
        switch self {
        case .Settings: return NSURL(string: UIApplicationOpenSettingsURLString)!
        case .WiFi: return NSURL(string: "prefs:root=WIFI")!
        }
    }
}

//MARK: - Other

public var FSGregorianCalendar: NSCalendar {return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!}

/**
 Try to make call with input number
 
 - parameter number: phone number (string)
 
 - returns: 'true' if can open URL and 'false' if not or if can't initialize URL from input number
 */
public func FSMakePhoneCall (number: String) -> Bool {
    let callURLString = "tel://\(number)"
    guard let URL = NSURL(string: callURLString) else {return false}
    
    guard UIApplication.sharedApplication().canOpenURL(URL) else {
        return false
    }
    
    return UIApplication.sharedApplication().openURL(URL)
}

public func FSGetRandomBool() -> Bool {
    return arc4random()%2 == 0
}

public func FSGetInfoDictionaryValue (key: String) -> AnyObject? {
    return NSBundle.mainBundle().infoDictionary?[key]
}

public func FSDLog(message: String, function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}

public func FSLog(format: String, _ args: CVarArgType...) {
    #if DEBUG
        withVaList(args) { (pointer: CVaListPointer) -> Void in
            NSLogv(format, pointer)
        }
    #endif
}
