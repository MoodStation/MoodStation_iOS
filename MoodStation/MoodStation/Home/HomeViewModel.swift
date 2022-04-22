//
//  HomeViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import Foundation

protocol HomeViewModel {
    func headerModel(at index: Int) -> HomeViewModelImpl.Header?
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> HomeViewModelImpl.Item?
}

final class HomeViewModelImpl {
    
    enum Header {
        case date(RecordListHeaderViewModel)
    }
    
    enum Item {
        case record(RecordListCellModel)
        case empty(RecordListEmptyCellModel)
    }

    init() {
        self.sections = []
        self.dateHandler = DateHandler.shared
        self.page = self.dateHandler.makeTodayPage()
    }
    
    private var sections: [MonthlyBundle] = []
    private let dateHandler: DateHandler
    private var page: (year: Int, month: Int)
}

// MARK: - DataSource
extension HomeViewModelImpl: HomeViewModel {
    
    var numberOfSection: Int {
        self.sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        self.sections[section].records.count
    }
    
    func headerModel(at index: Int) -> Header? {
        guard let section = self.sections[safe: index] else { return nil }
        let headerDate = self.makeHeaderDate(by: section)
        let stringDate = self.dateHandler.recordDate(from: headerDate)
        return .date(RecordListHeaderViewModel(date: stringDate))
    }
    
    func cellModel(at indexPath: IndexPath) -> Item? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        if let record = section.records[indexPath.row] {
            return .record(RecordListCellModel(isLastDay: dateHandler.isLastDay(record.date),
                                               mood: record.mood,
                                               date: dateHandler.recordDate(from: record.date),
                                               keywords: record.keywords, imagePath: record.imagePath))
        } else {
            return self.makeEmptyCellModel(by: section, at: indexPath)
        }
    }
    
    private func makeCellDate(by section: MonthlyBundle, and indexPath: IndexPath) -> Date {
        return dateHandler.makeDate(year: section.date.year, month: section.date.month, day: indexPath.row + 1)
    }
    
    private func makeHeaderDate(by section: MonthlyBundle) -> Date {
        let sectionComponents = DateComponents(year: section.date.year, month: section.date.month)
        return self.dateHandler.date(from: sectionComponents)
    }
    
    private func makeEmptyCellModel(by section: MonthlyBundle, at indexPath: IndexPath) -> Item {
        let cellDate = makeCellDate(by: section, and: indexPath)
        if section.isThisMonth,
            dateHandler.convertCellIndex(by: Date()) < indexPath.row {
            return .empty(RecordListEmptyCellModel(date: cellDate, style: .tomorrow))
        } else if dateHandler.isToday(cellDate) {
            return .empty(RecordListEmptyCellModel(date: cellDate, style: .today))
        } else {
            return .empty(RecordListEmptyCellModel(date: cellDate, style: .notRecord))
        }
    }
}
