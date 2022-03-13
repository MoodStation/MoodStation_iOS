//
//  RecordCalendarViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/12.
//

import Foundation
import RxSwift
import RxRelay

final class RecordCalendarViewModel {
    
    enum Section {
        case week([Item])
        case day([Item])
        
        var items: [Item] {
            switch self {
            case .week(let items):  return items
            case .day(let items):   return items
            }
        }
    }
    
    enum Item {
        case week(String)
        case day(RecordCalendarDayCollectionViewCellModel)
    }
    
    init() {
        self.sections = self.makeSections()
    }
    
    var sectionDidUpdate: Observable<Void> {
        return self.sectionDidUpdateRelay.asObservable()
    }
    
    func selectItem(at indexPath: IndexPath) {
        guard let section = self.sections[safe: indexPath.section] else { return }
        guard let item = section.items[safe: indexPath.row] else { return }
        
        switch item {
        case .day:
            self.sections = self.sections.enumerated().map({ sectionIndex, section -> Section in
                switch section {
                case .week:
                    return section
                    
                case .day(let items):
                    let newItems = items.enumerated().map({ itemIndex, item -> Item in
                        switch item {
                        case .week:
                            return item
                            
                        case .day(let model):
                            return .day(.init(day: model.day, isEnabled: model.isEnabled, isSelected: model.isEnabled && indexPath.row == itemIndex && indexPath.section == sectionIndex))
                        }
                    })
                    return .day(newItems)
                }
            })
            
            self.selectedIndexPath = indexPath
            self.sectionDidUpdateRelay.accept(())
            
        default:
            return
        }
    }
    
    func cellItem(at indexPath: IndexPath) -> Item? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        return section.items[safe: indexPath.row]
    }
    
    var numberOfSections: Int {
        return self.sections.count
    }
    
    func numberOfItmesInSection(_ section: Int) -> Int {
        guard let section = self.sections[safe: section] else {
            return 0
        }
        return section.items.count
    }
    
    private func makeSections() -> [Section] {
        let sections: [Section] = [
            self.makeWeekSection(),
            self.makeDaySection()
        ]
        return sections
    }
    
    private func makeWeekSection() -> Section {
        return .week([.week("Sun"), .week("Mon"), .week("Tue"), .week("Wed"), .week("Thu"), .week("Fri"), .week("Sat")])
    }
    
    private func makeDaySection() -> Section {
        // TODO: - Year Month 기준으로 Day Section 생성하기
        let items: [Item] = (1...31).map({ day in
            switch day {
            case 4, 5, 9, 11:
                return .day(.init(day: day, isEnabled: false, isSelected: false))
                
            default:
                return .day(.init(day: day))
            }
        })
        
        return .day(items)
    }
    
    private var sections: [Section] = []
    private var selectedIndexPath: IndexPath?
    
    private let sectionDidUpdateRelay = PublishRelay<Void>()
    
}
