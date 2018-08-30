//
//  SALayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

open class SALayout: UICollectionViewLayout {
    open func getCellModel(_ indexPath: IndexPath) -> SACellModel? {
        guard let sapporo = collectionView?.dataSource as? Sapporo else { return nil }
        
        return sapporo[indexPath]
    }
    
    open func getCellModels(_ section: Int) -> [SACellModel] {
        let sapporo = collectionView?.dataSource as? Sapporo
        
        return sapporo?.getSection(section)?.cellmodels ?? []
    }
}
