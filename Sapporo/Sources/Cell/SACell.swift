//
//  SACell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

open class SACell: UICollectionViewCell {
    open internal(set) weak var _cellmodel: SACellModel?
    
    open var shouldSelect = true
    open var shouldDeselect = true
    open var shouldHighlight = true
    
    func configure(_ cellmodel: SACellModel) {
        _cellmodel = cellmodel
        configure()
    }
    
    open func configure() {}
    
    open func configureForSizeCalculating(_ cellmodel: SACellModel) {
        _cellmodel = cellmodel
    }
    
    open func willDisplay(_ collectionView: UICollectionView) {}
    open func didEndDisplaying(_ collectionView: UICollectionView) {}
    open func didHighlight(_ collectionView: UICollectionView) {}
    open func didUnhighlight(_ collectionView: UICollectionView) {}
}
