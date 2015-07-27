//
//  Sapporo+DelegateFlowLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo: UICollectionViewDelegateFlowLayout {
	public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		if let cellmodel = self[indexPath], flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, sizeForCellModel: cellmodel)
		}
		return CGSize.zeroSize
	}
	
	public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		if let sec = getSection(section), flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, insetForSection: sec)
		}
		return UIEdgeInsets()
	}
	
	public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		if let sec = getSection(section), flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, minimumInteritemSpacingForSection: sec)
		}
		return 0
	}
	
	public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		if let sec = getSection(section), flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, minimumLineSpacingForSection: sec)
		}
		return 0
	}
	
	public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		if let sec = getSection(section), flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, referenceSizeForFooterInSection: sec)
		}
		return CGSize.zeroSize
	}
	
	public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		if let sec = getSection(section), flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, referenceSizeForHeaderInSection: sec)
		}
		return CGSize.zeroSize
	}
}