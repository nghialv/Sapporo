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
		if let cellmodel = self[indexPath],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellmodel.reuseIdentifier, for: indexPath) as? SACell {
				cell.configure(cellmodel)
				return cell
		}
		
		return UICollectionViewCell()
	}
	
	public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if isFlowLayout, let section = getSection(indexPath.section) {
			if kind == UICollectionElementKindSectionHeader, let viewmodel = section.headerViewModel {
				if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewmodel.reuseIdentifier, for: indexPath) as? SAFlowLayoutSupplementaryView {
					viewmodel.setup(indexPath)
					view.configure(viewmodel)
					return view
				}
			}
			if kind == UICollectionElementKindSectionFooter, let viewmodel = section.footerViewModel {
				if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewmodel.reuseIdentifier, for: indexPath) as? SAFlowLayoutSupplementaryView {
					viewmodel.setup(indexPath)
					view.configure(viewmodel)
					return view
				}
			}
		}
		
		return delegate?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath) ?? UICollectionReusableView()
	}
}
