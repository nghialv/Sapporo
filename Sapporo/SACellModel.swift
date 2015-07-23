//
//  SACellModel.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

protocol SACellModelDelegate: class {
    func bumpMe(type: ItemBumpType)
	func getOffscreenCell(identifier: String) -> SACell
}

public class SACellModel: NSObject {
    weak var delegate               : SACellModelDelegate?
    public let reuseIdentifier      : String
    public internal(set) var indexPath = NSIndexPath(forRow: 0, inSection: 0)
	
    public var selectionHandler     : SASelectionHandler?
    public var deselectHandler      : SADeselectionHandler?
	
	private var dynamicSizeEnabled	= false
	private var estimatedSize		= CGSize.zeroSize
	private var calculatedSize		: CGSize?
	
	public var width				: CGFloat = 320
	public var size: CGSize {
		set {
			estimatedSize = newValue
		}
		get {
			if !dynamicSizeEnabled {
				return estimatedSize
			}
			if let size = calculatedSize {
				return size
			}
			calculatedSize = calculateSize()
			return calculatedSize ?? estimatedSize
		}
	}
	
    public init<T: SACell>(cellType: T.Type, size: CGSize, selectionHandler: SASelectionHandler?) {
        self.reuseIdentifier = cellType.reuseIdentifier
        self.estimatedSize = size
        self.selectionHandler = selectionHandler
        super.init()
    }
    
    public init<T: SACell>(cellType: T.Type, selectionHandler: SASelectionHandler?) {
        self.reuseIdentifier = cellType.reuseIdentifier
        self.estimatedSize = CGSize.zeroSize
        self.selectionHandler = selectionHandler
        super.init()
    }
	
    func setup(indexPath: NSIndexPath, delegate: SACellModelDelegate) {
        self.indexPath = indexPath
        self.delegate = delegate
    }
    
    func didSelect(cell: SACell) {
        selectionHandler?(cell)
    }
    
    func didDeselect(cell: SACell) {
        deselectHandler?(cell)
    }
	
	public func enableDynamicHeight(width: CGFloat) {
		dynamicSizeEnabled = true
		self.width = width
	}
	
	public func disableDynamicHeight() {
		dynamicSizeEnabled = false
	}
	
    public func bump() {
		calculatedSize = nil
        delegate?.bumpMe(ItemBumpType.Reload(indexPath))
    }
}

private extension SACellModel {
	func calculateSize() -> CGSize? {
		if let cell = delegate?.getOffscreenCell(reuseIdentifier) {
			cell.configure(self)
			cell.bounds = CGRectMake(0, 0, width, cell.bounds.height)
			cell.setNeedsLayout()
			cell.layoutIfNeeded()
			
			var size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
			size.width = width
			return size
		}
		return nil
	}
}