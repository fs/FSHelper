//
//  FSE+NSObjectTests.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_NSObjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testClassName_Class () {
        let stringClass     = NSString.self
        let arrayClass      = NSArray.self
        let dateClass       = NSDate.self
        
        XCTAssertEqual(stringClass.fs_className    , NSStringFromClass(stringClass).componentsSeparatedByString(".").last!)
        XCTAssertEqual(arrayClass.fs_className     , NSStringFromClass(arrayClass).componentsSeparatedByString(".").last!)
        XCTAssertEqual(dateClass.fs_className      , NSStringFromClass(dateClass).componentsSeparatedByString(".").last!)
    }
    
    func testClassName_Object () {
        let stringObject     = NSString()
        let arrayObject      = NSArray()
        let dateObject       = NSDate()
        
        XCTAssertEqual(stringObject.fs_className    , NSStringFromClass(stringObject.dynamicType).componentsSeparatedByString(".").last!)
        XCTAssertEqual(arrayObject.fs_className     , NSStringFromClass(arrayObject.dynamicType).componentsSeparatedByString(".").last!)
        XCTAssertEqual(dateObject.fs_className      , NSStringFromClass(dateObject.dynamicType).componentsSeparatedByString(".").last!)
    }
}
