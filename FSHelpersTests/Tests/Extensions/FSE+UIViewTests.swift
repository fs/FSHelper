//
//  FSE+UIViewTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_UIViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - Set size
    
    func testSize () {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 300, height: 400))
        XCTAssertEqual(view.frame.size, view.fs_size, "Must be equal")
        
        let newSize = CGSize(width: 350, height: 450)
        view.fs_size = CGSize(width: 350, height: 450)
        
        XCTAssertEqual(view.frame.size, newSize, "Must be equal")
    }
    
    func testWidth () {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 300, height: 400))
        XCTAssertEqual(view.frame.size.width, view.fs_width, "Must be equal")
        
        let newWidth: CGFloat = 350
        view.fs_width = newWidth
        
        XCTAssertEqual(view.frame.size.width, newWidth, "Must be equal")
    }
    
    func testHeight () {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 300, height: 400))
        XCTAssertEqual(view.frame.size.height, view.fs_height, "Must be equal")
        
        let newHeight: CGFloat = 450
        view.fs_height = newHeight
        
        XCTAssertEqual(view.frame.size.height, newHeight, "Must be equal")
    }
    
    //MARK: - Set origin
    
    func testOrigin () {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 300, height: 400))
        XCTAssertEqual(view.frame.origin, view.fs_origin, "Must be equal")
        
        let newOrigin = CGPoint(x: 150, y: 250)
        view.fs_origin = newOrigin
        
        XCTAssertEqual(view.frame.origin, newOrigin, "Must be equal")
    }
    
    func testX () {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 300, height: 400))
        XCTAssertEqual(view.frame.origin.x, view.fs_x, "Must be equal")
        
        let newX: CGFloat = 150
        view.fs_x = newX
        
        XCTAssertEqual(view.frame.origin.x, newX, "Must be equal")
    }
    
    func testY () {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 300, height: 400))
        XCTAssertEqual(view.frame.origin.y, view.fs_y, "Must be equal")
        
        let newY: CGFloat = 250
        view.fs_y = newY
        
        XCTAssertEqual(view.frame.origin.y, newY, "Must be equal")
    }
    
    func testStoryboardExtensions() {
        
        let storyboard = UIStoryboard(name: "TestStoryboard", bundle: Bundle(for: type(of: self)))

        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
            
        XCTAssertEqual(controller.view.layer.cornerRadius, 5, "Must be equal")
        XCTAssertEqual(UIColor(cgColor: controller.view.layer.borderColor!), UIColor.red, "Must be equal")
        XCTAssertEqual(controller.view.layer.borderWidth, 5, "Must be equal")
        XCTAssertEqual(UIColor(cgColor: controller.view.layer.shadowColor!), UIColor.green, "Must be equal")
        XCTAssertEqual(controller.view.layer.shadowOffset, CGSize(width: 2, height: 2), "Must be equal")
        XCTAssertEqual(controller.view.layer.shadowOpacity, 0.5, "Must be equal")
        XCTAssertEqual(controller.view.layer.shadowRadius, 3, "Must be equal")
        XCTAssertEqual(controller.view.layer.masksToBounds, false, "Must be equal")
        
    }
}
