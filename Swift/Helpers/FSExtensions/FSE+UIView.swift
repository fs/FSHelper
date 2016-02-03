//
//  FSExtensions+UIView.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

public extension UIView {
    
    //MARK: - Set size
    
    var fs_size: CGSize {
        set (value) {self.frame.size = value}
        get         {return self.frame.size}
    }
    
    var fs_width:CGFloat {
        set (value) {self.fs_size = CGSizeMake(value, frame.size.height)}
        get         {return self.frame.size.width}
    }
    
    var fs_height:CGFloat {
        set (value) {self.fs_size = CGSizeMake(frame.size.width, value)}
        get         {return self.frame.size.height}
    }
    
    //MARK: - Set origin
    
    var fs_origin: CGPoint {
        set (value) {self.frame.origin = value}
        get         {return self.frame.origin}
    }
    
    var fs_x: CGFloat {
        set (value) {self.fs_origin = CGPointMake(value, frame.origin.y)}
        get         {return self.frame.origin.x}
    }
    
    var fs_y: CGFloat {
        set (value) {self.fs_origin = CGPointMake(frame.origin.x, value)}
        get         {return self.frame.origin.y}
    }
    
    //MARK: - Other
    
    func fs_findAndResignFirstResponder () -> Bool {
        if self.isFirstResponder() {
            self.resignFirstResponder()
            return true
        }
        
        for view in subviews {
            if view.fs_findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
    
    var fs_allSubviews: [UIView] {
        var arr:[UIView] = [self]
        
        for view in subviews {
            arr += view.fs_allSubviews
        }
        
        return arr
    }
}

//MARK: - Extensions for Storyboard
public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set(newValue) { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    
    @IBInspectable var borderColor: UIColor {
        set(newValue) { self.layer.borderColor = newValue.CGColor }
        get { return UIColor(CGColor: self.layer.borderColor!) }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set(newValue) { self.layer.borderWidth = newValue }
        get { return self.layer.borderWidth }
    }
    
    @IBInspectable var shadowColor: UIColor {
        set(newValue) { self.layer.shadowColor = newValue.CGColor }
        get { return UIColor(CGColor: self.layer.shadowColor!) }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set(newValue) { self.layer.shadowOffset = newValue }
        get { return  self.layer.shadowOffset}
    }
    
    @IBInspectable var shadowOpacity: Float {
        set(newValue) { self.layer.shadowOpacity = newValue }
        get { return  self.layer.shadowOpacity}
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set(newValue) { self.layer.shadowRadius = newValue }
        get { return  self.layer.shadowRadius}
    }
    
    @IBInspectable var masksToBounds: Bool {
        set(newValue) { self.layer.masksToBounds = newValue }
        get { return self.layer.masksToBounds }
    }
}

//MARK: - Collection View Animated Reload {
extension UICollectionView {
    
    func reloadDataWithAnimation(duration: NSTimeInterval = 0.2, options: UIViewAnimationOptions, completion: ((Bool) -> Void)?) {
        
        UIView.transitionWithView(self,
            duration: duration,
            options: options,
            animations: { [weak self] () -> Void in
                self?.reloadData()
            },
            completion: completion)
    }
}

//MARK: - Table View Animated Reload {
extension UITableView {
    
    func reloadDataWithAnimation(duration: NSTimeInterval = 0.2, options: UIViewAnimationOptions, completion: ((Bool) -> Void)?) {
        
        UIView.transitionWithView(self,
            duration: duration,
            options: options,
            animations: { [weak self] () -> Void in
                self?.reloadData()
            },
            completion: completion)
    }
}