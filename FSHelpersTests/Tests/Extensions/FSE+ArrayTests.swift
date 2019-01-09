//
//  FSE+ArrayTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

fileprivate class TestObject: Equatable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: TestObject, rhs: TestObject) -> Bool {
        return lhs.name == rhs.name
    }
}

class FSE_ArrayTests: XCTestCase {
    
    fileprivate let array: [Int] = {
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
    
    func testRemoveFirst() {
        // arrange
        let expectedArray = [5, 8, 9, 32, 56]
        let expectedDeletedInt = 3
        
        var array = [5, 3, 8, 9, 32, 56]
        
        // act
        let deletedInt = array.fs_removeFirst { $0 == expectedDeletedInt }
        
        // assert
        XCTAssertEqual(array, expectedArray)
        XCTAssertEqual(deletedInt, expectedDeletedInt)
    }
    
    func testRemoveFirstWithReturnNil() {
        // arrange
        var array = [5, 3, 8, 9, 32, 56]
        
        // act
        let deletedElement = array.fs_removeFirst { $0 == 2 }
        
        // assert
        XCTAssertNil(deletedElement)
    }
    
    func testPrepend() {
        // arrange
        let expectedArray = [5, 8, 9, 32, 56]
        let expectedPrependInt = 5
        
        var array = [8, 9, 32, 56]
        
        // act
        array.fs_prepend(expectedPrependInt)
        
        // assert
        XCTAssertEqual(array, expectedArray)
    }
    
    func testRemove() {
        // arrange
        let object1 = TestObject(name: "object1")
        let object2 = TestObject(name: "object2")
        var array = [object1, object2]
        
        let expectedArray = [object2]
        let expectedDeletedObject = object1
        
        // act
        let deletedObject = array.fs_remove(object: object1)
        
        // assert
        XCTAssertEqual(array, expectedArray)
        XCTAssertEqual(deletedObject, expectedDeletedObject)
    }
    
    func testRemoveWithReturnNil() {
        // arrange
        let object1 = TestObject(name: "object1")
        let object2 = TestObject(name: "object2")
        let object3 = TestObject(name: "object2")
        var array = [object1, object2]
        
        // act
        let deletedObject = array.fs_remove(object: object3)
        
        // assert
        XCTAssertNil(deletedObject)
    }
    
    func testContains() {
        // arrange
        let object1 = TestObject(name: "object1")
        let object2 = TestObject(name: "object2")
        let object3 = TestObject(name: "object2")
        let array = [object1, object2]
        
        // act
        let containsObject2 = array.fs_contains(object: object2)
        let containsObject3 = array.fs_contains(object: object3)
        
        // assert
        XCTAssertTrue(containsObject2)
        XCTAssertFalse(containsObject3)
    }
    
    func testAppend() {
        // arrange
        let array1 = [5, 7]
        let array2 = [2, 9]
        let expectedArray = [5, 7, 2, 9]
        
        // act
        let resultArray = array1 + array2
        
        // assert
        XCTAssertEqual(resultArray, expectedArray)
    }
    
}
