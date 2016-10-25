//
//  Sapporo+Registration.swift
//  Example
//
//  Created by Le VanNghia on 4/3/16.
//  Copyright © 2016 Le Van Nghia. All rights reserved.
//

import UIKit

public extension Sapporo {
    @discardableResult
    func registerCellByNib<T>(_ cellType: T.Type) -> Self where T: SACell, T: SACellType {
        collectionView.registerCellByNib(cellType)
        return self
    }
    
    @discardableResult
    func registerCell<T>(_ cellType: T.Type) -> Self where T: SACell, T: SACellType {
        collectionView.registerCell(cellType)
        return self
    }
    
    @discardableResult
    func registerSupplementaryViewByNib<T: UICollectionReusableView>(_ type: T.Type, kind: String) -> Self {
        collectionView.registerSupplementaryViewByNib(type, kind: kind)
        return self
    }
    
    @discardableResult
    func registerSupplementaryView<T: UICollectionReusableView>(_ type: T.Type, kind: String) -> Self {
        collectionView.registerSupplementaryView(type, kind: kind)
        return self
    }
}
