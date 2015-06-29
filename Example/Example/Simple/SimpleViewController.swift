//
//  SimpleViewController.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

class SimpleViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var sapporo: Sapporo = { [unowned self] in
        return Sapporo(collectionView: self.collectionView)
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sapporo.registerNibForClass(SimpleCell)
        sapporo.registerNibForSupplementaryClass(SimpleHeaderView.self, kind: UICollectionElementKindSectionHeader)
        
        let layout = SAFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        sapporo.setLayout(layout)
        
        let section = sapporo[0]
        section.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        section.minimumLineSpacing = 10
        section.headerViewModel = SimpleHeaderViewModel(title: "Section 0 header", height: 25)
        
        let cellmodels = (0...4).map { index -> SimpleCellModel in
            return SimpleCellModel(title: "cell \(index)", des: "section 0") { cell in
                let indexPath = cell.cellmodel?.indexPath
                println("Selected: indexPath: \(indexPath?.section), \(indexPath?.row)")
            }
        }
        
        section.reset(cellmodels[0])
        section.bump()
        
        delay(2) {
            section.append([cellmodels[1], cellmodels[3], cellmodels[4]])
            section.bump()
            println("bump")
        }
        
        delay(4) {
            section.insert(cellmodels[2], atIndex: 2)
                .bump()
            println("bump")
        }
        
        delay(6) {
            cellmodels[0].des = "changed"
            cellmodels[0].bump()
            println("bump")
        }
        
        delay(8) {
            section.remove(1)
            section.bump()
            println("bump")
        }
        
        delay(10) {
            section.move(fromIndex: 2, toIndex: 0)
            section.bump()
            println("bump")
        }
        
        let newSection = SASection()
        newSection.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        newSection.minimumLineSpacing = 10
        newSection.headerViewModel = SimpleHeaderViewModel(title: "Section 1 header", height: 45)
        
        let newCellmodels = (0...6).map { index -> SimpleCellModel in
            let cm = SimpleCellModel(title: "cell \(index)", des: "section 1") { cell in
                let indexPath = cell.cellmodel?.indexPath
                println("Selected: indexPath: \(indexPath?.section), \(indexPath?.row)")
            }
            cm.size = CGSize(width: 170, height: 150)
            return cm
        }
        newSection.append(newCellmodels)
        
        delay(12) {
            sapporo.insert(newSection, atIndex: 1)
                .bump()
        }
    }
}