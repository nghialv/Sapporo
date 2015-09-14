//
//  Sapporo+DataSource.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo: UICollectionViewDataSource {
	public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return sectionsCount
	}
	
	public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self[section].itemsCount
	}
	
	public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		if let cellmodel = self[indexPath]
			, cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellmodel.reuseIdentifier, forIndexPath: indexPath) as? SACell {
				cell.configure(cellmodel)
				return cell
		}
		
		return UICollectionViewCell()
	}
	
	public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		if isFlowLayout, let section = getSection(indexPath.section) {
			if kind == UICollectionElementKindSectionHeader, let viewmodel = section.headerViewModel {
				if let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: viewmodel.reuseIdentifier, forIndexPath: indexPath) as? SAFlowLayoutSupplementaryView {
					viewmodel.setup(indexPath)
					view.configure(viewmodel)
					return view
				}
			}
			if kind == UICollectionElementKindSectionFooter, let viewmodel = section.footerViewModel {
				if let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: viewmodel.reuseIdentifier, forIndexPath: indexPath) as? SAFlowLayoutSupplementaryView {
					viewmodel.setup(indexPath)
					view.configure(viewmodel)
					return view
				}
			}
		}
		
		return delegate?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath) ?? UICollectionReusableView()
	}
}