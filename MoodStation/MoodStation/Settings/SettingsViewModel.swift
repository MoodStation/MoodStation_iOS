//
//  SettingsViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

protocol SettingsViewModelType {
    associatedtype CellModel
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> CellModel?
    func didSelectRowAt(at indexPath: IndexPath) -> CellModel?
}

final class SettingsViewModel {
    enum Section {
        case text([Item])
        case user([Item])
        case cell([Item])
        
        var items: [Item] {
            switch self {
            case let .text(item): return item
            case let .user(items): return items
            case let .cell(items): return items
            }
        }
    }
    
    enum Item {
        case text(TextOnlyTableViewCellModel)
        case user(User?)
        case cell(SettingsViewController.Settings)
    }
    
    init() {
        self.sections = self.makeSections()
    }
    
    private func makeSections() -> [Section] {
        return [
            .text([.text(.init(inset: UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 0), font: .body1R, text: "mood station", textColor: .white, numberOfLines: 1))]),
            .user([.user(self.userInfo)]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 8, right: 0), font: .body2M, text: "Contact", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.contact), .cell(.crewInfo)]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 8, right: 0), font: .body2M, text: "Account", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.logout), .cell(.deleteAcount)])
        ]
    }
    
    private var sections: [Section] = []
    private var userInfo: User? = .init(name: "용우동", email: "keepingitflow@gmail.com", password: "비밀번호password", userImagePath: "https://image.tmdb.org/t/p/w500/uZRQgumqHdVqnaflAsJqu8NzjEA.jpg") // 로그인 상태 Dummy 삭제 예정
}

extension SettingsViewModel: SettingsViewModelType {
    // MARK: - DataSoruce
    var numberOfSection: Int {
        return self.sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.sections[section].items.count
    }

    func cellModel(at indexPath: IndexPath)  -> Item? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        return section.items[safe: indexPath.item]
    }
    
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        let section = self.sections[indexPath.section]
        
        switch section {
        case .text(_):  return 62.0
        case .user(_):  return 108
        case .cell(_):  return 55
        }
    }
    
    // MARK: - Delegate
    func didSelectRowAt(at indexPath: IndexPath) -> Item? {
        let section = self.sections[indexPath.section]
        switch section {
        case .text(_):
            return nil
        case .user(let items):
            return items[indexPath.row]
        case .cell(let items):
            return items[indexPath.row]
        }
    }
}

