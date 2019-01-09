//
//  FSE+CGRectTests.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_CGRectTests: XCTestCase {
    
    var rect: CGRect!
    
    override func setUp() {
        super.setUp()
        self.rect = CGRect(x: 2, y: 15, width: 7, height: 8)
    }
    
    func testTop() {
        // arrange
        let expectedTop: CGFloat = 15
        
        // assert
        XCTAssertEqual(self.rect.fs_top, expectedTop)
    }
    
    func testBottom() {
        // arrange
        let expectedBottom: CGFloat = 23
        
        // assert
        XCTAssertEqual(self.rect.fs_bottom, expectedBottom)
    }
    
    func testLeft() {
        // arrange
        let expectedLeft: CGFloat = 2
        
        // assert
        XCTAssertEqual(self.rect.fs_left, expectedLeft)
    }
    
    func testRight() {
        // arrange
        let expectedRight: CGFloat = 9
        
        // assert
        XCTAssertEqual(self.rect.fs_right, expectedRight)
    }
    
    func testAdjusted() {
        // arrange
        let rect = CGRect(x: 1.2, y: 6.8, width: 9.2, height: 4.7)
        let expectedRect = CGRect(x: 1, y: 6, width: 10, height: 5)
        
        // act
        let adjustedRect = rect.fs_adjusted
        
        // assert
        XCTAssertEqual(adjustedRect, expectedRect)
    }
    
    func testCGFloatInitializer() {
        // arrange
        let x: CGFloat = 2.3
        let y: CGFloat = 6.5
        let width: CGFloat = 3.2
        let height: CGFloat = 9.7
        
        let expectedRect = CGRect(x: x, y: y, width: width, height: height)
        
        // act
        let initializedRect = CGRect(x: x, y: y, size: CGSize(width: width, height: height))
        
        // assert
        XCTAssertEqual(initializedRect, expectedRect)
    }
    
    func testDoubleInitializer() {
        // arrange
        let x: Double = 2.3
        let y: Double = 6.5
        let width: Double = 3.2
        let height: Double = 9.7
        
        let expectedRect = CGRect(x: x, y: y, width: width, height: height)
        
        // act
        let initializedRect = CGRect(x: x, y: y, size: CGSize(width: width, height: height))
        
        // assert
        XCTAssertEqual(initializedRect, expectedRect)
    }
    
    func testIntInitializer() {
        // arrange
        let x: Int = 2
        let y: Int = 6
        let width: Int = 3
        let height: Int = 9
        
        let expectedRect = CGRect(x: x, y: y, width: width, height: height)
        
        // act
        let initializedRect = CGRect(x: x, y: y, size: CGSize(width: width, height: height))
        
        // assert
        XCTAssertEqual(initializedRect, expectedRect)
    }
    
}
