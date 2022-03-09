//
//  Date+.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/07.
//

import Foundation.NSData

extension Date {
    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var isLastDay: Bool {
        let today = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: self)
        let endDay = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: endOfMonth)
        return today == endDay
    }
}
