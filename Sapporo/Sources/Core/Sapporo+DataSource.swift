//
//  Sapporo+DataSource.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self[section].itemsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellmodel = self[indexPath], let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellmodel.reuseIdentifier, for: indexPath) as? SACell else {
            assertionFailure("Could not dequeue cell with identifier: \(self[indexPath]?.reuseIdentifier ?? "cellmodel is nil")")
            return .init()
        }
        
        cell.configure(cellmodel)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if isFlowLayout, let section = getSection(indexPath.section) {
            if kind == UICollectionView.elementKindSectionHeader,
                let viewmodel = section.headerViewModel,
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewmodel.reuseIdentifier, for: indexPath) as? SAFlowLayoutSupplementaryView {
                
                viewmodel.setup(indexPath)
                view.configure(viewmodel)
                return view
            }
            if kind == UICollectionView.elementKindSectionFooter,
                let viewmodel = section.footerViewModel,
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewmodel.reuseIdentifier, for: indexPath) as? SAFlowLayoutSupplementaryView  {
                
                viewmodel.setup(indexPath)
                view.configure(viewmodel)
                return view
            }
        }
        
        return delegate?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath) ?? UICollectionReusableView()
    }
}
