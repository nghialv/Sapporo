//
//  UICollectionReusableViewExt.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    public static var nibName: String {
        return classNameOf(self)
    }
    
    public static var reuseIdentifier: String {
        return classNameOf(self)
    }
}