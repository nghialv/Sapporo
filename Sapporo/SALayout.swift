//
//  SALayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SALayout: UICollectionViewLayout {
    public func getCellModel(indexPath: NSIndexPath) -> SACellModel? {
        if let sapporo = collectionView?.dataSource as? Sapporo {
            return sapporo[indexPath]
        }
        return nil
    }
    
    public func getCellModels(section: Int) -> [SACellModel] {
        if let sapporo = collectionView?.dataSource as? Sapporo {
            return sapporo.getSection(section)?.cellmodels ?? []
        }
        return []
    }
}