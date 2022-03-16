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
    private let recordDateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "en_KR")
        $0.dateFormat = "MMMM, yyyy"
    }
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
    
    func convertCellIndex(by date: Date) -> Int {
        var result = 0
        calendar.dateComponents([.day], from: date).day.flatMap{ result = $0 - 1 }
        return result
    }
    
    func makeDate(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return self.date(from: components)
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
    
    func firstDate(from date: Date) -> Date {
        var result = Date()
        let components = calendar.dateComponents([.year, .month], from: date)
        calendar.date(from: components).flatMap { result = $0 }
        return result
    }

    func lastDate(from date: Date) -> Date {
        var result = Date()
        let components = DateComponents(month: 1, day: -1)
        calendar.date(byAdding: components, to: firstDate(from: date)).flatMap{ result = $0 }
        return result
    }
    
    // Compare Dates
    func isLastDay(_ date: Date) -> Bool {
        let thisDay = calendar.dateComponents([.year, .month, .day], from: date)
        let lastDay = calendar.dateComponents([.year, .month, .day], from: lastDate(from: date))
        return thisDay == lastDay
    }
    
    func isToday(_ date: Date) -> Bool {
        let thisDay = calendar.dateComponents([.year, .month, .day], from: date)
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return thisDay == components
    }
}

// MARK: - DateFormatting
extension DateHandler {
    func recordDate(from date: Date) -> String {
        return recordDateFormatter.string(from: date)
    }
}
