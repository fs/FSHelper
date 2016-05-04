//
//  FSE+UITextFieldTests.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_UITextFieldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsEmpty () {
        let textField = UITextField()
        
        textField.text = nil
        XCTAssert(textField.fs_isEmpty)
        
        textField.text = ""
        XCTAssert(textField.fs_isEmpty)
        
        textField.text = "test"
        XCTAssert(!textField.fs_isEmpty)
    }
}
