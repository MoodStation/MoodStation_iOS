//
//  AttributedString+.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit

extension NSMutableAttributedString {
    
    var range: NSRange {
        let range = NSRange(location: 0, length: self.length)
        return range
    }
    
    func foregroundColor(_ color: UIColor?) -> NSMutableAttributedString {
        guard let color = color else {
            return self
        }
        
        self.addAttributes([.foregroundColor: color], range: self.range)
        return self
    }
    
    func font(_ font: UIFont?) -> NSMutableAttributedString {
        guard let font = font else {
            return self
        }
        self.addAttributes([.font: font], range: range)
        return self
    }
    
}
