//
//  SAFlowLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SAFlowLayout: UICollectionViewFlowLayout {
    public func collectionView(collectionView: UICollectionView, sizeForCellModel cellmodel: SACellModel) -> CGSize {
		let size = cellmodel.size
		println("final size: \(size)")
        return size
    }
    
    public func collectionView(collectionView: UICollectionView, insetForSection section: SASection) -> UIEdgeInsets {
        return section.inset
    }
    
    public func collectionView(collectionView: UICollectionView, minimumInteritemSpacingForSection section: SASection) -> CGFloat {
        return section.minimumInteritemSpacing
    }
    
    public func collectionView(collectionView: UICollectionView, minimumLineSpacingForSection section: SASection) -> CGFloat {
        return section.minimumLineSpacing
    }
    
    public func collectionView(collectionView: UICollectionView, referenceSizeForHeaderInSection section: SASection) -> CGSize {
        return section.headerViewModel?.size ?? section.headerReferenceSize
    }
    
    public func collectionView(collectionView: UICollectionView, referenceSizeForFooterInSection section: SASection) -> CGSize {
        return section.footerViewModel?.size ?? section.footerReferenceSize
    }
}