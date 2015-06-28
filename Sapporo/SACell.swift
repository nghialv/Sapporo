//
//  SACell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SACell: UICollectionViewCell {
    weak var cellmodel: SACellModel?
    
    public var shouldSelect         = true
    public var shouldDeselect       = true
    public var shouldHighlight      = true
    public var shouldUnhighlight    = true
    
    func configure(cellmodel: SACellModel) {
        self.cellmodel = cellmodel
    }
    
    func willDisplay() {
    }
    
    func didEndDisplaying() {
    }
    
    func didHighlight() {
    }
    
    func didUnhighlight() {
    }
}