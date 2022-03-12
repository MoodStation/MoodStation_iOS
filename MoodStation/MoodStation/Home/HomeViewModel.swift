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
}

final class HomeViewModel {

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
        let sectionDate = dateHandler.date(from: sectionComponents)
        return sectionDate
    }
}
