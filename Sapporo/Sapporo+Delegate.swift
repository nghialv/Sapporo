//
//  Sapporo+Delegate.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo: UICollectionViewDelegate {
	
	// Selection
	public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		return cellAtIndexPath(indexPath)?.shouldSelect ?? true
	}
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cellmodel = self[indexPath], let cell = cellAtIndexPath(indexPath) {
			cellmodel.didSelect(cell)
		}
	}
	
	public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
		return cellAtIndexPath(indexPath)?.shouldDeselect ?? true
	}
	
	public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		if let cellmodel = self[indexPath], let cell = collectionView.cellForItem(at: indexPath) as? SACell {
			cellmodel.didDeselect(cell)
		}
	}
	
	// Highlight
	public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
		return cellAtIndexPath(indexPath)?.shouldHighlight ?? true
	}
	
	public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		cellAtIndexPath(indexPath)?.didHighlight(collectionView)
	}
	
	public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		cellAtIndexPath(indexPath)?.didUnhighlight(collectionView)
	}
	
	
	// Displaying
	public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		(cell as? SACell)?.willDisplay(collectionView)
	}
	
	public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
		delegate?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, atIndexPath: indexPath)
	}
	
	public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		(cell as? SACell)?.didEndDisplaying(collectionView)
	}
	
	public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
		delegate?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, atIndexPath: indexPath)
	}
	
	
	// Action
	public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
		// TODO: implement
		return false
	}
	
	public func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
		// TODO: implement
	}
	
	public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
		// TODO: implement
		return false
	}
	
	// Transition layout
	
	public func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
		return delegate?.collectionView?(collectionView, transitionLayoutForOldLayout: fromLayout, newLayout: toLayout) ?? UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
	}
}
