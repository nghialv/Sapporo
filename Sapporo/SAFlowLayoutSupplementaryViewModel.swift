//
//  SAFlowLayoutSupplementaryViewModel.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

open class SAFlowLayoutSupplementaryViewModel {
	open let reuseIdentifier      : String
	internal(set) var indexPath     = IndexPath(row: 0, section: 0)
	
	open var size                 = CGSize.zero
	
	public init<T: SAFlowLayoutSupplementaryView>(viewType: T.Type, size: CGSize) {
		self.reuseIdentifier = viewType.reuseIdentifier
		self.size = size
	}
	
	public init<T: SAFlowLayoutSupplementaryView>(viewType: T.Type) {
		self.reuseIdentifier = viewType.reuseIdentifier
		self.size = CGSize.zero
	}
	
	func setup(_ indexPath: IndexPath) {
		self.indexPath = indexPath
	}
}
