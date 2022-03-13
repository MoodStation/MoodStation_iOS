//
//  RecordCalendarWeeklyCollectionCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/12.
//

import UIKit
import SnapKit
import Then

final class RecordCalendarWeeklyCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        self.weeklyLabel.text = text
    }
    
    private func setupLayout() {
        self.addSubview(self.weeklyLabel)
        self.weeklyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.weeklyLabel.do {
            $0.font = .body2M
            $0.textColor = .gray03
        }
    }
    
    private let weeklyLabel = UILabel(frame: .zero)
    
}
