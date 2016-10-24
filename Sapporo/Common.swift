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
	case reload
	case insert(IndexSet)
	case move(Int, Int)
	case delete(IndexSet)
}

public enum SectionBumpType {
	case reload(IndexSet)
	case insert([IndexPath])
	case move(IndexPath, IndexPath)
	case delete([IndexPath])
}

public enum ItemBumpType {
	case reload(IndexPath)
}

func classNameOf(_ aClass: AnyClass) -> String {
	return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
