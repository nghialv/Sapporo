//
//  SAFlowLayoutSupplementaryView.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

public class SAFlowLayoutSupplementaryView: UICollectionReusableView {
	weak var viewmodel: SAFlowLayoutSupplementaryViewModel?
	
	public func configure(viewmodel: SAFlowLayoutSupplementaryViewModel) {
		self.viewmodel = viewmodel
	}
}