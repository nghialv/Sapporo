//
//  SimpleCell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

class SimpleCellModel: SACellModel {
    let title   : String
    var des     : String
    
    init(title: String, des: String, selectionHandler: SASelectionHandler?) {
        self.title = title
        self.des = des
        let size = CGSize(width: 110, height: 110)
        super.init(cellType: SimpleCell.self, size: size, selectionHandler: selectionHandler)
    }
}

class SimpleCell: SACell {
    @IBOutlet weak var titleLabel   : UILabel!
    @IBOutlet weak var desLabel     : UILabel!
    
    override func configure(cellmodel: SACellModel) {
        super.configure(cellmodel)
        
        if let cellmodel = cellmodel as? SimpleCellModel {
            titleLabel.text = cellmodel.title
            desLabel.text   = cellmodel.des
        }
    }
	
	override func willDisplay(collectionView: UICollectionView) {
		super.willDisplay(collectionView)
	}
}