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
    public private(set) var sections	: [SASection] = []
    
    public let collectionView		: UICollectionView
    public weak var delegate		: SapporoDelegate?
	public var loadmoreHandler		: (() -> Void)?
	public var loadmoreEnabled		= false
	public var loadmoreThreshold	: CGFloat = 25
 
    public var sectionsCount: Int {
        return sections.count
    }
    
    public subscript(index: SectionIndex) -> SASection {
        return self[index.intValue]
    }
    
    public subscript(index: Int) -> SASection {
        get {
            if let section = sections.get(index) {
                return section
            }
            
            let newSections = (sectionsCount...index).map { _ in SASection() }
            setupForSections(newSections, fromIndex: sectionsCount)
            
            sections += newSections
            return sections[index]
        }
    }
    
    public subscript(indexPath: NSIndexPath) -> SACellModel? {
        return self[indexPath.section][indexPath.row]
    }
    
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    public func bump() -> Self {
        let type = bumpTracker.getSaporoBumpType()
        switch type {
        case .Reload                : collectionView.reloadData()
        case .Insert(let indexset)  : collectionView.insertSections(indexset)
        case .Move(let ori, let new): collectionView.moveSection(ori, toSection: new)
        case .Delete(let indexset)  : collectionView.deleteSections(indexset)
        }
        bumpTracker.didBump()
        
        return self
    }
}

extension Sapporo: SACellModelDelegate, SASectionDelegate {
    func bumpMe(type: ItemBumpType) {
        switch type {
        case .Reload(let indexPath): collectionView.reloadItemsAtIndexPaths([indexPath])
        }
    }
    
    func bumpMe(type: SectionBumpType) {
        switch type {
        case .Reload(let indexset)  : collectionView.reloadSections(indexset)
        case .Insert(let indexPaths): collectionView.insertItemsAtIndexPaths(indexPaths)
        case .Move(let ori, let new): collectionView.moveItemAtIndexPath(ori, toIndexPath: new)
        case .Delete(let indexPaths): collectionView.deleteItemsAtIndexPaths(indexPaths)
        }
    }
}

// Reset, Insert, Move, Remove
public extension Sapporo {
    // Reset
    func reset() -> Self {
        sections = []
        
        bumpTracker.didReset()
        
        return self
    }
    
    // Insert
    func insert(section: SASection, atIndex index: Int) -> Self {
        return insert([section], atIndex: index)
    }
    
    func insert(sections: [SASection], atIndex index: Int) -> Self {
        self.sections.insert(sections, atIndex: index)
        
        let affectedSections = Array(self.sections[index..<sectionsCount])
        setupForSections(affectedSections, fromIndex: index)
        
        let indexes = (index..<(index + sections.count)).map { $0 }
        bumpTracker.didInsert(indexes)
        
        return self
    }
    
    // Move
    func move(fromIndex from: Int, toIndex to: Int) -> Self {
        let moved = sections.move(fromIndex: from, toIndex: to)
        
        if moved {
            let f = min(from, to)
            let t = max(from, to)
            let affectedSections = Array(sections[f...t])
            setupForSections(affectedSections, fromIndex: f)
            
            bumpTracker.didMove(from, to: to)
        }
        
        return self
    }
    
    // Remove
    func remove(index: Int) -> Self {
        sections.remove(index)
        let affectedSections = Array(sections[index..<sectionsCount])
        setupForSections(affectedSections, fromIndex: index)
        
        bumpTracker.didRemove([index])
        
        return self
    }
}

// Layout
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

// Registering
public extension Sapporo {
    func registerNibForClass<T: SACell>(cellType: T.Type) -> Self {
        collectionView.registerNibForClass(cellType)
        return self
    }
    
    func registerClass<T: SACell>(cellType: T.Type) -> Self {
        collectionView.registerClass(cellType)
        return self
    }
    
    func registerNibForSupplementaryClass<T: UICollectionReusableView>(type: T.Type, kind: String) -> Self {
        collectionView.registerNibForSupplementaryClass(type, kind: kind)
        return self
    }
    
    func registerSupplementaryClass<T: UICollectionReusableView>(type: T.Type, kind: String) -> Self {
        collectionView.registerSupplementaryClass(type, kind: kind)
        return self
    }
}

// Utilities
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
    
    public func getSection(index: Int) -> SASection? {
        return sections.get(index)
    }
    
    func cellAtIndexPath(indexPath: NSIndexPath) -> SACell? {
        return collectionView.cellForItemAtIndexPath(indexPath) as? SACell
    }
}

// UIScrollViewDelegate
extension Sapporo {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
		delegate?.scrollViewDidScroll?(scrollView)
		
		if !loadmoreEnabled {
			return
		}
		
		let offset = scrollView.contentOffset
		let y = offset.y + scrollView.bounds.height - scrollView.contentInset.bottom
		let h = scrollView.contentSize.height
		if y > h - loadmoreThreshold {
			loadmoreEnabled = false
			loadmoreHandler?()
		}
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    public func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
}

// Private methods
private extension Sapporo {
    func setupForSections(sections: [SASection], fromIndex start: Int) {
        var start = start
        for section in sections {
            section.setup(start++, delegate: self)
        }
    }
}