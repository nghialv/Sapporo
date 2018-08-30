//
//  SimpleViewController.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

final class SimpleViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var sapporo: Sapporo = .init(collectionView: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sapporo
            .registerCellByNib(SimpleCell.self)
            .registerSupplementaryViewByNib(SimpleHeaderView.self, kind: UICollectionElementKindSectionHeader)
        
        sapporo.setLayout(SAFlowLayout())
        sapporo.loadmoreEnabled = true
        sapporo.loadmoreHandler = {
            print("Loadmore")
        }
        
        let section = SASection()
        section.inset = .init(top: 10, left: 10, bottom: 10, right: 10)
        section.minimumLineSpacing = 10
        section.headerViewModel = SimpleHeaderViewModel(title: "Section 0 header", height: 25)
        
        sapporo
            .reset(section)
            .bump()
        
        let cellmodels = (0...4).map { index -> SimpleCellModel in
            return SimpleCellModel(title: "cell \(index)", des: "section 0") { cell in
                let indexPath = cell._cellmodel?.indexPath
                print("Selected: indexPath: \(indexPath?.section ?? 0), \(indexPath?.row ?? 0)")
            }
        }
        
        section
            .reset(cellmodels[0])
            .bump()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            section
                .append([cellmodels[1], cellmodels[3], cellmodels[4]])
                .bump()
            
            print("bump 1")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            section
                .insert(cellmodels[2], atIndex: 2)
                .bump()
            
            print("bump 2")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            cellmodels[0].des = "changed"
            cellmodels[0].bump()
            
            print("bump 3")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            section
                .remove(1)
                .bump()
            
            print("bump 4")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            section
                .move(fromIndex: 2, toIndex: 0)
                .bump()
            
            print("bump 5")
        }
        
        let newSection = SASection()
        newSection.inset = .init(top: 10, left: 10, bottom: 10, right: 10)
        newSection.minimumLineSpacing = 10
        newSection.headerViewModel = SimpleHeaderViewModel(title: "Section 1 header", height: 45)
        
        let newCellmodels = (0...16).map { index -> SimpleCellModel in
            let cm = SimpleCellModel(title: "cell \(index)", des: "section 1") { cell in
                let indexPath = cell._cellmodel?.indexPath
                print("Selected: indexPath: \(indexPath?.section ?? 0), \(indexPath?.row ?? 0)")
            }
            cm.size = .init(width: 170, height: 150)
            return cm
        }
        newSection.append(newCellmodels)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            self.sapporo
                .insert(newSection, atIndex: 1)
                .bump()
            print("bump 6")
        }
    }
}
