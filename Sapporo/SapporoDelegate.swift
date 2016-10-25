//
//  SapporoDelegate.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

@objc public protocol SapporoDelegate: class {
	@objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
	
	// Decelerating
	@objc optional func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
	@objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
	
	@objc optional func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
	@objc optional func scrollViewDidScrollToTop(_ scrollView: UIScrollView)
	
	// Draging
	@objc optional func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
	@objc optional func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	@objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
	
	@objc optional func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout
	
	@objc optional func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: IndexPath)
	
	@objc optional func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: IndexPath)
	
	@objc optional func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> UICollectionReusableView
}
