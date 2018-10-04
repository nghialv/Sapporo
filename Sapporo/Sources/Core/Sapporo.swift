//
//  Sapporo.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

final public class Sapporo: NSObject {
    private let bumpTracker: SABumpTracker = .init()
    private var offscreenCells: [String: SACell] = [:]
    
    public private(set) var sections: [SASection] = []
    
    public let collectionView: UICollectionView
    public weak var delegate: SapporoDelegate?
    public var loadmoreHandler: (() -> Void)?
    public var loadmoreEnabled = false
    public var loadmoreDistanceThreshold: CGFloat = 50
    public var willBumpHandler: ((Int) -> Void)?
    
    public var sectionsCount: Int {
        return sections.count
    }
    
    public subscript<T: RawRepresentable & SASectionIndexType>(index: T) -> SASection {
        get {
            return self[index.rawValue]
        }
        set {
            self[index.rawValue] = newValue
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
    
    public subscript(indexPath: IndexPath) -> SACellModel? {
        return self[indexPath.section][indexPath.row]
    }
    
    public func getSection(_ index: Int) -> SASection? {
        return sections.get(index)
    }
    
    public func getSection<T: RawRepresentable & SASectionIndexType>(_ index: T) -> SASection? {
        return getSection(index.rawValue)
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
    
    @discardableResult
    public func bump() -> Self {
        willBumpHandler?(sectionsCount)
        
        let changedCount = sections.reduce(0) { $0 + ($1.changed ? 1 : 0) }
        
        if changedCount == 0 {
            switch bumpTracker.getSapporoBumpType() {
            case .reload:
                collectionView.reloadData()
                
            case let .insert(indexSet):
                collectionView.insertSections(indexSet)
                
            case let .delete(indexSet):
                collectionView.deleteSections(indexSet)
                
            case let .move(from, to):
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
    func bumpMe(_ type: ItemBumpType) {
        switch type {
        case .reload(let indexPath):
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func bumpMe(_ type: SectionBumpType) {
        willBumpHandler?(sectionsCount)
        switch type {
        case .reload(let indexset):
            collectionView.reloadSections(indexset)
            
        case .insert(let indexPaths):
            collectionView.insertItems(at: indexPaths)
            
        case .move(let ori, let new):
            collectionView.moveItem(at: ori, to: new)
            
        case .delete(let indexPaths):
            collectionView.deleteItems(at: indexPaths)
        }
    }
    
    func getOffscreenCell(_ identifier: String) -> SACell? {
        if let cell = offscreenCells[identifier] {
            return cell
        }
        
        guard let cell = UINib(nibName: identifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as? SACell else {
            return nil
        }
        offscreenCells[identifier] = cell
        return cell
    }
    
    func deselectItem(_ indexPath: IndexPath, animated: Bool) {
        collectionView.deselectItem(at: indexPath, animated: animated)
    }
}

// MARK - Public methods

public extension Sapporo {
    // Reset
    
    @discardableResult
    func reset<T: RawRepresentable & SASectionIndexType>(_ listType: T.Type) -> Self {
        let sections = (0..<listType.allCases.count).map { _ in SASection() }
        return reset(sections)
    }
    
    @discardableResult
    func reset() -> Self {
        return reset([])
    }
    
    @discardableResult
    func reset(_ section: SASection) -> Self {
        return reset([section])
    }
    
    @discardableResult
    func reset(_ sections: [SASection]) -> Self {
        setupSections(sections, fromIndex: 0)
        self.sections = sections
        bumpTracker.didReset()
        return self
    }
    
    // Append
    
    @discardableResult
    func append(_ section: SASection) -> Self {
        return append([section])
    }
    
    @discardableResult
    func append(_ sections: [SASection]) -> Self {
        return insert(sections, atIndex: sectionsCount)
    }
    
    // Insert
    
    @discardableResult
    func insert(_ section: SASection, atIndex index: Int) -> Self {
        return insert([section], atIndex: index)
    }
    
    @discardableResult
    func insert(_ sections: [SASection], atIndex index: Int) -> Self {
        guard sections.isNotEmpty else {
            return self
        }
        
        let sIndex = min(max(index, 0), sectionsCount)
        setupSections(sections, fromIndex: sIndex)
        let r = self.sections.insert(sections, atIndex: sIndex)
        bumpTracker.didInsert(Array(r))
        
        return self
    }
    
    @discardableResult
    func insertBeforeLast(_ section: SASection) -> Self {
        return insertBeforeLast([section])
    }
    
    @discardableResult
    func insertBeforeLast(_ sections: [SASection]) -> Self {
        let index = max(sections.count - 1, 0)
        return insert(sections, atIndex: index)
    }
    
    // Remove
    
    @discardableResult
    func remove(_ index: Int) -> Self {
        return remove(indexes: [index])
    }
    
    @discardableResult
    func remove(_ range: CountableRange<Int>) -> Self {
        let indexes = Array(range)
        return remove(indexes: indexes)
    }
    
    @discardableResult
    func remove(_ range: CountableClosedRange<Int>) -> Self {
        let indexes = Array(range)
        return remove(indexes: indexes)
    }
    
    @discardableResult
    func remove(indexes: [Int]) -> Self {
        guard indexes.isNotEmpty else {
            return self
        }
        
        let sortedIndexes = indexes
            .sorted(by: <)
            .filter { $0 >= 0 && $0 < self.sectionsCount }
        
        var remainSections: [SASection] = []
        var i = 0
        
        for j in 0..<sectionsCount {
            if let k = sortedIndexes.get(i) , k == j {
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
    
    @discardableResult
    func removeLast() -> Self {
        let index = sectionsCount - 1
        
        guard index >= 0 else {
            return self
        }
        
        return remove(index)
    }
    
    @discardableResult
    func remove(_ section: SASection) -> Self {
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
    
    @discardableResult
    func move(_ from: Int, to: Int) -> Self {
        sections.move(fromIndex: from, toIndex: to)
        setupSections([sections[from]], fromIndex: from)
        setupSections([sections[to]], fromIndex: to)
        
        bumpTracker.didMove(from, to: to)
        return self
    }
}

// MARK - Layout

public extension Sapporo {
    public func setLayout(_ layout: UICollectionViewLayout) {
        collectionView.collectionViewLayout = layout
    }
    
    public func setLayout(_ layout: UICollectionViewLayout, animated: Bool) {
        collectionView.setCollectionViewLayout(layout, animated: animated)
    }
    
    public func setLayout(_ layout: UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Void)? = nil) {
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
    
    var direction: UICollectionView.ScrollDirection {
        let layout = collectionView.collectionViewLayout as? SAFlowLayout
        return layout?.scrollDirection ?? .vertical
    }
    
    func cellForRow(at indexPath: IndexPath) -> SACell? {
        return collectionView.cellForItem(at: indexPath) as? SACell
    }
}

// MARK - Private methods

private extension Sapporo {
    func setupSections(_ sections: [SASection], fromIndex start: Int) {
        var start = start
        
        sections.forEach {
            $0.setup(start, delegate: self)
            start += 1
        }
    }
}
