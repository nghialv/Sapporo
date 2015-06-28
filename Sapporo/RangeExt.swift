//
//  RangeExt.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation

extension NSRange {
    init(range: Range<Int>) {
        self.location = range.startIndex
        self.length = range.endIndex - range.startIndex
    }
}