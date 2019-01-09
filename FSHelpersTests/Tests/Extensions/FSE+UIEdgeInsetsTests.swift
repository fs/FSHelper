//
//  FSE+UIEdgeInsetsTests.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_UIEdgeInsetsTests: XCTestCase {
    
    func testEquilateralInitializer() {
        // arrange
        let side: CGFloat = 15
        let expectedEdgeInsents = UIEdgeInsets(top: side, left: side, bottom: side, right: side)
        
        // act
        let initializedEdgeInsets = UIEdgeInsets(equilateral: side)
        
        // assert
        XCTAssertEqual(initializedEdgeInsets, expectedEdgeInsents)
    }
    
}
