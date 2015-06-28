//
//  SAFlowLayoutSupplementaryViewModel.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SAFlowLayoutSupplementaryViewModel {
    public let reuseIdentifier      : String
    internal(set) var indexPath     = NSIndexPath(forRow: 0, inSection: 0)
    
    public var size                 = CGSize.zeroSize
    
    public init<T: SAFlowLayoutSupplementaryView>(viewType: T.Type, size: CGSize) {
        self.reuseIdentifier = viewType.reuseIdentifier
        self.size = size
    }
    
    public init<T: SAFlowLayoutSupplementaryView>(viewType: T.Type) {
        self.reuseIdentifier = viewType.reuseIdentifier
        self.size = CGSize.zeroSize
    }
    
    func setup(indexPath: NSIndexPath) {
        self.indexPath = indexPath
    }
}