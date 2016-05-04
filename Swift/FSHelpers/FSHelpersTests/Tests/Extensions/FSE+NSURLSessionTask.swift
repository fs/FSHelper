//
//  FSE+NSURLSessionTask.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import Foundation

public extension NSURLSessionTask {
    public var statusCode: Int? {
        guard let response = self.response as? NSHTTPURLResponse else {return nil}
        return response.statusCode
    }
}
