//
//  SettingsViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

protocol SettingsViewModelType: LogInSession {
    associatedtype CellModel
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> CellModel?
    func didSelectRowAt(at indexPath: IndexPath) -> CellModel?
}

final class SettingsViewModel {
    
    enum Settings {
        case alert(Alert)
        case navigation(Navigation)
        
        enum Alert: CustomStringConvertible {
            case logIn
            case logOut
            case deleteAcount
            
            var description: String {
                switch self {
                case .logIn:        return "로그인"
                case .logOut:       return "로그아웃"
                case .deleteAcount: return "탈퇴하기"
                }
            }
            
            var imageName: String {
                switch self {
                case .logIn:        return "공유입장"
                case .logOut:       return "로그아웃"
                case .deleteAcount: return "탈퇴하기"
                }
            }
        }
        
        enum Navigation: CustomStringConvertible {
            case contact
            case crewInfo
            
            var description: String {
                switch self {
                case .contact:      return "문의하기"
                case .crewInfo:     return "무드스테이션 팀원들"
                }
            }
            
            var imageName: String {
                switch self {
                case .contact:      return "icn_문의하기"
                case .crewInfo:     return "icn_팀원"
                }
            }
        }
    }
    
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
        case cell(Settings)
    }
    
    init() {
        self.sections = self.makeSections()
    }
    
    private func makeSections() -> [Section] {
        switch logInUser {
        case .none:
            return self.logOutSections()
        case .some(let user):
            return self.logInSections(user)
        }
        
    }
    
    private func logInSections(_ user: User) -> [Section] {
        return [
            .text([.text(.init(inset: UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 0), font: .body1R, text: "mood station", textColor: .white, numberOfLines: 1))]),
            .user([.user(user)]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 8, right: 0), font: .body2M, text: "Contact", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.navigation(.contact)), .cell(.navigation(.crewInfo))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 8, right: 0), font: .body2M, text: "Account", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.alert(.logOut)), .cell(.alert(.deleteAcount))])
        ]
    }
    
    private func logOutSections() -> [Section] {
        return [
            .text([.text(.init(inset: UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 0), font: .body1R, text: "mood station", textColor: .white, numberOfLines: 1))]),
            .user([.user(self.logInUser)]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 8, right: 0), font: .body2M, text: "Contact", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.navigation(.contact)), .cell(.navigation(.crewInfo))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 36, left: 24, bottom: 8, right: 0), font: .body2M, text: "Account", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.alert(.logIn))])
        ]
    }
    
    
    private var sections: [Section] = []
    var appController = AppController.shared
    var logInUser: User? = .init(name: "용우동", email: "keepingitflow@gmail.com", password: "비밀번호password", userImagePath: "https://image.tmdb.org/t/p/w500/uZRQgumqHdVqnaflAsJqu8NzjEA.jpg") // 로그인 상태 Dummy 삭제 예정
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
    
    func makeAlert(_ style: Settings.Alert) -> AlertView? {
        switch style {
        case .logIn:
            return AlertView(title: "로그인 하시겠습니까?",
                      detail: "로그인 페이지로 이동합니다",
                      imageName: style.imageName,
                      confirm: "이동",
                      style: .confirm)
        case .logOut:
            return AlertView(title: "로그아웃 하시겠어요?",
                      detail: "기록은 지워지지 않아요.",
                      imageName: style.imageName,
                      confirm: "로그아웃", style: .confirm)
        case .deleteAcount:
            return AlertView(title: "정말 탈퇴하시겠어요?",
                      detail: "기록이 삭제되며 복구할 수 없어요!",
                      imageName: style.imageName,
                      confirm: "탈퇴", style: .confirm)
        }
    }
}

