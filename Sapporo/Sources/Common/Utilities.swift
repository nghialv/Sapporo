//
//  Utilities.swift
//  Example
//
//  Created by 川上 健太郎 on 2018/08/13.
//  Copyright © 2018年 Le Van Nghia. All rights reserved.
//

import Foundation

func classNameOf(_ aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
