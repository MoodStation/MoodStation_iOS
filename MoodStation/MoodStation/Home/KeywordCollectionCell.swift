//
//  KeywordCollectionCell.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/02.
//

import UIKit.UICollectionView

final class KeywordCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.keywordLabel)
        self.keywordLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(3)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(11)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .gray05
        }
        
        self.keywordLabel.do {
            $0.textColor = .gray01
            $0.font = .body0M // body3-regular ?
        }
    }
    
    private let keywordLabel: UILabel = UILabel(frame: .zero)
}

extension KeywordCollectionViewCell: Configurable {
    func configure<T>(data: T) {
        if let text = data as? String {
            keywordLabel.text = text
        }
    }
}
