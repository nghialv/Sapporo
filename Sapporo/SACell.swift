//
//  SACell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SACell: UICollectionViewCell {
    public internal(set) weak var _cellmodel: SACellModel?
	
	public var shouldSelect         = true
	public var shouldDeselect       = true
	public var shouldHighlight      = true
	
    func configure(cellmodel: SACellModel) {
		_cellmodel = cellmodel
        configure()
	}
    
    public func configure() {
    }

	public func configureForSizeCalculating(cellmodel: SACellModel) {
		self._cellmodel = cellmodel
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