//
//  UICollectionViewExt.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension UICollectionView {
	func registerCellByNib<T: UICollectionViewCell>(_ t: T.Type) {
		let nib = UINib(nibName: t.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: t.reuseIdentifier)
	}
    
	func registerCell<T: UICollectionViewCell>(_ t: T.Type) {
		register(t, forCellWithReuseIdentifier: t.reuseIdentifier)
	}
	
	func registerSupplementaryViewByNib<T: UICollectionReusableView>(_ type: T.Type, kind: String) {
		let nib = UINib(nibName: type.nibName, bundle: nil)
		register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
	}
	
	func registerSupplementaryView<T: UICollectionReusableView>(_ type: T.Type, kind: String) {
		register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
	}
	
	func dequeueCell<T: UICollectionViewCell>(_ t: T.Type, forIndexPath indexPath: IndexPath) -> T {
		return dequeueReusableCell(withReuseIdentifier: t.reuseIdentifier, for: indexPath) as! T
	}
}
