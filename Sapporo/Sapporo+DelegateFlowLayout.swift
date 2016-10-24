//
//  Sapporo+DelegateFlowLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension Sapporo: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if let cellmodel = self[indexPath], let flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, sizeForCellModel: cellmodel)
		}
		return CGSize.zero
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		if let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, insetForSection: sec)
		}
		return UIEdgeInsets()
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		if let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, minimumInteritemSpacingForSection: sec)
		}
		return 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		if let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, minimumLineSpacingForSection: sec)
		}
		return 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		if let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, referenceSizeForFooterInSection: sec)
		}
		return CGSize.zero
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		if let sec = getSection(section), let flowLayout = collectionViewLayout as? SAFlowLayout {
			return flowLayout.collectionView(collectionView, referenceSizeForHeaderInSection: sec)
		}
		return CGSize.zero
	}
}
