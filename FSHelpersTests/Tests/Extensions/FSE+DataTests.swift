//
//  FSE+DataTests.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_DataTests: XCTestCase {
    
    func testHexEncoded() {
        // arrange
        let data = Data("Hello, Swift!".utf8)
        let expectedHexString = data.map { String(format: "%02x", $0) }.joined()
        
        // act
        let hexEncodedString = data.fs_hexEncoded
        
        // assert
        XCTAssertEqual(hexEncodedString, expectedHexString)
    }
    
}
