//
//  SASectionIndexType.swift
//  Example
//
//  Created by 川上 健太郎 on 2018/08/13.
//  Copyright © 2018年 Le Van Nghia. All rights reserved.
//

import Foundation

public protocol SASectionIndexType {
    var intValue: Int { get }
    static var count: Int { get }
}

public extension SASectionIndexType where Self: RawRepresentable, Self.RawValue == Int {
    var intValue: Int {
        return rawValue
    }
}
