//
//  DynamicImageSizeCell.swift
//  Example
//
//  Created by Le VanNghia on 7/10/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation
import Sapporo

final class DynamicImageSizeCellModel: SACellModel {
    let title: String
    
    init(title: String) {
        self.title = title
        //let size = CGSize(width: 320, height: 320)
        super.init(cellType: DynamicImageSizeCell.self, selectionHandler: nil)
        enableDynamicHeight(320)
    }
}

final class DynamicImageSizeCell: SACell, SACellType {
    typealias CellModel = DynamicImageSizeCellModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dynamicImageView: UIImageView!
    
    override func configure() {
        super.configure()
        
        guard let cellmodel = cellmodel else {
            return
        }
        
        contentView.backgroundColor = .lightGray
        
        titleLabel.text = cellmodel.title
        dynamicImageView.image = UIImage(named: "image")
    }
}
