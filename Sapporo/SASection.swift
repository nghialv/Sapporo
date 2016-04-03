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
	public var headerReferenceSize      = CGSize.zero
	public var footerReferenceSize      = CGSize.zero
	
	public var headerViewModel          : SAFlowLayoutSupplementaryViewModel?
	public var footerViewModel          : SAFlowLayoutSupplementaryViewModel?
	public var willBumpHandler			: (Int -> Void)?
	
	public var itemsCount: Int {
		return cellmodels.count
	}
	
    var changed: Bool {
        return bumpTracker.changed
    }
    
	public init() {
	}
	
	public subscript(index: Int) -> SACellModel? {
		get {
			return cellmodels.get(index)
		}
	}
	
	public func bump() {
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
    
    func reset() -> Self {
        return reset([])
    }
    
    func reset(cellmodel: SACellModel) -> Self {
        return reset([cellmodel])
    }
    
	func reset(cellmodels: [SACellModel]) -> Self {
		setupCellmodels(cellmodels, indexFrom: 0)
		self.cellmodels = cellmodels
		bumpTracker.didReset()
		return self
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
    
	func insert(cellmodels: [SACellModel], atIndex index: Int) -> Self {
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
        let index = cellmodels.indexOf { return $0 === cellmodel }
        
        guard let i = index else {
            return self
        }
        
        return remove(i)
    }

	func remove(indexes: [Int]) -> Self {
        guard indexes.isNotEmpty else {
            return self
        }
        
		let sortedIndexes = indexes
            .sort(<)
            .filter { $0 >= 0 && $0 < self.itemsCount }
		
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
		setupCellmodels(cellmodels, indexFrom: 0)
		
		bumpTracker.didRemove(indexes)
		
		return self
	}
    
    // Move
    
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
    func setup(index: Int, delegate: SASectionDelegate) {
        self.delegate = delegate
        self.index = index
        
        setupCellmodels(cellmodels, indexFrom: 0)
    }
}

// MARK - Private methods

private extension SASection {
	func setupCellmodels(cellmodels: [SACellModel], var indexFrom start: Int) {
        guard let delegate = delegate as? SACellModelDelegate else {
            return
        }
        
        cellmodels.forEach {
            let indexPath = NSIndexPath(forRow: start++, inSection: index)
            $0.setup(indexPath, delegate: delegate)
        }
	}
}