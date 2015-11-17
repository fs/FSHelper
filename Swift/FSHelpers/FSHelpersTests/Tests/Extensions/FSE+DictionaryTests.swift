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
    
    private let dict: [Int : Int] = {
        var dict: [Int : Int] = [:]
        for i in 0 ..< 1000 {
            let random = Int(arc4random_uniform(100))
            dict.updateValue(random, forKey: i)
        }
        return dict
        }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testfs_ObjectForKeyOrDefault () {
        let dict = self.dict
        
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
}
