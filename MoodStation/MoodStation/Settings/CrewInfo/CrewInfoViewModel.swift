//
//  CrewInfoViewModel.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/12.
//

import UIKit

protocol CrewInfoViewModelType {
    associatedtype CellModel
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> CellModel
}

final class CrewInfoViewModel {
    
    enum Section {
        case text([Item])
        case cell([Item])
        
        var items: [Item] {
            switch self {
            case let .text(item): return item
            case let .cell(items): return items
            }
        }
    }
    
    enum Item {
        case text(TextOnlyTableViewCellModel)
        case cell(UserInfo)
    }
    
    init() {
        self.crewInfos = self.makeSections()
    }
    
    private func makeSections() -> [Section] {
        return [
            .text([.text(.init(inset: UIEdgeInsets(top: 23, left: 24, bottom: 0, right: 0), font: .h4SB, text: "무드스테이션 팀원들", textColor: .white, numberOfLines: 1)),
                   .text(.init(inset: UIEdgeInsets(top: 28, left: 24, bottom: 0, right: 0), font: .body2M, text: "Planning / Design", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.init(name: "이지현", email: "haileyzeonni@gmail.com", userImagePath: "지현_memoji")),
                   .cell(.init(name: "홍희정", email: "prahabin@naver.com", userImagePath: "희정_memoji"))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 28, left: 24, bottom: 0, right: 0), font: .body2M, text: "iOS", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.init(name: "김용우", email: "keepingitflow@gmail.com", userImagePath: "용우_memoji")),
                   .cell(.init(name: "홍성준", email: "haileyzeonni@gmail.com", userImagePath: "성준_memoji"))]),
            .text([.text(.init(inset: UIEdgeInsets(top: 28, left: 24, bottom: 0, right: 0), font: .body2M, text: "Server", textColor: .gray03, numberOfLines: 1))]),
            .cell([.cell(.init(name: "이승헌", email: "seungheon328@gmail.com", userImagePath: "승헌_memoji")),
                   .cell(.init(name: "오현아", email: "haileyzeonni@gmail.com", userImagePath: "현아_memoji"))])
        ]
    }
    private var crewInfos: [Section] = []
}

extension CrewInfoViewModel: CrewInfoViewModelType {
    var numberOfSection: Int {
        return self.crewInfos.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.crewInfos[section].items.count
    }
    
    func cellModel(at indexPath: IndexPath) -> Item {
        let section = self.crewInfos[indexPath.section]
        return section.items[indexPath.row]
    }
    
    func cellHeight(at indexPath: IndexPath) -> CGFloat {
        let section = self.crewInfos[indexPath.section]
        switch section {
        case .text(_):  return 46
        case .cell(_):  return 101
        }
    }
}
