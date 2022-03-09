//
//  Array+.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/05.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
    
}
