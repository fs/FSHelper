//
//  FSE+UIColorTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_UIColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithHexAndAlpha () {
        for _ in 0 ..< 5 {
            let red     = CGFloat(arc4random_uniform(255))/255.0
            let green   = CGFloat(arc4random_uniform(255))/255.0
            let blue    = CGFloat(arc4random_uniform(255))/255.0
            let alpha   = CGFloat(arc4random_uniform(255))/255.0
            
            let hexString = NSString(format: "%02x%02x%02x", (Int(red*255)), (Int(green*255)), (Int(blue*255))) as String
            
            let color           = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            let defaultColor    = UIColor(red: red, green: green, blue: blue, alpha: 1)
            
            let result          = UIColor(fs_hexString: hexString, alpha: alpha)!
            let defaultResult   = UIColor(fs_hexString: hexString)!
            
            let result2         = UIColor(fs_hexString: "#\(hexString)", alpha: alpha)!
            let defaultResult2  = UIColor(fs_hexString: "#\(hexString)")
            
            XCTAssertEqual(color.description, result.description, "Must be equal")
            XCTAssertEqual(defaultColor.description, defaultResult.description, "Must be equal")
            XCTAssertEqual(color.description, result2.description)
            XCTAssertEqual(defaultColor.description, defaultResult2?.description)
        }
    }
    
    func testInitWithIncorrectHex() {
        // arrange
        let incrorrectRegexHex = "A6G1XXXX09"
        let incorrectLongHex = "#A123B456"
        
        // act
        let initializedRegexColor = UIColor(fs_hexString: incrorrectRegexHex)
        let initializedLongColor = UIColor(fs_hexString: incorrectLongHex)
        
        // assert
        XCTAssertNil(initializedRegexColor)
        XCTAssertNil(initializedLongColor)
    }
    
    func testHexString() {
        for _ in 0 ..< 5 {
            // Arrange
            let red     = CGFloat(arc4random_uniform(255))/255.0
            let green   = CGFloat(arc4random_uniform(255))/255.0
            let blue    = CGFloat(arc4random_uniform(255))/255.0
            
            let etalon = NSString(format: "%02x%02x%02x", (Int(red*255)), (Int(green*255)), (Int(blue*255))) as String
            
            // Act
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            
            // Assert
            XCTAssertEqual(etalon, color.fs_hexString(), "Must be equal")
        }
    }
    
    func testHexStringWhiteColor() {
        // arrange
        let whiteColor = UIColor.white
        let expectedHex = "ffffff"
        
        // act
        let hex = whiteColor.fs_hexString()
        
        // assert
        XCTAssertEqual(hex, expectedHex)
    }
    
    func testInitializerWithRedGreenBlue() {
        // arrange
        let red: CGFloat = 55 / 255.0
        let green: CGFloat = 55 / 255.0
        let blue: CGFloat = 55 / 255.0
        let expectedColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        // act
        let initializedColor = UIColor(red: red, green: green, blue: blue)
        
        // assert
        XCTAssertEqual(initializedColor, expectedColor)
    }
    
    func testInitializerWithRedGreenBlueBytes() {
        // arrange
        let red: CGFloat = 55 / 255.0
        let green: CGFloat = 55 / 255.0
        let blue: CGFloat = 55 / 255.0
        let alpha: CGFloat = 0.5
        let expectedColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        // act
        let initializedColor = UIColor(redByte: 55, greenByte: 55, blueByte: 55, alpha: 0.5)
        
        // assert
        XCTAssertEqual(initializedColor, expectedColor)
    }
    
    func testInitilizerWithWhite() {
        // arrange
        let white: CGFloat = 55 / 255.0
        let expectedColor = UIColor(white: white, alpha: 1)
        
        // act
        let initializedColor = UIColor(white: white)
        
        // assert
        XCTAssertEqual(initializedColor, expectedColor)
    }
    
    func testInitilizerWithWhiteByte() {
        // arrange
        let whiteByte: UInt = 55
        let white: CGFloat = 55 / 255.0
        let alpha: CGFloat = 0.47
        let expectedColor = UIColor(white: white, alpha: alpha)
        
        // act
        let initializedColor = UIColor(whiteByte: whiteByte, alpha: alpha)
        
        // assert
        XCTAssertEqual(initializedColor, expectedColor)
    }
    
    func testInitializerWithRGBHex() {
        // arrange
        let expectedColor = UIColor(red: 66 / 255.0, green: 134 / 255.0, blue: 244 / 255.0, alpha: 1)
        
        // act
        let initializedColor = UIColor(withRGBHex: 0x4286f4)
        
        // assert
        XCTAssertEqual(initializedColor, expectedColor)
    }
}
