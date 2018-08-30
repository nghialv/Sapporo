//
//  Sapporo+DelegateFlowLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellmodel = self[indexPath], let flowLayout = collectionViewLayout as? SAFlowLayout else { return .zero }
        
        return flowLayout.collectionView(collectionView, sizeForCellModel: cellmodel)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout else { return .init() }
        
        return flowLayout.collectionView(collectionView, insetForSection: sec)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout else { return 0 }
        
        return flowLayout.collectionView(collectionView, minimumInteritemSpacingForSection: sec)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout else { return 0 }
        
        return flowLayout.collectionView(collectionView, minimumLineSpacingForSection: sec)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout else { return .zero }
        
        return flowLayout.collectionView(collectionView, referenceSizeForFooterInSection: sec)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout else { return .zero }
        
        return flowLayout.collectionView(collectionView, referenceSizeForHeaderInSection: sec)
    }
}
