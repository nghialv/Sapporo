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
}


public class SACellModel {
    weak var delegate               : SACellModelDelegate?
    public let reuseIdentifier      : String
    internal(set) var indexPath     = NSIndexPath(forRow: 0, inSection: 0)
    
    public var size                 = CGSize.zeroSize
    public var selectionHandler     : SASelectionHandler?
    public var deselectHandler      : SADeselectionHandler?
    
    
    public init<T: SACell>(cellType: T.Type, size: CGSize, selectionHandler: SASelectionHandler?) {
        self.reuseIdentifier = cellType.reuseIdentifier
        self.size = size
        self.selectionHandler = selectionHandler
    }
    
    public init<T: SACell>(cellType: T.Type, selectionHandler: SASelectionHandler?) {
        self.reuseIdentifier = cellType.reuseIdentifier
        self.size = CGSize.zeroSize
        self.selectionHandler = selectionHandler
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
    
    public func bump() {
        delegate?.bumpMe(ItemBumpType.Reload(indexPath))
    }
}