//
//  SASection.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

protocol SASectionDelegate: class {
    func bumpMe(_ type: SectionBumpType)
}

open class SASection {
    weak var delegate: SASectionDelegate?
    open private(set) var cellmodels: [SACellModel] = []
    private let bumpTracker: SABumpTracker = .init()
    
    internal(set) var index: Int = 0
    
    open var inset: UIEdgeInsets = .init()
    open var minimumInteritemSpacing: CGFloat = 0
    open var minimumLineSpacing: CGFloat = 0
    open var headerReferenceSize: CGSize = .zero
    open var footerReferenceSize: CGSize = .zero
    
    open var headerViewModel: SAFlowLayoutSupplementaryViewModel?
    open var footerViewModel: SAFlowLayoutSupplementaryViewModel?
    open var willBumpHandler: ((Int) -> Void)?
    
    open var itemsCount: Int {
        return cellmodels.count
    }
    
    var changed: Bool {
        return bumpTracker.changed
    }
    
    public init() {}
    
    open subscript(index: Int) -> SACellModel? {
        return cellmodels.get(index)
    }
    
    open func bump() {
        let type = bumpTracker.getSectionBumpType(index)
        willBumpHandler?(itemsCount)
        delegate?.bumpMe(type)
        bumpTracker.didBump()
    }
    
    func didReloadCollectionView() {
        bumpTracker.didBump()
    }
}

// MARK - Public methods

public extension SASection {
    
    // Reset
    
    @discardableResult
    func reset() -> Self {
        return reset([])
    }
    
    @discardableResult
    func reset(_ cellmodel: SACellModel) -> Self {
        return reset([cellmodel])
    }
    
    @discardableResult
    func reset(_ cellmodels: [SACellModel]) -> Self {
        setupCellmodels(cellmodels, indexFrom: 0)
        self.cellmodels = cellmodels
        bumpTracker.didReset()
        return self
    }
    
    // Append
    
    @discardableResult
    func append(_ cellmodels: [SACellModel]) -> Self {
        return insert(cellmodels, atIndex: itemsCount)
    }
    
    @discardableResult
    func append(_ cellmodel: SACellModel) -> Self {
        return append([cellmodel])
    }
    
    // Insert
    
    @discardableResult
    func insert(_ cellmodel: SACellModel, atIndex index: Int) -> Self {
        return insert([cellmodel], atIndex: index)
    }
    
    @discardableResult
    func insertBeforeLast(_ cellmodels: [SACellModel]) -> Self {
        let index = max(itemsCount - 1, 0)
        return insert(cellmodels, atIndex: index)
    }
    
    @discardableResult
    func insertBeforeLast(_ cellmodel: SACellModel) -> Self {
        return insertBeforeLast([cellmodel])
    }
    
    @discardableResult
    func insert(_ cellmodels: [SACellModel], atIndex index: Int) -> Self {
        guard cellmodels.isNotEmpty else {
            return self
        }
        
        let start = min(itemsCount, index)
        self.cellmodels.insert(cellmodels, atIndex: start)
        
        let affectedCellmodels = Array(self.cellmodels[start..<itemsCount])
        setupCellmodels(affectedCellmodels, indexFrom: start)
        
        let indexes = (index..<(index + cellmodels.count)).map { $0 }
        bumpTracker.didInsert(indexes)
        
        return self
    }
    
    // Remove
    
    @discardableResult
    func remove(_ index: Int) -> Self {
        return remove([index])
    }
    
    @discardableResult
    func removeLast() -> Self {
        let index = itemsCount - 1
        return index >= 0 ? remove([index]) : self
    }
    
    @discardableResult
    func remove(_ range: CountableRange<Int>) -> Self {
        let indexes = Array(range)
        return remove(indexes)
    }
    
    @discardableResult
    func remove(_ range: CountableClosedRange<Int>) -> Self {
        return remove(range.map { $0 })
    }
    
    @discardableResult
    func remove(_ cellmodel: SACellModel) -> Self {
        let index = cellmodels.index { return $0 === cellmodel }
        
        guard let i = index else {
            return self
        }
        
        return remove(i)
    }
    
    @discardableResult
    func remove(_ indexes: [Int]) -> Self {
        guard indexes.isNotEmpty else {
            return self
        }
        
        let sortedIndexes = indexes
            .sorted(by: <)
            .filter { $0 >= 0 && $0 < self.itemsCount }
        
        var remainCellmodels: [SACellModel] = []
        var i = 0
        
        for j in 0..<itemsCount {
            if let k = sortedIndexes.get(i) , k == j {
                i += 1
            } else {
                remainCellmodels.append(cellmodels[j])
            }
        }
        cellmodels = remainCellmodels
        setupCellmodels(cellmodels, indexFrom: 0)
        
        bumpTracker.didRemove(indexes)
        
        return self
    }
    
    // Move
    
    @discardableResult
    func move(fromIndex from: Int, toIndex to: Int) -> Self {
        let moved = cellmodels.move(fromIndex: from, toIndex: to)
        
        if moved {
            let f = min(from, to)
            let t = max(from, to)
            let affectedCellmodels = Array(cellmodels[f...t])
            setupCellmodels(affectedCellmodels, indexFrom: f)
            
            bumpTracker.didMove(from, to: to)
        }
        
        return self
    }
}

// MARK - Utilities

public extension SASection {
    var isEmpty: Bool {
        return cellmodels.isEmpty
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

// MARK - Internal methods

extension SASection {
    func setup(_ index: Int, delegate: SASectionDelegate) {
        self.delegate = delegate
        self.index = index
        
        setupCellmodels(cellmodels, indexFrom: 0)
    }
}

// MARK - Private methods

private extension SASection {
    func setupCellmodels(_ cellmodels: [SACellModel], indexFrom start: Int) {
        guard let delegate = delegate as? SACellModelDelegate else {
            return
        }
        
        var start = start
        
        cellmodels.forEach {
            let indexPath = IndexPath(row: start, section: index)
            $0.setup(indexPath, delegate: delegate)
            start += 1
        }
    }
}
