//
//  DynamicImageSizeCell.swift
//  Example
//
//  Created by Le VanNghia on 7/10/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation
import Sapporo

class DynamicImageSizeCellModel: SACellModel {
	let title: String
	
	init(title: String) {
		self.title = title
		//let size = CGSize(width: 320, height: 320)
		super.init(cellType: DynamicImageSizeCell.self, selectionHandler: nil)
		enableDynamicHeight(320)
	}
}

class DynamicImageSizeCell: SACell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dynamicImageView: UIImageView!
	
	override func configure(cellmodel: SACellModel) {
		super.configure(cellmodel)
		contentView.backgroundColor = UIColor.lightGrayColor()
		
		if let cellmodel = cellmodel as? DynamicImageSizeCellModel {
			titleLabel.text = cellmodel.title
			dynamicImageView.image = UIImage(named: "image")
		}
	}
}