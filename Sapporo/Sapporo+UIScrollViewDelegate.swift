//
//  Sapporo+UIScrollViewDelegate.swift
//  Example
//
//  Created by Le VanNghia on 4/3/16.
//  Copyright © 2016 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
        
        if !loadmoreEnabled {
            return
        }
        
        let offset = scrollView.contentOffset
        let y = direction == .Vertical ? offset.y + scrollView.bounds.height - scrollView.contentInset.bottom : offset.x + scrollView.bounds.width - scrollView.contentInset.right
        let h = direction == .Vertical ? scrollView.contentSize.height : scrollView.contentSize.width
        if y > h - loadmoreDistanceThreshold {
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
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        delegate?.scrollViewDidScrollToTop?(scrollView)
    }
}