//
//  FSE+CGPointTests.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_CGPointTests: XCTestCase {
    
    func testAdjusted() {
        // arrange
        let point = CGPoint(x: 1.5, y: 2.7)
        let expectedPoint = CGPoint(x: 1, y: 2)
        
        // act
        let adjustedPoint = point.fs_adjusted
        
        // assert
        XCTAssertEqual(adjustedPoint, expectedPoint)
    }
    
}
