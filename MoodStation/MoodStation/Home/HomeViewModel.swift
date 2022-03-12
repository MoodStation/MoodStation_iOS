//
//  HomeViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import Foundation

protocol HomeViewModelType {
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func headerData(at index: Int) -> Date
    func cellModel(at indexPath: IndexPath) -> HomeViewModel.CellModel
}

final class HomeViewModel {
    
    enum CellModel {
        case record(Record)
        case empty(EmptyCellModel)
    }

    init() {
        self.recordBundles = []
        self.dateHandler = DateHandler.shared
        self.page = self.dateHandler.makeTodayPage()
    }
    
    private var recordBundles: [MonthlyBundle] = []
    private let dateHandler: DateHandler
    private var page: (year: Int, month: Int)
}

// MARK: - DataSource
extension HomeViewModel: HomeViewModelType{
    var numberOfSection: Int {
        recordBundles.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        self.recordBundles[section].records.count
    }
    
    func headerData(at index: Int) -> Date {
        let section = self.recordBundles[index]
        let sectionComponents = DateComponents(year: section.date.year, month: section.date.month)
        let sectionDate = self.dateHandler.date(from: sectionComponents)
        return sectionDate
    }
    
    func cellModel(at indexPath: IndexPath) -> CellModel {
        let section = self.recordBundles[indexPath.section]
        if let record = section.records[indexPath.row] {
            return .record(record)
        } else {
            return self.makeEmptyCellModel(by: section, at: indexPath)
        }
    }
    
    private func makeEmptyCellModel(by section: MonthlyBundle, at indexPath: IndexPath) -> CellModel {
        let todayComponents = dateHandler.todayComponents()
        let cellDateComponents = DateComponents(year: section.date.year, month: section.date.month, day: indexPath.row + 1)
        let cellDate = dateHandler.date(from: cellDateComponents)
        
        if section.isThisMonth, let index = todayComponents.day, index == indexPath.row {
            return .empty(EmptyCellModel(date: cellDate, style: .tomorrow))
        } else if todayComponents == cellDateComponents {
            return .empty(EmptyCellModel(date: cellDate, style: .today))
        } else {
            return .empty(EmptyCellModel(date: cellDate, style: .notRecord))
        }
    }
}
