//
//  UITableViewCell+.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/02.
//

import UIKit.UITableViewCell

protocol Configurable {
    func configure<T>(model: T)
}

extension Configurable {
    func configure<T>(model: T) {}
}

protocol Accessariable {
    func setAccessary(isHidden: Bool)
}

extension Accessariable {
    func setAccessary(isHidden: Bool) {}
}

extension UITableViewCell: Configurable, Accessariable {}
