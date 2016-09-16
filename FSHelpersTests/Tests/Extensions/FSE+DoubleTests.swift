//
//  FSE+DoubleTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_DoubleTests: XCTestCase {
    
    let value: Double = drand48()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDispatchTime () {
        for i in 0 ..< 3 {
            let delay: Double = Double(i)/10
            
            let expectation = self.expectation(description: "Expectation")
            
            let startDate = Date()
            var interval: TimeInterval = 0
            
            DispatchQueue.main.asyncAfter(deadline: delay.fs_dispatchTime, execute: { () -> Void in
                interval = abs(Date().timeIntervalSince(startDate))
                expectation.fulfill()
            })
            
            self.waitForExpectations(timeout: delay + 0.1, handler: { (error: Error?) in
                if error == nil {
                    XCTAssertGreaterThanOrEqual(interval, delay, "Too fast")
                } else {
                    XCTAssertTrue(false, "Too long")
                }
            })
        }
    }
}
