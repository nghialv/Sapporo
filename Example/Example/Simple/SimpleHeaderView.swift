//
//  SimpleHeaderView.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

class SimpleHeaderViewModel: SAFlowLayoutSupplementaryViewModel {
    let title: String
    
    init(title: String, height: CGFloat) {
        self.title = title
        let size = CGSize(width: 320, height: height)
        super.init(viewType: SimpleHeaderView.self, size: size)
    }
}

class SimpleHeaderView: SAFlowLayoutSupplementaryView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func configure(viewmodel: SAFlowLayoutSupplementaryViewModel) {
        super.configure(viewmodel)
        
        if let viewmodel = viewmodel as? SimpleHeaderViewModel {
            titleLabel.text = viewmodel.title
        }
    }
}