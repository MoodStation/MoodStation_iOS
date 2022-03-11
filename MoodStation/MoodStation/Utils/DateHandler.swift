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
    private let today = Date()
}

// MARK: - Pagination Handle
extension DateHandler {
    func makeTodayPage() -> (Int, Int) {
        var result = (year: 0, month: 0)
        let components = calendar.dateComponents([.year, .month], from: today)
        components.year.flatMap{ result.year = $0 }
        components.month.flatMap{ result.month = $0 }
        return result
    }
}
