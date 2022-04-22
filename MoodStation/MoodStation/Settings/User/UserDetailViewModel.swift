//
//  UserDetailViewModel.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/23.
//

import UIKit

protocol UserDetailViewModel {
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> UserDetailViewModelImpl.Item?
}

final class UserDetailViewModelImpl {
    
    enum Section {
        case text([Item])
        case textField([Item])
        
        var items: [Item] {
            switch self {
            case let .text(item): return item
            case let .textField(items): return items
            }
        }
    }
    
    enum Item {
        case text(TextOnlyTableViewCellModel)
        case textField(TextFieldOnlyTableViewCellModel)
    }
    
    init(user: User?) {
        self.user = user
        self.sections = self.makeSections()
    }
    
    private func makeSections() -> [Section] {
        return [
            .text([.text(.init(inset: UIEdgeInsets(top: 32, left: 24, bottom: 0, right: 0), font: .body0M, text: "닉네임", textColor: .white, numberOfLines: 1))]),
            .textField([.textField(.init(inset: UIEdgeInsets(top: 14, left: 24, bottom: 0, right: 0), placeholder: "닉네임", font: .body1R, text: user?.name, isEnabled: false))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 8, left: 28, bottom: 0, right: 0), font: .caption1M, text: "이미 사용중인 닉네임입니다.", textColor: .error, numberOfLines: 1))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 42, left: 24, bottom: 0, right: 0), font: .body0M, text: "비밀번호", textColor: .white, numberOfLines: 1))]),
            .textField([
                .textField(.init(inset: UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 0), placeholder: "사용할 비밀번호", font: .body1R, text: user?.password, isEnabled: false, isSecureTextEntry: true)),
                .textField(.init(inset: UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 0), placeholder: "비밀번호 재 확인", font: .body1R, text: user?.password, isEnabled: false, isSecureTextEntry: true))]),
            .text([
                .text(.init(inset: UIEdgeInsets(top: 14, left: 28, bottom: 0, right: 0), font: .caption2R, text: "영문, 숫자, 특수문자를 조합해 8자 이상 입력해 주세요.", textColor: .gray02, numberOfLines: 1)),
                .text(.init(inset: UIEdgeInsets(top: 8, left: 28, bottom: 0, right: 0), font: .caption1M, text: "올바른 비밀번호 형식이 아닙니다.", textColor: .error, numberOfLines: 1))])
        ]
    }
    
    private var sections: [Section] = []
    private var user: User?
}

extension UserDetailViewModelImpl: UserDetailViewModel {
    var numberOfSection: Int {
        return self.sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        self.sections[safe: section]?.items.count ?? 0
    }
    
    func cellModel(at indexPath: IndexPath) -> Item? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        return section.items[safe: indexPath.item]
    }
}
