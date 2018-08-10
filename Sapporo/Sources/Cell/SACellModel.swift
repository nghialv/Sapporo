//
//  SACellModel.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

protocol SACellModelDelegate: class {
    func bumpMe(_ type: ItemBumpType)
    func getOffscreenCell(_ identifier: String) -> SACell?
    func deselectItem(_ indexPath: IndexPath, animated: Bool)
}

open class SACellModel: NSObject {
    weak var delegate: SACellModelDelegate?
    open let reuseIdentifier: String
    open internal(set) var indexPath: IndexPath = .init(row: 0, section: 0)
    
    open var selectionHandler: SASelectionHandler?
    open var deselectHandler: SADeselectionHandler?
    
    private var dynamicSizeEnabled = false
    private var estimatedSize: CGSize = .zero
    private var calculatedSize: CGSize?
    
    open var width: CGFloat = 320
    open var size: CGSize {
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
            if let cell = delegate?.getOffscreenCell(reuseIdentifier) {
                calculatedSize = calculateSize(cell)
            }
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
        self.estimatedSize = .zero
        self.selectionHandler = selectionHandler
        super.init()
    }
    
    func setup(_ indexPath: IndexPath, delegate: SACellModelDelegate) {
        self.indexPath = indexPath
        self.delegate = delegate
    }
    
    func didSelect(_ cell: SACell) {
        selectionHandler?(cell)
    }
    
    func didDeselect(_ cell: SACell) {
        deselectHandler?(cell)
    }
    
    open func enableDynamicHeight(_ width: CGFloat) {
        dynamicSizeEnabled = true
        self.width = width
    }
    
    open func disableDynamicHeight() {
        dynamicSizeEnabled = false
    }
    
    open func setPreCalculatedSize(_ size: CGSize) {
        calculatedSize = size
    }
    
    open func deselect(_ animated: Bool) {
        delegate?.deselectItem(indexPath, animated: animated)
    }
    
    open func bump() {
        calculatedSize = nil
        delegate?.bumpMe(.reload(indexPath))
    }
}

private extension SACellModel {
    func calculateSize(_ cell: SACell) -> CGSize {
        cell.configureForSizeCalculating(self)
        cell.bounds = .init(origin: .zero, size: .init(width: width, height: cell.bounds.height))
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        var size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        size.width = width
        return size
    }
}
