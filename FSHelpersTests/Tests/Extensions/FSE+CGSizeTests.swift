//
//  FSE+CGSizeTests.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_CGSizeTests: XCTestCase {
    
    func testAdjusted() {
        // arrange
        let size = CGSize(width: 5.6, height: 7.2)
        let expectedSize = CGSize(width: 6, height: 8)
        
        // act
        let adjustedSize = size.fs_adjusted
        
        // assert
        XCTAssertEqual(adjustedSize, expectedSize)
    }
    
    func testEquilateralCGFloatInitializer() {
        // arrange
        let size: CGFloat = 7.8
        let expectedSize = CGSize(width: size, height: size)
        
        // act
        let initializedSize = CGSize(equilateral: size)
        
        // assert
        XCTAssertEqual(initializedSize, expectedSize)
    }
    
    func testEquilateralDoubleInitializer() {
        // arrange
        let size: Double = 7.2
        let expectedSize = CGSize(width: size, height: size)
        
        // act
        let initializedSize = CGSize(equilateral: size)
        
        // assert
        XCTAssertEqual(initializedSize, expectedSize)
    }
    
    func testEquilateralIntInitializer() {
        // arrange
        let size: Int = 7
        let expectedSize = CGSize(width: size, height: size)
        
        // act
        let initializedSize = CGSize(equilateral: size)
        
        // assert
        XCTAssertEqual(initializedSize, expectedSize)
    }
    
}
