//
//  CalendarEventCell.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

class CalendarEventCellModel: SACellModel {
    let event: CalendarEvent
    
    init(event: CalendarEvent, selectionHandler: @escaping SASelectionHandler) {
        self.event = event
        super.init(cellType: CalendarEventCell.self, selectionHandler: selectionHandler)
    }
}

class CalendarEventCell: SACell, SACellType {
    typealias CellModel = CalendarEventCellModel
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0.7, alpha: 1).cgColor
    }
    
    override func configure() {
        super.configure()
        
        guard let cellmodel = cellmodel else {
            return
        }
        
        titleLabel.text = cellmodel.event.title
    }
}
