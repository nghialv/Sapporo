//
//  SAFlowLayoutSupplementaryView.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SAFlowLayoutSupplementaryView: UICollectionReusableView {
	public internal(set) weak var _viewmodel: SAFlowLayoutSupplementaryViewModel?
	
	func configure(viewmodel: SAFlowLayoutSupplementaryViewModel) {
		_viewmodel = viewmodel
        configure()
	}
    
    public func configure() {
    }
}