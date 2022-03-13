//
//  RecordCalendarDayCollectionViewCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/12.
//

import UIKit
import SnapKit
import Then

struct RecordCalendarDayCollectionViewCellModel {
    let day: Int
    let isEnabled: Bool
    let isSelected: Bool
    
    init(day: Int, isEnabled: Bool = true, isSelected: Bool = false) {
        self.day = day
        self.isEnabled = isEnabled
        self.isSelected = isSelected
    }
}

final class RecordCalendarDayCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionView.backgroundColor = .clear
    }
    
    func configure(model: RecordCalendarDayCollectionViewCellModel) {
        self.dayLabel.text = "\(model.day)"
        
        self.selectionView.backgroundColor = model.isEnabled ? .clear : .gray05
        if model.isSelected {
            self.selectionView.backgroundColor = .main
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.selectionView)
        self.selectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.selectionView.addSubview(self.dayLabel)
        self.dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.dayLabel.do {
            $0.font = .body0M
            $0.textColor = .customWhtie
        }
        
        self.selectionView.do {
            $0.layer.cornerRadius = 20
        }
    }
    
    private let dayLabel = UILabel(frame: .zero)
    private let selectionView = UIView(frame: .zero)
    
}
