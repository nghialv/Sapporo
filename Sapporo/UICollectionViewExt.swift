//
//  UICollectionViewExt.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension UICollectionView {
	func registerCellByNib<T: UICollectionViewCell>(t: T.Type) {
		let nib = UINib(nibName: t.nibName, bundle: nil)
		registerNib(nib, forCellWithReuseIdentifier: t.reuseIdentifier)
	}
	
	func registerCell<T: UICollectionViewCell>(t: T.Type) {
		registerClass(t, forCellWithReuseIdentifier: t.reuseIdentifier)
	}
	
	func registerSupplementaryViewByNib<T: UICollectionReusableView>(type: T.Type, kind: String) {
		let nib = UINib(nibName: type.nibName, bundle: nil)
		registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
	}
	
	func registerSupplementaryView<T: UICollectionReusableView>(type: T.Type, kind: String) {
		registerClass(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
	}
	
	func dequeueCell<T: UICollectionViewCell>(t: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
		return dequeueReusableCellWithReuseIdentifier(t.reuseIdentifier, forIndexPath: indexPath) as! T
	}
}