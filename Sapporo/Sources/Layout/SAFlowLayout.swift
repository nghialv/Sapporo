//
//  SAFlowLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

open class SAFlowLayout: UICollectionViewFlowLayout {
    open func collectionView(_ collectionView: UICollectionView, sizeForCellModel cellmodel: SACellModel) -> CGSize {
        return cellmodel.size
    }
    
    open func collectionView(_ collectionView: UICollectionView, insetForSection section: SASection) -> UIEdgeInsets {
        return section.inset
    }
    
    open func collectionView(_ collectionView: UICollectionView, minimumInteritemSpacingForSection section: SASection) -> CGFloat {
        return section.minimumInteritemSpacing
    }
    
    open func collectionView(_ collectionView: UICollectionView, minimumLineSpacingForSection section: SASection) -> CGFloat {
        return section.minimumLineSpacing
    }
    
    open func collectionView(_ collectionView: UICollectionView, referenceSizeForHeaderInSection section: SASection) -> CGSize {
        return section.headerViewModel?.size ?? section.headerReferenceSize
    }
    
    open func collectionView(_ collectionView: UICollectionView, referenceSizeForFooterInSection section: SASection) -> CGSize {
        return section.footerViewModel?.size ?? section.footerReferenceSize
    }
}
