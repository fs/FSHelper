//
//  FSE+Enumerations.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_EnumerationsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAllCases() {
        enum Foo: Int {
            case first = 0
            case second
            case third
            case fourth
            case fifth
        }
        let count = 5
        let allCases = Foo.allCases
        
        XCTAssertEqual(allCases.count, count)
        
        XCTAssertTrue(allCases.contains(.first))
        XCTAssertTrue(allCases.contains(.second))
        XCTAssertTrue(allCases.contains(.third))
        XCTAssertTrue(allCases.contains(.fourth))
        XCTAssertTrue(allCases.contains(.fifth))
    }
}
