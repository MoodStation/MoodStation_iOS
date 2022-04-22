//
//  UserDefaults.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import Foundation

extension UserDefaults {
    
    enum Key: String {
        
        case introDidSkip = "introDidSkip"
        
    }
    
    func bool(key: UserDefaults.Key) -> Bool {
        self.bool(forKey: key.rawValue)
    }
    
    func setValue(_ value: Any?, key: UserDefaults.Key) {
        self.setValue(value, forKey: key.rawValue)
    }
}
