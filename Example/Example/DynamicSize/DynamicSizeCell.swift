//
//  DynamicSizeCell.swift
//  Example
//
//  Created by Le VanNghia on 7/9/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation
import Sapporo

class DynamicSizeCellModel: SACellModel {
	let title   : String
	var des     : String
	
	init(title: String, des: String) {
		self.title = title
		self.des = des
		super.init(cellType: DynamicSizeCell.self, selectionHandler: nil)
		enableDynamicHeight(320)
	}
}

class DynamicSizeCell: SACell, SACellType {
    typealias CellModel = DynamicSizeCellModel
    
	@IBOutlet weak var titleLabel   : UILabel!
	@IBOutlet weak var desLabel     : UILabel!
	
	override func configure() {
		super.configure()
        guard let cellmodel = cellmodel else {
            return
        }
        
		contentView.backgroundColor = UIColor.lightGray
		
        titleLabel.text = cellmodel.title
        desLabel.text   = cellmodel.des
	}
	
	override func configureForSizeCalculating(_ cellmodel: SACellModel) {
		super.configureForSizeCalculating(cellmodel)
		if let cellmodel = cellmodel as? DynamicSizeCellModel {
			desLabel.text   = cellmodel.des
		}
	}
	
	override func willDisplay(_ collectionView: UICollectionView) {
		super.willDisplay(collectionView)
	}
}
