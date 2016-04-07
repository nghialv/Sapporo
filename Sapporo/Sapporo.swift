//
//  Sapporo.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

final public class Sapporo: NSObject {
	private let bumpTracker				= SABumpTracker()
	private var offscreenCells: [String: SACell] = [:]
	public private(set) var sections	: [SASection] = []
	
	public let collectionView		: UICollectionView
	public weak var delegate		: SapporoDelegate?
	public var loadmoreHandler		: (() -> Void)?
	public var loadmoreEnabled		= false
	public var loadmoreDistanceThreshold: CGFloat = 50
	public var willBumpHandler		: (Int -> Void)?
	
	public var sectionsCount: Int {
		return sections.count
	}
	
	public subscript(index: SASectionIndexType) -> SASection {
		get {
			return self[index.intValue]
		}
		set {
			self[index.intValue] = newValue
		}
	}
	
	public subscript(index: Int) -> SASection {
		get {
            return sections[index]
		}
		set {
            setupSections([newValue], fromIndex: index)
            sections[index] = newValue
		}
	}
	
	public subscript(indexPath: NSIndexPath) -> SACellModel? {
		return self[indexPath.section][indexPath.row]
	}
	
    public func getSection(index: Int) -> SASection? {
        return sections.get(index)
    }
    
    public func getSection(index: SASectionIndexType) -> SASection? {
        return getSection(index.intValue)
    }
    
	public init(collectionView: UICollectionView) {
		self.collectionView = collectionView
		super.init()
		collectionView.dataSource = self
		collectionView.delegate = self
	}

	deinit {
		collectionView.dataSource = nil
		collectionView.delegate = nil
	}
	
    public func bump() -> Self {
        willBumpHandler?(sectionsCount)
        
        let changedCount = sections.reduce(0) { $0 + ($1.changed ? 1 : 0) }
        
        if changedCount == 0 {
            switch bumpTracker.getSapporoBumpType() {
            case .Reload:
                collectionView.reloadData()
                
            case let .Insert(indexSet):
                collectionView.insertSections(indexSet)
                
            case let .Delete(indexSet):
                collectionView.deleteSections(indexSet)
                
            case let .Move(from, to):
                collectionView.moveSection(from, toSection: to)
            }
        } else {
            collectionView.reloadData()
            sections.forEach { $0.didReloadCollectionView() }
        }
        
        bumpTracker.didBump()
        return self
	}
}

// MARK - SACellModelDelegate, SASectionDelegate

extension Sapporo: SACellModelDelegate, SASectionDelegate {
	func bumpMe(type: ItemBumpType) {
		switch type {
		case .Reload(let indexPath): collectionView.reloadItemsAtIndexPaths([indexPath])
		}
	}
	
	func bumpMe(type: SectionBumpType) {
		willBumpHandler?(sectionsCount)
		switch type {
		case .Reload(let indexset)  : collectionView.reloadSections(indexset)
		case .Insert(let indexPaths): collectionView.insertItemsAtIndexPaths(indexPaths)
		case .Move(let ori, let new): collectionView.moveItemAtIndexPath(ori, toIndexPath: new)
		case .Delete(let indexPaths): collectionView.deleteItemsAtIndexPaths(indexPaths)
		}
	}
	
	func getOffscreenCell(identifier: String) -> SACell {
		if let cell = offscreenCells[identifier] {
			return cell
		}
		let cell = UINib(nibName: identifier, bundle: nil).instantiateWithOwner(nil, options: nil).first as! SACell
		offscreenCells[identifier] = cell
		return cell
	}
	
	func deselectItem(indexPath: NSIndexPath, animated: Bool) {
		collectionView.deselectItemAtIndexPath(indexPath, animated: animated)
	}
}

// MARK - Public methods

public extension Sapporo {
	// Reset
    
    func reset(listType: SASectionIndexType.Type) -> Self {
        let sections = (0..<listType.count).map { _ in SASection() }
        return reset(sections)
    }
    
	func reset() -> Self {
        return reset([])
	}
    
    func reset(section: SASection) -> Self {
        return reset([section])
    }
    
