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

public func preCalculateSizeForCellmodels(cellmodels: [SACellModel], offscreenCells: [String: SACell] = [:]) -> [String: SACell] {
	var cells: [String: SACell] = offscreenCells

	func getOffscreenCell(identifier: String) -> SACell {
		if let cell = cells[identifier] {
			return cell
		}
		let cell = UINib(nibName: identifier, bundle: nil).instantiateWithOwner(nil, options: nil).first as! SACell
		cells[identifier] = cell
		return cell
	}
	
	for cellmodel in cellmodels {
		let cell = getOffscreenCell(cellmodel.reuseIdentifier)
		cellmodel.preCalculateSize(cell)
	}
	
	return cells
}