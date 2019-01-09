//
//  FSE+CollectionTest.swift
//  FSHelpersTests
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_CollectionTests: XCTestCase {
    
    func testSplitWithMaxSplits() {
        // arrange
        let collection = [8, 2, 2, 6, 8, 2, 2, 4, 4]
        let expectedSubsequences = [[8], [2, 2], [6, 8, 2, 2, 4, 4]]
        
        // act
        let splittedSubsequences = collection.fs_split(maxSplits: 2, by: { $0 == $1 })
        
        // assert
        XCTAssertEqual(splittedSubsequences.map { Array($0) }, expectedSubsequences)
    }
    
    func testSplit() {
        // arrange
        let collection = [8, 2, 2, 6, 8, 2, 2, 4, 4]
        let expectedSubsequences = [[8], [2, 2], [6], [8], [2, 2], [4, 4]]
        
        // act
        let splittedSubsequences = collection.fs_split(by: { $0 == $1 })
        
        // assert
        XCTAssertEqual(splittedSubsequences.map { Array($0) }, expectedSubsequences)
    }
    
}
