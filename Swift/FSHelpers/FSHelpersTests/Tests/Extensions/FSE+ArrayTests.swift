//
//  FSE+ArrayTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_ArrayTests: XCTestCase {
    
    private let array: [Int] = {
        var arr: [Int] = []
        for i in 0 ..< 1000 {
            let random = Int(arc4random_uniform(100))
            arr.append(random)
        }
        return arr
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAppendIfExist () {
        var array = self.array
        
        for _ in 0 ..< 100 {
            let oldCount = array.count
            let valueOrNil: Int? = arc4random()%2 == 0 ? Int(arc4random()) : nil
            array.fs_appendIfExist(valueOrNil)
            
            let newCount = (valueOrNil == nil) ? oldCount : (oldCount + 1)
            XCTAssertEqual(array.count, newCount)
            if let value = valueOrNil {
                XCTAssertEqual(array.last!, value)
            }
        }
        
    }
    
    func testObjectAtIndexOrNil () {
        let array = self.array
        
        for i in 0 ..< array.count*2 {
            if i < array.count {
                XCTAssertNotNil(array.fs_objectAtIndexOrNil(i), "Must not be nil")
            } else {
                XCTAssertNil(array.fs_objectAtIndexOrNil(i), "Must be nil")
            }
        }
    }
    
    func testShuffle () {
        let array = self.array
        let shuffleArray = array.fs_shuffle()
        let doubleShuffleArray = shuffleArray.fs_shuffle()
        
        XCTAssertNotEqual(array,                shuffleArray,           "Must not be equal")
        XCTAssertNotEqual(shuffleArray,         doubleShuffleArray,     "Must not be equal")
        XCTAssertNotEqual(doubleShuffleArray,   array,                  "Must not be equal")
    }
    
}
