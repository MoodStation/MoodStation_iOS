//
//  RecordImageViewCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then

struct RecordImageViewCellModel {
    // TODO: Image로 변경
    let color: UIColor?
}

final class RecordImageViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: RecordImageViewCellModel) {
        self.photoImageView.backgroundColor = model.color
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
            make.height.equalTo(self.photoImageView.snp.width)
        }
    }
    
    // TODO: - Gesture 추가해서 앨범이랑 연결
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.photoImageView.do {
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
        }
    }
    
    private let photoImageView = UIImageView(frame: .zero)
    
}
