//
//  NSObject+.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/02.
//

import Foundation.NSObject

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    var className: String {
        return type(of: self).className
    }
}

