//
//  FSE+NSLayoutConstraint.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_NSLayoutConstraintTests: XCTestCase {
    
    func testGetPreciseConstant() {
        // arrange
        let constant: CGFloat = 52
        let constraint = NSLayoutConstraint(item: UIView(), attribute: .top, relatedBy: .equal, toItem: UIView(), attribute: .bottom, multiplier: 1, constant: constant)
        
        let expectedPreciseConstant = Int(constant * UIScreen.main.scale)
        
        // act
        let preciseConstant = constraint.fs_preciseConstant
        
        // assert
        XCTAssertEqual(preciseConstant, expectedPreciseConstant)
    }
    
    func testSetPreciseConstant() {
        // arrange
        let constant = 52
        let constraint = NSLayoutConstraint(item: UIView(), attribute: .top, relatedBy: .equal, toItem: UIView(), attribute: .bottom, multiplier: 1, constant: CGFloat(constant))
        
        let expectedConstant = CGFloat(constant) / UIScreen.main.scale
        
        // act
        constraint.fs_preciseConstant = 52
        
        // assert
        XCTAssertEqual(constraint.constant, expectedConstant)
    }
    
}
