//
//  SettingsViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

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
        case user(UserInfo?)
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
    private var userInfo: UserInfo? = .init(name: "용우동", email: "keepingitflow@gmail.com", userImagePath: "https://image.tmdb.org/t/p/w500/uZRQgumqHdVqnaflAsJqu8NzjEA.jpg")
}
