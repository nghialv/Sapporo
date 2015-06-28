//
//  Common.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation

public typealias SASelectionHandler     = (SACell) -> Void
public typealias SADeselectionHandler   = SASelectionHandler


public protocol SectionIndex {
    var intValue: Int { get }
}

public enum SapporoBumpType {
    case Reload
    case Insert(NSIndexSet)
    case Move(Int, Int)
    case Delete(NSIndexSet)
}

public enum SectionBumpType {
    case Reload(NSIndexSet)
    case Insert([NSIndexPath])
    case Move(NSIndexPath, NSIndexPath)
    case Delete([NSIndexPath])
}

public enum ItemBumpType {
    case Reload(NSIndexPath)
}

func classNameOf(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
}