//
//  FSE+UITextViewTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_UITextViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetTextHeight() {
        var height =  UITextView.fs_getTextHeight(forText: "test test test", width: 20, font: UIFont.systemFont(ofSize: 15))
        XCTAssertEqual(height, 232, "Must be equal")
        height = UITextView.fs_getTextHeight(forText: "t", width: 20, font: UIFont.systemFont(ofSize: 15))
        XCTAssertEqual(height, 35, "Must be equal")
        height = UITextView.fs_getTextHeight(forText: "t", width: 1000, font: UIFont.systemFont(ofSize: 15))
        XCTAssertEqual(height, 35, "Must be equal")
        height = UITextView.fs_getTextHeight(forText: "t", width: 10, font: UIFont.systemFont(ofSize: 15))
        XCTAssertEqual(height, 35, "Must be equal")
    }
}
