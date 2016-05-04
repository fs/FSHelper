//
//  FSE+RangeTests.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_RangeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGenerateIndexPaths () {
        let start = Int(arc4random_uniform(1000))
        let end = (start+1000)
        let section = Int(arc4random_uniform(100))
        let range = (start ..< end)
        let generatedIndexPaths = range.FSGenerateIndexPaths(section)
        
        XCTAssertEqual(generatedIndexPaths.count, (end - start))
        for i in 0 ..< (end-start) {
            let indexPath = generatedIndexPaths[i]
            let row = i+start
            XCTAssertEqual(indexPath.section, section)
            XCTAssertEqual(indexPath.row, row)
        }
    }
}