    func reset(sections: [SASection]) -> Self {
        setupSections(sections, fromIndex: 0)
        self.sections = sections
        bumpTracker.didReset()
        return self
    }
	
    // Append
    
    func append(section: SASection) -> Self {
        return append([section])
    }
    
    func append(sections: [SASection]) -> Self {
        return insert(sections, atIndex: sectionsCount)
    }
    
	// Insert
    
	func insert(section: SASection, atIndex index: Int) -> Self {
		return insert([section], atIndex: index)
	}
	
	func insert(sections: [SASection], atIndex index: Int) -> Self {
        guard sections.isNotEmpty else {
            return self
        }
        
        let sIndex = min(max(index, 0), sectionsCount)
        setupSections(sections, fromIndex: sIndex)
        let r = self.sections.insert(sections, atIndex: sIndex)
        bumpTracker.didInsert(Array(r))
		
		return self
	}

    func insertBeforeLast(section: SASection) -> Self {
        return insertBeforeLast([section])
    }
    
    func insertBeforeLast(sections: [SASection]) -> Self {
        let index = max(sections.count - 1, 0)
        return insert(sections, atIndex: index)
    }
    
	// Remove
    
    func remove(index: Int) -> Self {
        return remove(indexes: [index])
    }
    
    func remove(range: Range<Int>) -> Self {
        let indexes = range.map { $0 }
        return remove(indexes: indexes)
    }
    
    func remove(indexes indexes: [Int]) -> Self {
        guard indexes.isNotEmpty else {
            return self
        }
        
        let sortedIndexes = indexes
            .sort(<)
            .filter { $0 >= 0 && $0 < self.sectionsCount }
        
        var remainSections: [SASection] = []
        var i = 0
        
        for j in 0..<sectionsCount {
            if let k = sortedIndexes.get(i) where k == j {
                i += 1
            } else {
                remainSections.append(sections[j])
            }
        }
        
        sections = remainSections
        setupSections(sections, fromIndex: 0)
        
        bumpTracker.didRemove(sortedIndexes)
        
        return self
    }
    
    func removeLast() -> Self {
        let index = sectionsCount - 1
        
        guard index >= 0 else {
            return self
        }
        
        return remove(index)
    }
    
    func remove(section: SASection) -> Self {
        let index = section.index
        
        guard index >= 0 && index < sectionsCount else {
            return self
        }
        
        return remove(index)
    }
    
    func removeAll() -> Self {
        return reset()
    }
    
    // Move
    
    func move(from: Int, to: Int) -> Self {
        sections.move(fromIndex: from, toIndex: to)
        setupSections([sections[from]], fromIndex: from)
        setupSections([sections[to]], fromIndex: to)
        
        bumpTracker.didMove(from, to: to)
        return self
    }
}

// MARK - Layout

public extension Sapporo {
	public func setLayout(layout: UICollectionViewLayout) {
		collectionView.collectionViewLayout = layout
	}
	
	public func setLayout(layout: UICollectionViewLayout, animated: Bool) {
		collectionView.setCollectionViewLayout(layout, animated: animated)
	}
	
	public func setLayout(layout: UICollectionViewLayout, animated: Bool, completion: Bool -> Void) {
		collectionView.setCollectionViewLayout(layout, animated: animated, completion: completion)
	}
}

// MARK - Utilities

public extension Sapporo {
	var isEmpty: Bool {
		return sections.isEmpty
	}
	
	var isNotEmpty: Bool {
		return !isEmpty
	}
	
	var isFlowLayout: Bool {
		return collectionView.collectionViewLayout is SAFlowLayout
	}
	
    var direction: UICollectionViewScrollDirection {
		let layout = collectionView.collectionViewLayout as? SAFlowLayout
		return layout?.scrollDirection ?? .Vertical
    }
	
	func cellAtIndexPath(indexPath: NSIndexPath) -> SACell? {
		return collectionView.cellForItemAtIndexPath(indexPath) as? SACell
	}
}

// MARK - Private methods

private extension Sapporo {
	func setupSections(sections: [SASection], fromIndex start: Int) {
        var start = start
        
        sections.forEach {
            $0.setup(start, delegate: self)
            start += 1
        }
	}
}