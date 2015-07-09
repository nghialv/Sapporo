//
//  SACell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SACell: UICollectionViewCell {
    public internal(set) weak var cellmodel: SACellModel?
    
    public var shouldSelect         = true
    public var shouldDeselect       = true
    public var shouldHighlight      = true
    public var shouldUnhighlight    = true
    
    public func configure(cellmodel: SACellModel) {
        self.cellmodel = cellmodel
    }
    
	public func willDisplay(collectionView: UICollectionView) {
    }
    
	public func didEndDisplaying(collectionView: UICollectionView) {
    }
    
	public func didHighlight(collectionView: UICollectionView) {
    }
    
	public func didUnhighlight(collectionView: UICollectionView) {
    }
}