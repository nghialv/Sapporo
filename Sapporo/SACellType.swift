//
//  SACellType.swift
//  Example
//
//  Created by Le VanNghia on 4/3/16.
//  Copyright © 2016 Le Van Nghia. All rights reserved.
//

import Foundation

public protocol SACellType {
    associatedtype CellModel
    
    var cellmodel: CellModel? { get }
}

public extension SACellType where Self: SACell {
    var cellmodel: CellModel? {
        return _cellmodel as? CellModel
    }
}