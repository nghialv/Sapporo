//
//  SimpleCell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

final class SimpleCellModel: SACellModel {
    let title: String
    var des: String
    
    init(title: String, des: String, selectionHandler: SASelectionHandler?) {
        self.title = title
        self.des = des
        
        super.init(cellType: SimpleCell.self, size: .init(width: 110, height: 110), selectionHandler: selectionHandler)
    }
}

final class SimpleCell: SACell, SACellType {
    typealias CellModel = SimpleCellModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    override func configure() {
        super.configure()
        
        guard let cellmodel = cellmodel else {
            return
        }
        
        titleLabel.text = cellmodel.title
        desLabel.text   = cellmodel.des
    }
}
