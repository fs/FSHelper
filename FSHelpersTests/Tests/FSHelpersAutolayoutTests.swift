//
//  FSHelpersAutolayoutTests.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.01.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSHelperAutolayoutTests: XCTestCase {
    
    func testFSEdgesConstraints () {
        
        let superview   = UIView(frame: CGRectZero)
        let view        = UIView(frame: CGRectZero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(view)
        
        let top     : CGFloat = 1
        let left    : CGFloat = 2
        let bottom  : CGFloat = 3
        let right   : CGFloat = 4
        
        let constraints = FSConstraint.Edges(view, edges: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
        
        for constraint in constraints {
            
            XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
            
            XCTAssertTrue(constraint.firstItem === view || constraint.firstItem === superview)
            XCTAssertTrue(constraint.secondItem === view || constraint.secondItem === superview)
            
            switch constraint.firstAttribute
            {
            case .Top       : XCTAssertEqual(top    , constraint.constant)
            case .Leading   : XCTAssertEqual(left   , constraint.constant)
            case .Bottom    : XCTAssertEqual(bottom , constraint.constant)
            case .Trailing  : XCTAssertEqual(right  , constraint.constant)
                
            default: XCTAssert(true, "Wrong attribute type")
            }
        }
    }
    
    func testFSSizeConstraints () {
        
        let size = CGSize(width: 100, height: 200)
        let view        = UIView(frame: CGRectZero)
        
        let constraints = FSConstraint.Size(view, size: size)
        
        for constraint in constraints {
            
            XCTAssertEqual(NSLayoutAttribute.NotAnAttribute, constraint.secondAttribute)
            
            XCTAssertEqual(constraint.firstItem as? UIView  , view)
            XCTAssertNil(constraint.secondItem)
            
            switch constraint.firstAttribute
            {
            case .Width     : XCTAssertEqual(size.width  , constraint.constant)
            case .Height    : XCTAssertEqual(size.height , constraint.constant)
                
            default: XCTAssert(true, "Wrong attribute type")
            }
        }
    }
    
    func testFSCenterConstraints () {
        
        let superview   = UIView(frame: CGRectZero)
        let view        = UIView(frame: CGRectZero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(view)
        
        let xOffset: CGFloat = -10
        let yOffset: CGFloat = 20
        
        let constraints = FSConstraint.Center(view, centerOffset: CGPoint(x: xOffset, y: yOffset))
        
        for constraint in constraints {
            
            XCTAssertEqual(constraint.firstAttribute, constraint.secondAttribute)
            
            XCTAssertEqual(constraint.firstItem as? UIView, view)
            XCTAssertEqual(constraint.secondItem as? UIView, superview)
            
            switch constraint.firstAttribute
            {
            case .CenterX: XCTAssertEqual(xOffset , constraint.constant)
            case .CenterY: XCTAssertEqual(yOffset , constraint.constant)
                
            default: XCTAssert(true, "Wrong attribute type")
            }
        }
    }
    
    func testFSCenterXConstraints () {
        
        let superview   = UIView(frame: CGRectZero)
        let view        = UIView(frame: CGRectZero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(view)
        
        let offset: CGFloat = -10
        
        let constraint = FSConstraint.CenterX(view, offset: offset)
        
        XCTAssertEqual(constraint.firstAttribute, NSLayoutAttribute.CenterX)
        XCTAssertEqual(constraint.secondAttribute, NSLayoutAttribute.CenterX)
        
        XCTAssertEqual(constraint.firstItem as? UIView, view)
        XCTAssertEqual(constraint.secondItem as? UIView, superview)
        
        XCTAssertEqual(constraint.constant, offset)
    }
    
    func testFSCenterYConstraint () {
        
        let superview   = UIView(frame: CGRectZero)
        let view        = UIView(frame: CGRectZero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(view)
        
        let offset: CGFloat = -10
        
        let constraint = FSConstraint.CenterY(view, offset: offset)
        
        XCTAssertEqual(constraint.firstAttribute, NSLayoutAttribute.CenterY)
        XCTAssertEqual(constraint.secondAttribute, NSLayoutAttribute.CenterY)
        
        XCTAssertEqual(constraint.firstItem as? UIView, view)
        XCTAssertEqual(constraint.secondItem as? UIView, superview)
        
        XCTAssertEqual(constraint.constant, offset)
    }
    
    func testFSProportionalWidthConstraint () {
        
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        
        let multipler   : CGFloat = 2
        let constant    : CGFloat = 10
        
        let constraint = FSConstraint.ProportionalWidth(view1, secondView: view2, multipler: multipler, constant: constant)
        
        XCTAssertEqual(constraint.firstAttribute, NSLayoutAttribute.Width)
        XCTAssertEqual(constraint.secondAttribute, NSLayoutAttribute.Width)
        
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
    }
    
    func testFSProportionalHeightConstraint () {
        
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        
        let multipler   : CGFloat = 2
        let constant    : CGFloat = 10
        
        let constraint = FSConstraint.ProportionalHeight(view1, secondView: view2, multipler: multipler, constant: constant)
        
        XCTAssertEqual(constraint.firstAttribute, NSLayoutAttribute.Height)
        XCTAssertEqual(constraint.secondAttribute, NSLayoutAttribute.Height)
        
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
    }
    
    func testFSProportionalHeightToWidthConstraint () {
        
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        
        let multipler   : CGFloat = 2
        let constant    : CGFloat = 10
        
        let constraint = FSConstraint.ProportionalHeightToWidth(view1, secondView: view2, multipler: multipler, constant: constant)
        
        XCTAssertEqual(constraint.firstAttribute, NSLayoutAttribute.Height)
        XCTAssertEqual(constraint.secondAttribute, NSLayoutAttribute.Width)
        
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
    }
    
    func testFSProportionalWidthToHeightConstraint () {
        
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        
        let multipler   : CGFloat = 2
        let constant    : CGFloat = 10
        
        let constraint = FSConstraint.ProportionalWidthToHeight(view1, secondView: view2, multipler: multipler, constant: constant)
        
        XCTAssertEqual(constraint.firstAttribute, NSLayoutAttribute.Width)
        XCTAssertEqual(constraint.secondAttribute, NSLayoutAttribute.Height)
        
        XCTAssertEqual(constraint.firstItem as? UIView, view1)
        XCTAssertEqual(constraint.secondItem as? UIView, view2)
    }
    
}
