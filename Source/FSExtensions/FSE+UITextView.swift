//
//  FSE+UITextField.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

open class FSTextView :UITextView {
    
    fileprivate(set) var placeholderLabel:UILabel = UILabel()
    
    @IBInspectable open  var placeholderColor:UIColor {
        set (value) {
            self.placeholderLabel.textColor = value
        }
        get {
            return self.placeholderLabel.textColor
        }
    }
    
    @IBInspectable open  var placeholder: String? {
        set (value) {
            self.placeholderLabel.text = value
        }
        get {
            return self.placeholderLabel.text
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            self.placeholderLabel.preferredMaxLayoutWidth = self.frame.width
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.removeObserver(self, forKeyPath: "text")
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    fileprivate func initialize () {
        self.setupInsets()
        self.setupPlaceholder()
        
        self.addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.new, context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing(_:)), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing(_:)), name: NSNotification.Name.UITextViewTextDidEndEditing, object: self)
    }
    
    fileprivate func setupInsets () {
        self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.textContainer.lineFragmentPadding = 0
    }
    
    fileprivate func setupPlaceholder () {
        self.placeholderLabel.preferredMaxLayoutWidth = self.frame.width
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.placeholderLabel.textColor = FSRGBA(198, 198, 204, 1)
        self.placeholderLabel.isUserInteractionEnabled = false
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.font = self.font
        
        self.addSubview(self.placeholderLabel)
        
        let insets = self.textContainerInset
        let views = ["label": self.placeholderLabel]
        let metrics = ["LEFT": insets.left, "TOP": insets.top, "RIGHT": insets.right, "BOTTOM": insets.bottom]
        
        var constraints:[NSLayoutConstraint] = []
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-LEFT-[label]-RIGHT-|", options: [], metrics: metrics, views: views) 
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-TOP-[label]-(>=BOTTOM)-|", options: [], metrics: metrics, views: views) 
        for constraint in constraints {
            constraint.priority = 751
        }
        
        self.addConstraints(constraints)
        self.textViewDidChange(nil)
    }
    
    override class open func fs_getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        let textView = FSTextView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        textView.font = font
        textView.text = text
        return textView.fs_textHeight
    }
    
    override open var fs_textHeight:CGFloat {
        return super.fs_textHeight
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath ==  "text" || object as? NSObject == self {
            self.textViewDidChange(nil)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //MARK: - Notifications
    func textViewDidBeginEditing (_ sender: AnyObject?) {
        
    }
    
    func textViewDidChange (_ sender: AnyObject?) {
        if self.text.characters.count == 0 {
            self.placeholderLabel.isHidden = false
        } else {
            self.placeholderLabel.isHidden = true
        }
    }
    
    func textViewDidEndEditing (_ sender: AnyObject?) {
        
    }
    
}

extension UITextView {
    
    class public func fs_getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        textView.font = font
        textView.text = text
        return textView.fs_textHeight
    }
    
    public var fs_textHeight:CGFloat {
        let size = self.sizeThatFits(CGSize(width: self.fs_width, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 1
    }
}
