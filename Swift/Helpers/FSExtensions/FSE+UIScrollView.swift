//
//  FSE+UIScrollView.swift
//  FSHelpers
//
//  Created by Ildar Zalyalov on 27.07.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

public extension UIScrollView{
    
    var fs_contentWidth: CGFloat {
        set (contentWidht) {self.contentSize = CGSizeMake(contentWidht, self.contentSize.height)}
        get         {return self.contentSize.width}
    }
    
    var fs_contentHeight: CGFloat {
        set (contentHeight) {self.contentSize = CGSizeMake(self.contentSize.width, contentHeight)}
        get         {return self.contentSize.height}
    }
    
}