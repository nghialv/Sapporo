//
//  Sapporo+Registration.swift
//  Example
//
//  Created by Le VanNghia on 4/3/16.
//  Copyright © 2016 Le Van Nghia. All rights reserved.
//

import UIKit

public extension Sapporo {
    func registerCellByNib<T where T: SACell, T: SACellType>(cellType: T.Type) -> Self {
        collectionView.registerCellByNib(cellType)
        return self
    }
    
    func registerCell<T where T: SACell, T: SACellType>(cellType: T.Type) -> Self {
        collectionView.registerCell(cellType)
        return self
    }
    
    func registerSupplementaryViewByNib<T: UICollectionReusableView>(type: T.Type, kind: String) -> Self {
        collectionView.registerSupplementaryViewByNib(type, kind: kind)
        return self
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(type: T.Type, kind: String) -> Self {
        collectionView.registerSupplementaryView(type, kind: kind)
        return self
    }
}