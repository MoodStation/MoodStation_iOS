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
    
    static let customBlack = UIColor(hex: "#171717")
    static let gray06 = UIColor(hex: "#222222")
    static let gray05 = UIColor(hex: "#2E2E2E")
    static let gray04 = UIColor(hex: "#555555")
    static let gray03 = UIColor(hex: "#9E9E9E")
    static let gray02 = UIColor(hex: "#C1C1C1")
    static let gray01 = UIColor(hex: "#ECECEC")
    static let customWhtie = UIColor(hex: "#FBFBFB")
    
    //MARK: - Brand Color
    
    static let main = UIColor(hex: "#EA3468")
//    static let sub = UIColor(hex: "#000000")
    static let error = UIColor(hex: "#A93A3A")
    static let success = UIColor(hex: "#6CE16A")
    
    // MARK: - Gradient Color

    static let moodRed = [UIColor(hex: "#FF3D4F"), UIColor(hex: "#FFA755")]
    static let moodOrange = [UIColor(hex: "#FF9144"), UIColor(hex: "#FFF973")]
    static let moodGreen = [UIColor(hex: "#C5FF7C"), UIColor(hex: "#A8EFFF")]
    static let moodBlue = [UIColor(hex: "#1F48DA"), UIColor(hex: "#9BE5FB")]
    static let moodPurple = [UIColor(hex: "#741FFF"), UIColor(hex: "#FFA8CC")]
    static let moodNavy = [UIColor(hex: "#130624"), UIColor(hex: "#243696")]
    
    static let crewInfo = [UIColor(hex: "#F6CACA"), UIColor(hex: "#E52F63")]
}

enum GradientStyle: Int {
    case moodRed = 1
    case moodOrange
    case moodGreen
    case moodBlue
    case moodPurple
    case moodNavy
}

extension UIColor {
    
    static func makeGradientColors(by style: GradientStyle) -> [CGColor] {
        switch style {
        case .moodRed:      return moodRed.compactMap{ $0?.cgColor }
        case .moodOrange:   return moodOrange.compactMap{ $0?.cgColor }
        case .moodGreen:    return moodGreen.compactMap{ $0?.cgColor }
        case .moodBlue:     return moodBlue.compactMap{ $0?.cgColor }
        case .moodPurple:   return moodPurple.compactMap{ $0?.cgColor }
        case .moodNavy:     return moodNavy.compactMap{ $0?.cgColor }
        }
    }
    
}
