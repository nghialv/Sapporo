//
//  BumpType.swift
//  Example
//
//  Created by 川上 健太郎 on 2018/08/13.
//  Copyright © 2018年 Le Van Nghia. All rights reserved.
//

import Foundation

public enum SapporoBumpType {
    case reload
    case insert(IndexSet)
    case move(Int, Int)
    case delete(IndexSet)
}

public enum SectionBumpType {
    case reload(IndexSet)
    case insert([IndexPath])
    case move(IndexPath, IndexPath)
    case delete([IndexPath])
}

public enum ItemBumpType {
    case reload(IndexPath)
}
