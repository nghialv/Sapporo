//
//  SAFlowLayoutSupplementaryView.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

open class SAFlowLayoutSupplementaryView: UICollectionReusableView {
	open internal(set) weak var _viewmodel: SAFlowLayoutSupplementaryViewModel?
	
	func configure(_ viewmodel: SAFlowLayoutSupplementaryViewModel) {
		_viewmodel = viewmodel
        configure()
	}
    
    open func configure() {
    }
}
