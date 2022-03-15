//
//  HomeViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import Foundation

protocol HomeViewModelType {
    associatedtype CellModel
    associatedtype HeaderModel
    
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func headerModel(at index: Int) -> HeaderModel? 
    func cellModel(at indexPath: IndexPath) -> CellModel?
}

final class HomeViewModel {
    
    enum HeaderModel {
        case date(Date)
    }
    
    enum CellModel {
        case record(Record)
        case empty(EmptyCellModel)
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
extension HomeViewModel: HomeViewModelType {
    var numberOfSection: Int {
        self.sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        self.sections[section].records.count
    }
    
    func headerModel(at index: Int) -> HeaderModel? {
        guard let section = self.sections[safe: index] else { return nil }
        let sectionComponents = DateComponents(year: section.date.year, month: section.date.month)
        let sectionDate = self.dateHandler.date(from: sectionComponents)
        return .date(sectionDate)
    }
    
    func cellModel(at indexPath: IndexPath) -> CellModel? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        if let record = section.records[indexPath.row] {
            return .record(record)
        } else {
            return self.makeEmptyCellModel(by: section, at: indexPath)
        }
    }
    
    private func makeCellDate(by section: MonthlyBundle, and indexPath: IndexPath) -> Date {
        return dateHandler.makeDate(year: section.date.year, month: section.date.month, day: indexPath.row + 1)
    }
    
    private func makeEmptyCellModel(by section: MonthlyBundle, at indexPath: IndexPath) -> CellModel {
        let cellDate = makeCellDate(by: section, and: indexPath)
        if section.isThisMonth,
            dateHandler.convertCellIndex(by: Date()) < indexPath.row {
            return .empty(EmptyCellModel(date: cellDate, style: .tomorrow))
        } else if dateHandler.isToday(cellDate) {
            return .empty(EmptyCellModel(date: cellDate, style: .today))
        } else {
            return .empty(EmptyCellModel(date: cellDate, style: .notRecord))
        }
    }
}
