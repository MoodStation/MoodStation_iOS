//
//  SignInViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit

final class SignInViewModel {
    
    enum Section {
        case text([Item])
        case textField([Item])
        
        var items: [Item] {
            switch self {
            case let .text(items):       return items
            case let .textField(items):  return items
            }
        }
    }
    
    enum Item {
        case text(TextOnlyTableViewCellModel)
        case textField(TextFieldOnlyTableViewCellModel)
    }
    
    init() {
        self.sections = self.makeSections()
    }
    
    var numberOfSections: Int {
        self.sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        self.sections[safe: section]?.items.count ?? 0
    }
    
    func cellModel(at indexPath: IndexPath) -> Item? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        return section.items[safe: indexPath.item]
    }
    
    private func makeSections() -> [Section] {
        return [
            .text([.text(.init(inset: UIEdgeInsets(top: 20, left: 24, bottom: 0, right: 0), font: .h1B, text: "로그인", textColor: .customWhtie, numberOfLines: 1))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 14, left: 24, bottom: 0, right: 0), font: .body1R, text: "~에 로그인하고\n기록을 이어나가 보세요.", textColor: .customWhtie, numberOfLines: 2))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 70, left: 24, bottom: 0, right: 0), font: .body1R, text: "이메일", textColor: .customWhtie, numberOfLines: 1))]),
            .textField([.textField(.init(inset: UIEdgeInsets(top: 14, left: 24, bottom: 0, right: 24),placeholder: "이메일을 입력해 주세요.", font: .body1R))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 0, right: 0), font: .body1R, text: "비밀번호", textColor: .customWhtie, numberOfLines: 1))]),
            .textField([.textField(.init(inset: UIEdgeInsets(top: 14, left: 24, bottom: 0, right: 24),placeholder: "비밀번호를 입력해 주세요.", font: .body1R))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 14, left: 24, bottom: 0, right: 0), font: .caption1M, text: "이메일 또는 비밀번호를 확인해주세요", textColor: .error, numberOfLines: 1))])
        ]
    }
    
    private var sections: [Section] = []
    
}
