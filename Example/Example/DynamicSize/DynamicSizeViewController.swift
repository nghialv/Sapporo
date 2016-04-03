//
//  DynamicSizeViewController.swift
//  Example
//
//  Created by Le VanNghia on 7/9/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

var longDes = "Swift is a new programming language for iOS and OS X apps that builds on the best of C and Objective-C, without the constraints of C compatibility. Swift adopts safe programming patterns and adds modern features to make programming easier, more flexible, and more fun. Swift’s clean slate, backed by the mature and much-loved Cocoa and Cocoa Touch frameworks, is an opportunity to reimagine how software development works."

class DynamicSizeViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	lazy var sapporo: Sapporo = { [unowned self] in
		return Sapporo(collectionView: self.collectionView)
		}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sapporo
            .registerCellByNib(DynamicSizeCell)
            .registerCellByNib(DynamicImageSizeCell)
		
		let layout = SAFlowLayout()
		sapporo.setLayout(layout)
		
		let section = SASection()
		
		let title = " title "
		let des = " description "
		let cellmodel = DynamicSizeCellModel(title: title, des: longDes)
		
		section.append(cellmodel)
        
		sapporo
            .reset(section)
            .bump()
		
		delay(3) {
			cellmodel.des = des
			cellmodel.bump()
		}
	}
	
	deinit {
		collectionView.delegate = nil
	}
}