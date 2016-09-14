//
//  FSHelpersAutolayout.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.01.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

public enum FSConstraint {
    
    public static func Visual (
        format  : String,
        options : NSLayoutFormatOptions = .DirectionLeadingToTrailing,
        metrics : [String : AnyObject]? = nil,
        views   : [String : AnyObject]) -> [NSLayoutConstraint]
    {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views)
        return constraints
    }
    
    public static func Edges (view: UIView, edges: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) -> [NSLayoutConstraint] {
        
        let dict = ["view": view]
        let metrics = ["LEFT": edges.left, "TOP": edges.top, "RIGHT": edges.right, "BOTTOM": edges.bottom]
        
        var constraints:[NSLayoutConstraint] = []
        
        constraints += Visual("H:|-LEFT-[view]-RIGHT-|", options: [], metrics: metrics, views: dict)
        constraints += Visual("V:|-TOP-[view]-BOTTOM-|", options: [], metrics: metrics, views: dict)
        
        return constraints
    }
    
    public static func Size (view:UIView, size:CGSize) -> [NSLayoutConstraint] {
        let dict = ["view":view]
        let metrics = ["WIDTH":size.width, "HEIGHT":size.height]
        
        var constraints:[NSLayoutConstraint] = []
        
        constraints += Visual("H:[view(WIDTH)]", options: [], metrics: metrics, views: dict)
        constraints += Visual("V:[view(HEIGHT)]", options: [], metrics: metrics, views: dict)
        
        return constraints
    }
    
    public static func Center (view: UIView, centerOffset: CGPoint = CGPointZero) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: view.superview!, attribute: .CenterX, multiplier: 1, constant: centerOffset.x),
            NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview!, attribute: .CenterY, multiplier: 1, constant: centerOffset.y)
        ]
    }
    
    public static func CenterY (view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview, attribute: .CenterY, multiplier: 1, constant: offset)
    }
    
    public static func CenterX (view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: view.superview, attribute: .CenterX, multiplier: 1, constant: offset)
    }
    
    public static func ProportionalWidth (firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .Width, relatedBy: .Equal, toItem: secondView, attribute: .Width, multiplier: multipler, constant: constant)
    }
    
    public static func ProportionalHeight (firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .Height, relatedBy: .Equal, toItem: secondView, attribute: .Height, multiplier: multipler, constant: constant)
    }
    
    public static func ProportionalHeightToWidth (firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .Height, relatedBy: .Equal, toItem: secondView, attribute: .Width, multiplier: multipler, constant: constant)
    }
    
    public static func ProportionalWidthToHeight (firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .Width, relatedBy: .Equal, toItem: secondView, attribute: .Height, multiplier: multipler, constant: constant)
    }
    
}