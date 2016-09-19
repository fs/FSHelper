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
        
        XCTAssertEqual(stringClass.fs_className    , NSStringFromClass(stringClass).components(separatedBy: ".").last!)
        XCTAssertEqual(arrayClass.fs_className     , NSStringFromClass(arrayClass).components(separatedBy: ".").last!)
    }
    
    func testClassName_Object () {
        let stringObject     = NSString()
        let arrayObject      = NSArray()
        
        XCTAssertEqual(stringObject.fs_className    , NSStringFromClass(type(of: stringObject)).components(separatedBy: ".").last!)
        XCTAssertEqual(arrayObject.fs_className     , NSStringFromClass(type(of: arrayObject)).components(separatedBy: ".").last!)
    }
}
