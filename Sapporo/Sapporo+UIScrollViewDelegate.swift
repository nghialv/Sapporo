//
//  Sapporo+UIScrollViewDelegate.swift
//  Example
//
//  Created by Le VanNghia on 4/3/16.
//  Copyright © 2016 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
        
        if !loadmoreEnabled {
            return
        }
        
        let offset = scrollView.contentOffset
        let y = direction == .vertical ? offset.y + scrollView.bounds.height - scrollView.contentInset.bottom : offset.x + scrollView.bounds.width - scrollView.contentInset.right
        let h = direction == .vertical ? scrollView.contentSize.height : scrollView.contentSize.width
        if y > h - loadmoreDistanceThreshold {
            loadmoreEnabled = false
            loadmoreHandler?()
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScrollToTop?(scrollView)
    }
}
