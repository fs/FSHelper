//
//  FSE+FloatingPointTests.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_FloatingPointTests: XCTestCase {
    
    func testDegreesToRadians() {
        // arrange
        let degrees = 76.5
        let expectedRadians = degrees * .pi / 180
        
        // act
        let radians = degrees.fs_degreesToRadians
        
        // assert
        XCTAssertEqual(radians, expectedRadians)
    }
    
    func testRadiansToDegrees() {
        // arrange
        let radians = 45.2
        let expectedDegrees = radians * 180 / .pi
        
        // act
        let degrees = radians.fs_radiansToDegrees
        
        // assert
        XCTAssertEqual(degrees, expectedDegrees)
    }
}
