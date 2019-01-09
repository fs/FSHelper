//
//  FSE+UIImageTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
import CoreImage
@testable import FSHelpers

class FSE_UIImageTests: XCTestCase {
    
    /*
    */
    ///Using image 5x5 where in first row R, G and B from 0 to 255, in second only R, in third only G, in fourth B and in last Alpha. 
    ///Changing with rule: 0-64-128-191-255
    let imageData = Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABxpRE9UAAAAAgAAAAAAAAADAAAAKAAAAAMAAAACAAAAYGZo4mwAAAAsSURBVBgZJMiBCQAwDAJBR3M0N3M0+6EJB/KSNNtLsra7oxERFJQfZUZQ8A8AAP//A9dvYgAAACFJREFUY2BgYPjPwOAAxA1AvB+I/wMxBDgAqQYg3g/E/wHtXSVfd7sjBgAAAABJRU5ErkJggg==", options: NSData.Base64DecodingOptions(rawValue: 0))!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBase64 () {
        let image = UIImage(data: self.imageData)!
        
        let imageData = UIImagePNGRepresentation(image)!
        let etalon = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        XCTAssertEqual(etalon, image.fs_base64, "Must be equal")
    }
    
    func testScaledWithSize() {
        // arrange
        let image = UIImage()
        let expectedSize = CGSize(width: 15, height: 54)
        
        // act
        let scaledImage = image.fs_scaled(toSize: expectedSize)
        
        // assert
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage?.size, expectedSize)
    }
    
    func testScaledWithWidth() {
        // arrange
        guard let image = UIImage(data: self.imageData) else {
            return XCTFail()
        }
        
        let width: CGFloat = 15
        let scaleFactor = width / image.size.width
        let expectedSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
        
        // act
        let scaledImage = image.fs_scaled(toWidth: width)
        
        // assert
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage?.size, expectedSize)
    }
    
    func testAspectFillImage() {
        // arrange
        guard let image = UIImage(data: self.imageData) else {
            return XCTFail()
        }
        
        let size = CGSize(width: 15, height: 15)
        let scale = max(size.width / image.size.width, size.height / image.size.height)
        
        let expectedSize = CGSize(width: image.size.width * scale, height: image.size.height * scale).fs_adjusted
        
        // act
        let aspectFillImage = image.fs_aspectFillImageWithSize(size)
        
        // assert
        XCTAssertEqual(aspectFillImage.size, expectedSize)
    }
    
    func testAspectFitImage() {
        // arrange
        guard let image = UIImage(data: self.imageData) else {
            return XCTFail()
        }
        
        let size = CGSize(width: 15, height: 15)
        let minScale = min(size.width / image.size.width, size.height / image.size.height)
        let targetSize = CGSize(width: image.size.width * minScale, height: image.size.height * minScale).fs_adjusted
        let scale = max(targetSize.width / image.size.width, targetSize.height / image.size.height)
        
        let expectedSize = CGSize(width: image.size.width * scale, height: image.size.height * scale).fs_adjusted
        
        // act
        let aspectFitImage = image.fs_aspectFitImageWithSize(size)
        
        // assert
        XCTAssertEqual(aspectFitImage.size, expectedSize)
    }
}
