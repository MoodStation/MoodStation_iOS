//
//  MonthlyBundle.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/11.
//

import Foundation.NSDate

struct MonthlyBundle {
    let date: (year: Int, month: Int)
    let numberOfDays: Int
    let isThisMonth: Bool
    var records: [Record?]
    
    init(date: (Int, Int), numberOfDays: Int, isThisMonth: Bool = false) {
        self.date = date
        self.numberOfDays = numberOfDays
        self.isThisMonth = isThisMonth
        self.records = [Record?](repeating: nil, count: numberOfDays)
    }
}
