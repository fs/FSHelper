//
//  FSHelpersTest.swift
//  Swift-Base
//
//  Created by Kruperfone on 22.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - Application Directory
    
    func testApplicationDirectoryPath () {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        let cashesPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        
        XCTAssertEqual(documentsPath, FSApplicationDirectoryPath(.DocumentDirectory), "Must be equal")
        XCTAssertEqual(cashesPath, FSApplicationDirectoryPath(.CachesDirectory), "Must be equal")
    }
    
    func testApplicationDirectoryURL () {
        let documentsPathURL = NSURL(string: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!)
        let cashesPathURL = NSURL(string: NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!)!
        
        XCTAssertEqual(documentsPathURL, FSApplicationDirectoryURL(.DocumentDirectory), "Must be equal")
        XCTAssertEqual(cashesPathURL, FSApplicationDirectoryURL(.CachesDirectory), "Must be equal")
    }
    
    //MARK: - Interface
    
    func testScreenBounds () {
        XCTAssertEqual(UIScreen.mainScreen().bounds, FSScreenBounds, "Must be equal")
    }
    
    func testIsIPad () {
        let etalon = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        XCTAssertEqual(etalon, FSIsIPad(), "Must be equal")
    }
    
    func testIsIPhone () {
        let etalon = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
        XCTAssertEqual(etalon, FSIsIPhone(), "Must be equal")
    }
    
    func testScaleFactor () {
        let etalon = UIScreen.mainScreen().scale
        XCTAssertEqual(etalon, FSScaleFactor(), "Must be equal")
    }
    
    func testIsRetina () {
        let etalon = FSScaleFactor() == 2
        XCTAssertEqual(etalon, FSIsRetina(), "Must be equal")
    }
    
    func testDeviceOrientation () {
        let etalon = UIDevice.currentDevice().orientation
        XCTAssertEqual(etalon, FSDeviceOrientation(), "Must be equal")
    }
    
    //MARK: - System Version
    
    func testSystemVersionEqualTo() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
            XCTAssertEqual(etalon, FSSystemVersionEqualTo(version), "Must be equal")
        }
    }
    
    func testSystemVersionGreatherThan() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
            XCTAssertEqual(etalon, FSSystemVersionGreatherThan(version), "Must be equal")
        }
    }
    
    func testSystemVersionGreatherThanOrEqualTo() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
            XCTAssertEqual(etalon, FSSystemVersionGreatherThanOrEqualTo(version), "Must be equal")
        }
    }
    
    func testSystemVersionLessThan() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
            XCTAssertEqual(etalon, FSSystemVersionLessThan(version), "Must be equal")
        }
    }
    
    func testSystemVersionLessThanOrEqualTo() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
            XCTAssertEqual(etalon, FSSystemVersionLessThanOrEqualTo(version), "Must be equal")
        }
    }
    
    //MARK: - Images and colors
    
    func testRGBA () {
        let count = 5
        
        for r in 0 ... count {
            for g in 0 ... count {
                for b in 0 ... count {
                    for a in 0 ... count {
                        let red     = CGFloat(r*255/count)
                        let green   = CGFloat(g*255/count)
                        let blue    = CGFloat(b*255/count)
                        let alpha   = CGFloat(a*100/count)
                        
                        let etalon = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha/100)
                        let value = FSRGBA(red, green, blue, alpha/100)
                        
                        var eRedPointer:    CGFloat = -1
                        var eGreenPointer:  CGFloat = -1
                        var eBluePointer:   CGFloat = -1
                        var eAlphaPointer:  CGFloat = -1
                        
                        var vRedPointer:    CGFloat = -1
                        var vGreenPointer:  CGFloat = -1
                        var vBluePointer:   CGFloat = -1
                        var vAlphaPointer:  CGFloat = -1
                        
                        etalon.getRed(&eRedPointer, green: &eGreenPointer, blue: &eBluePointer, alpha: &eAlphaPointer)
                        value.getRed(&vRedPointer, green: &vGreenPointer, blue: &vBluePointer, alpha: &vAlphaPointer)
                        
                        XCTAssertTrue(eRedPointer       >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(eGreenPointer     >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(eBluePointer      >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(eAlphaPointer     >= 0, "Must be greather or equal to zero")
                        
                        XCTAssertTrue(vRedPointer       >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(vGreenPointer     >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(vBluePointer      >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(vAlphaPointer     >= 0, "Must be greather or equal to zero")
                        
                        XCTAssertEqual(Int(eRedPointer),    Int(vRedPointer),       "Red chanel must be equal")
                        XCTAssertEqual(Int(eGreenPointer),  Int(vGreenPointer),     "Green chanel must be equal")
                        XCTAssertEqual(Int(eBluePointer),   Int(vBluePointer),      "Blue chanel must be equal")
                        XCTAssertEqual(Int(eAlphaPointer),  Int(vAlphaPointer),     "Alpha chanel must be equal")
                    }
                }
            }
        }
    }
    
    func testImageFromColor () {
        let count = 5
        
        for r in 0 ... count {
            for g in 0 ... count {
                for b in 0 ... count {
                    let imageRed     = CGFloat(r*255/count)
                    let imageGreen   = CGFloat(g*255/count)
                    let imageBlue    = CGFloat(b*255/count)
                    
                    let color = UIColor(red: imageRed/255, green: imageGreen/255, blue: imageBlue/255, alpha: 1)
                    
                    let value = FSImageFromColor(color)
                    
                    let imageRef: CGImageRef? = value.CGImage
                    
                    var bitmapBytesPerRow = 0
                    
                    //Get image width, height
                    let pixelsWide = CGImageGetWidth(imageRef)
                    let pixelsHigh = CGImageGetHeight(imageRef)
                    
                    // Declare the number of bytes per row. Each pixel in the bitmap in this
                    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
                    // alpha.
                    let bytesPerPixel = 4
                    let bitsPerComponent = 8
                    
                    bitmapBytesPerRow = Int(pixelsWide) * bytesPerPixel
                    
                    // Use the generic RGB color space.
                    let colorSpace = CGColorSpaceCreateDeviceRGB()
                    
                    // Allocate memory for image data. This is the destination in memory
                    // where any drawing to the bitmap context will be rendered.
                    let bitmapData = UnsafeMutablePointer<UInt32>(calloc(pixelsWide*pixelsHigh, sizeof(UInt32)))
                    
                    
                    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue | CGBitmapInfo.ByteOrder32Big.rawValue
                    
                    let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, bitsPerComponent, bitmapBytesPerRow, colorSpace, bitmapInfo)
                    CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(pixelsWide), CGFloat(pixelsHigh)), imageRef)
                    
                    XCTAssertEqual(1, pixelsHigh, "Height must 1 pixel")
                    XCTAssertEqual(1, pixelsHigh, "Width must 1 pixel")
                    
                    var currentPixel: UnsafeMutablePointer<UInt32> = bitmapData
                    
                    for _ in 0 ..< pixelsHigh {
                        for _ in 0 ..< pixelsWide {
                            
                            let currentColor: UInt32 = currentPixel[0]
                            
                            let red     = currentColor & 0xFF
                            let green   = (currentColor >> 8) & 0xFF
                            let blue    = (currentColor >> 16) & 0xFF
                            let _       = (currentColor >> 24) & 0xFF
                            
                            XCTAssertEqual(UInt32(imageRed),    red,    "Red must be equal")
                            XCTAssertEqual(UInt32(imageGreen),  green,  "Green must be equal")
                            XCTAssertEqual(UInt32(imageBlue),   blue,   "Blue must be equal")
                            
                            currentPixel++
                        }
                    }
                }
            }
        }
        
    }
    
    func testRandomColor () {
        let color: UIColor = FSRandomColor()
        XCTAssertNotNil(color, "Must not be nil")
    }
    
    //MARK: - GCD
    func testDispatch_after_short () {
        for i in 0 ..< 3 {
            let delay: Double = Double(i)/10
            
            let expectation = expectationWithDescription("Expectation")
            
            let startDate = NSDate()
            var interval: NSTimeInterval = 0
            
            FSDispatch_after_short(delay) { () -> Void in
                interval = abs(NSDate().timeIntervalSinceDate(startDate))
                expectation.fulfill()
            }
            
            self.waitForExpectationsWithTimeout(delay+0.1, handler: { (error: NSError?) -> Void in
                if error == nil {
                    XCTAssertGreaterThanOrEqual(interval, delay, "Too fast")
                } else {
                    XCTAssertTrue(false, "Too long")
                }
            })
        }
    }
    
    func testDLog () {
        FSDLog("It's a test")
    }
}
