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

public protocol SASectionIndexType {
    var intValue: Int { get }
    static var count: Int { get }
}

public extension SASectionIndexType where Self: RawRepresentable, Self.RawValue == Int {
    var intValue: Int {
        return rawValue
    }
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
