//
//  SapporoDelegate.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

@objc public protocol SapporoDelegate: class {
	optional func scrollViewDidScroll(scrollView: UIScrollView)
	
	// Decelerating
	optional func scrollViewWillBeginDecelerating(scrollView: UIScrollView)
	optional func scrollViewDidEndDecelerating(scrollView: UIScrollView)
	
	optional func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
	optional func scrollViewDidScrollToTop(scrollView: UIScrollView)
	
	// Draging
	optional func scrollViewWillBeginDragging(scrollView: UIScrollView)
	optional func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	optional func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
	
	optional func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout
	
	optional func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath)
	
	optional func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath)
	
	optional func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
}