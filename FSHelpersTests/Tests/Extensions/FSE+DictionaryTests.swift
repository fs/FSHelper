//
//  FSE+DictionaryTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_DictionaryTests: XCTestCase {
    
    fileprivate func generateDict() -> [Int : Int] {
        var dict: [Int : Int] = [:]
        for i in 0 ..< 1000 {
            let random = Int(arc4random_uniform(100))
            dict.updateValue(random, forKey: i)
        }
        return dict
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdateIfExist () {
        var dict = self.generateDict()
        
        for i in 0 ..< 100 {
            let valueOrNil: Int? = arc4random()%2 == 0 ? Int(arc4random()) : nil
            let key = 1000+i
            dict.fs_updateIfExist(valueOrNil, forKey: key)
            
            if let value = valueOrNil {
                XCTAssertEqual(dict[key], value)
            }
        }
    }
    
    func testObjectForKeyOrDefault () {
        let dict = self.generateDict()
        
        let defaultValue = -1
        
        for i in 0 ..< dict.count*2 {
            let result = dict.fs_objectForKey(i, orDefault: defaultValue)
            if i < dict.count {
                XCTAssertEqual      (dict[i],  result,         "Must be equal")
                XCTAssertNotEqual   (result,   defaultValue,   "Must not be equal")
            } else {
                XCTAssertEqual   (result,   defaultValue,   "Must be equal")
            }
        }
    }
    
    func testAppend() {
        // arrange
        let dictionary1 = [1: "Hello", 2: "World"]
        let dictionary2 = [3: "Hello", 4: "Swift"]
        let expectedDictionary = [1: "Hello", 2: "World", 3: "Hello", 4: "Swift"]
        
        // act
        let resultDictionary = dictionary1 + dictionary2
        
        // assert
        XCTAssertEqual(resultDictionary, expectedDictionary)
    }
    
    func testAppendWithEquality() {
        // arrange
        var dictionary = [1: "Hello", 2: "World"]
        let appendDictionary = [3: "Hello", 4: "Swift"]
        let expectedDictionary = [1: "Hello", 2: "World", 3: "Hello", 4: "Swift"]
        
        // act
        dictionary += appendDictionary
        
        // assert
        XCTAssertEqual(dictionary, expectedDictionary)
    }
}
