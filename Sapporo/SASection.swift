//
//  SASection.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

protocol SASectionDelegate: class {
    func bumpMe(type: SectionBumpType)
}


public class SASection {
    weak var delegate                   : SASectionDelegate?
    public private(set) var cellmodels  : [SACellModel] = []
    private let bumpTracker             = SABumpTracker()
    
    internal(set) var index             : Int = 0
    
    public var inset                    = UIEdgeInsets()
    public var minimumInteritemSpacing  : CGFloat = 0
    public var minimumLineSpacing       : CGFloat = 0
    public var headerReferenceSize      = CGSize.zeroSize
    public var footerReferenceSize      = CGSize.zeroSize
    
    public var headerViewModel          : SAFlowLayoutSupplementaryViewModel?
    public var footerViewModel          : SAFlowLayoutSupplementaryViewModel?
    
    public var itemsCount: Int {
        return cellmodels.count
    }
    
    public init() {
    }
    
    func setup(index: Int, delegate: SASectionDelegate) {
        self.delegate = delegate
        self.index = index
        setupForCellModels(cellmodels, indexFrom: 0)
    }
    
    public subscript(index: Int) -> SACellModel? {
        get {
            return cellmodels.get(index)
        }
    }
    
    public func bump() {
        let type = bumpTracker.getSectionBumpType(index)
        delegate?.bumpMe(type)
        bumpTracker.didBump()
    }
}

public extension SASection {
    
    // Reset
    func reset(cellmodels: [SACellModel]) -> Self {
        setupForCellModels(cellmodels, indexFrom: 0)
        
        self.cellmodels = cellmodels
        
        bumpTracker.didReset()
        
        return self
    }
    
    // Insert
    func insert(cellmodels: [SACellModel], atIndex index: Int) -> Self {
        let start = min(itemsCount, index)
        self.cellmodels.insert(cellmodels, atIndex: start)
        
        let affectedCellmodels = Array(self.cellmodels[start..<itemsCount])
        setupForCellModels(affectedCellmodels, indexFrom: start)
        
        let indexes = (index..<(index + cellmodels.count)).map { $0 }
        bumpTracker.didInsert(indexes)
        
        return self
    }
    
    // Move
    func move(fromIndex from: Int, toIndex to: Int) -> Self {
        let moved = cellmodels.move(fromIndex: from, toIndex: to)
        
        if moved {
            let f = min(from, to)
            let t = max(from, to)
            let affectedCellmodels = Array(cellmodels[f...t])
            setupForCellModels(affectedCellmodels, indexFrom: f)
            
            bumpTracker.didMove(from, to: to)
        }
        
        return self
    }
    
    // Remove
    func remove(indexes: [Int]) -> Self {
        let sortedIndexes = indexes.sorted(<).filter { $0 >= 0 && $0 < self.itemsCount }
        
        var remainCellmodels: [SACellModel] = []
        var i = 0
        
        for j in 0..<itemsCount {
            if let k = sortedIndexes.get(i) where k == j {
                i++
            } else {
                remainCellmodels.append(cellmodels[j])
            }
        }
        cellmodels = remainCellmodels
        setupForCellModels(cellmodels, indexFrom: 0)
        
        bumpTracker.didRemove(indexes)
        
        return self
    }
}

// Convinience
public extension SASection {
    // Reset
    func reset() -> Self {
        return reset([])
    }
    
    func reset(cellmodel: SACellModel) -> Self {
        return reset([cellmodel])
    }
    
    
    // Append
    func append(cellmodels: [SACellModel]) -> Self {
        return insert(cellmodels, atIndex: itemsCount)
    }
    
    func append(cellmodel: SACellModel) -> Self {
        return append([cellmodel])
    }
    
    
    // Insert
    func insert(cellmodel: SACellModel, atIndex index: Int) -> Self {
        return insert([cellmodel], atIndex: index)
    }
    
    func insertBeforeLast(cellmodels: [SACellModel]) -> Self {
        let index = max(itemsCount - 1, 0)
        return insert(cellmodels, atIndex: index)
    }
    
    func insertBeforeLast(cellmodel: SACellModel) -> Self {
        return insertBeforeLast([cellmodel])
    }
    
    // Remove
    func remove(index: Int) -> Self {
        return remove([index])
    }
    
    func removeLast() -> Self {
        let index = itemsCount - 1
        return index >= 0 ? remove([index]) : self
    }
    
    func remove(range: Range<Int>) -> Self {
        let indexes = range.map { $0 }
        return remove(indexes)
    }
    
    func remove(cellmodel: SACellModel) -> Self {
        for index in 0..<itemsCount {
            if cellmodel === cellmodels[index] {
                return remove([index])
            }
        }
        return self
    }
}

// Utilities
public extension SASection {
    var isEmpty: Bool {
        return cellmodels.isEmpty
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

// Private methods
private extension SASection {
    func setupForCellModels(cellmodels: [SACellModel], indexFrom start: Int) {
        if let delegate = delegate as? SACellModelDelegate {
            var start = start
            for cellmodel in cellmodels {
                let indexPath = NSIndexPath(forRow: start++, inSection: self.index)
                cellmodel.setup(indexPath, delegate: delegate)
            }
        }
    }
}