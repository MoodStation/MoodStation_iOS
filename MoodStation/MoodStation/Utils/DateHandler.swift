//
//  DateHandler.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/11.
//

import Foundation.NSDate
import Foundation.NSCalendar

final class DateHandler {
    static let shared = DateHandler()
    private init() {}
    
    private let calendar = Calendar(identifier: .gregorian)
}

// MARK: - Pagination Handle
extension DateHandler {
    func makeTodayPage() -> (Int, Int) {
        var result = (year: 0, month: 0)
        let components = calendar.dateComponents([.year, .month], from: Date())
        components.year.flatMap{ result.year = $0 }
        components.month.flatMap{ result.month = $0 }
        return result
    }
}

// MARK: - Calendar Handle
extension DateHandler {
    func date(from components: DateComponents) -> Date {
        var result = Date()
        calendar.date(from: components).flatMap{ result = $0 }
        return result
    }
    
    func todayComponents() -> DateComponents {
        return calendar.dateComponents([.year, .month, .day], from: Date())
    }
}
