//
//  UIColor+.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/23.
//

import UIKit.UIColor

extension UIColor {
    
    public convenience init?(hex: String) {
        var hex = hex
        var hexInt: UInt64 = 0
        
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }
        
        guard hex.count == 6 else { return nil }
        guard Scanner(string: hex).scanHexInt64(&hexInt) else { return nil }
        
        let r = CGFloat((hexInt & 0x00ff0000) >> 16) / 255
        let g = CGFloat((hexInt & 0x0000ff00) >> 8) / 255
        let b = CGFloat(hexInt & 0x000000ff) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
}

// MARK: - Color System

extension UIColor {
    
    // MARK: - Gray Scale
    
//    static let black = UIColor(hex: "#171717")
    static let gray06 = UIColor(hex: "#222222")
    static let gray05 = UIColor(hex: "#2E2E2E")
    static let gray04 = UIColor(hex: "#555555")
    static let gray03 = UIColor(hex: "#9E9E9E")
    static let gray02 = UIColor(hex: "#C1C1C1")
    static let gray01 = UIColor(hex: "#ECECEC")
//    static let whtie = UIColor(hex: "#FBFBFB")
    
    //MARK: - Brand Color
    
    static let main = UIColor(hex: "#EA3468")
//    static let sub = UIColor(hex: "#000000")
    static let error = UIColor(hex: "#A93A3A")
    static let success = UIColor(hex: "#6CE16A")
    
}
