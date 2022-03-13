//
//  RecordViewModel.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit

final class RecordViewModel {
    
    enum Section {
        case title([Item])
        case colorChip([Item])
        case keyword([Item])
        case image([Item])
        case singleRecording([Item])
        
        var items: [Item] {
            switch self {
            case .title(let items):             return items
            case .colorChip(let items):         return items
            case .keyword(let items):           return items
            case .image(let items):             return items
            case .singleRecording(let items):   return items
            }
        }
    }
    
    enum Item {
        case title(TextOnlyTableViewCellModel)
        case colorChip(RecordColorChipsCellModel)
        case keyword(RecordKeywordChipCell)
        case image(RecordImageViewCellModel)
        case singleRecording(RecordSingleRecordingCellModel)
    }
    
    init() {
        // TODO: - Calendar View Model 을 RecordViewModel 이 갖도록하기 ?
        // + Init 할 때 초기 Date 에 대한 의존성 필요함 -> 만약 Date 값이 없으면 Today 라고 생각하고 진행
        self.sections = self.makeSections()
    }
    
    var numberOfSections: Int {
        self.sections.count
    }
    
    func selectItem(at indexPath: IndexPath) {
        // TODO: - Do Something
        
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        self.sections[safe: section]?.items.count ?? 0
    }
    
    func cellType(at indexPath: IndexPath) -> Item? {
        guard let section = self.sections[safe: indexPath.section] else { return nil }
        return section.items[safe: indexPath.item]
    }
    
    private func makeSections() -> [Section] {
        let sections: [Section] = [
            .title([.title(.init(inset: UIEdgeInsets(top: 20, left: 24, bottom: 0, right: 24), font: .h2SB, text: "날짜를 선택해 주세요.", textColor: .customWhtie, numberOfLines: 1))]), // TODO: - Font 변경
            // TODO: - 여기에 Calendar 추가
                .title([.title(.init(inset: UIEdgeInsets(top: 20, left: 24, bottom: 0, right: 24), font: .h2SB, text: "어떤 역을 지나치셨나요?", textColor: .customWhtie, numberOfLines: 1))]), // TODO: - Font 변경
            .colorChip([.colorChip(.init(collectionViewCellModels: [.init(color: .red), .init(color: .orange), .init(color: .green), .init(color: .blue), .init(color: .purple), .init(color: .gray)]))]),
            .title([.title(.init(inset: UIEdgeInsets(top: 50, left: 24, bottom: 0, right: 24), font: .h2SB, text: "키워드를 입력해 주세요.", textColor: .customWhtie, numberOfLines: 1))]), // TODO: - Font 변경,
            // TODO: - KeywordCell
            .title([.title(.init(inset: UIEdgeInsets(top: 52, left: 24, bottom: 0, right: 24), font: .h2SB, text: "사진을 등록해 주세요.", textColor: .customWhtie, numberOfLines: 1))]), // TODO: - Font 변경
            .image([.image(.init(color: .yellow))]), // TODO: 변경
            .title([.title(.init(inset: UIEdgeInsets(top: 52, left: 24, bottom: 0, right: 24), font: .h2SB, text: "한 줄 기록을 남겨주세요.", textColor: .customWhtie, numberOfLines: 1))]), // TODO: - Font 변경
            .singleRecording([.singleRecording(.init(text: ""))])
        ]
        
        return sections
    }
    
    
    private var sections: [Section] = []
}
