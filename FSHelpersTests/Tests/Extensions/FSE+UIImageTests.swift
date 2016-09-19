//
//  FSE+UIImageTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
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
}
