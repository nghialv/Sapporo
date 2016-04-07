//
//  SAFlowLayoutSupplementaryViewType.swift
//  Example
//
//  Created by Le VanNghia on 4/3/16.
//  Copyright © 2016 Le Van Nghia. All rights reserved.
//

import Foundation

public protocol SAFlowLayoutSupplementaryViewType {
    associatedtype ViewModel
    
    var viewmodel: ViewModel? { get }
}

public extension SAFlowLayoutSupplementaryViewType where Self: SAFlowLayoutSupplementaryView {
    var viewmodel: ViewModel? {
        return _viewmodel as? ViewModel
    }
}