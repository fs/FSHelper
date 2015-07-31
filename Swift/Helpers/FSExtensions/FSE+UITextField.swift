//
//  FSE+UITextField.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

class FSTextView :UITextView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textContainerInset = UIEdgeInsetsMake(-4,0,0,0)
        self.textContainer.lineFragmentPadding = 0
    }
    
    class func getHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        let textView = UITextView(frame: CGRectMake(0, 0, width, 0))
        textView.textContainerInset = UIEdgeInsetsMake(-4,0,0,0)
        textView.textContainer.lineFragmentPadding = 0
        textView.font = font
        textView.text = text
        let size = textView.sizeThatFits(CGSizeMake(width, CGFloat.max))
        return size.height + 1
    }
}

extension UITextView {
    
    class func getTextHeight (forText text:String, width:CGFloat, font:UIFont) -> CGFloat {
        
        let textView = UITextView(frame: CGRectMake(0, 0, width, 0))
        textView.font = font
        textView.text = text
        let size = textView.sizeThatFits(CGSizeMake(width, CGFloat.max))
        return size.height + 1
    }
}
