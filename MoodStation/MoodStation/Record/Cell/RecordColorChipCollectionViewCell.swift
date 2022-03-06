//
//  RecordColorChipCollectionViewCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then

struct RecordColorChipCollectionViewCellModel {
    // TODO: - Gradient Image 로 변경
    let color: UIColor?
}

final class RecordColorChipCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        // TODO: - imageView 초기화
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: RecordColorChipCollectionViewCellModel) {
        self.imageView.backgroundColor = model.color
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.imageView.do {
            $0.backgroundColor = .customWhtie
            $0.layer.cornerRadius = 10
        }
    }
    
    
    private let imageView = UIImageView(frame: .zero)
}
