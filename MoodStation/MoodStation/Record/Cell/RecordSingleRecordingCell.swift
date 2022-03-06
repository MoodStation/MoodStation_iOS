//
//  RecordSingleRecordingCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then

struct RecordSingleRecordingCellModel {
    let text: String
}

final class RecordSingleRecordingCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: RecordSingleRecordingCellModel) {
        self.textField.text = model.text
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
        }
        
        self.containerView.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(14)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.containerView.do {
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
        }
        
        self.textField.do {
            $0.isEnabled = false
            $0.attributedPlaceholder = NSMutableAttributedString(string: "탭해서 오늘 하루를 기록해 보세요.")
                .font(.body1R)
                .foregroundColor(.gray03)
            $0.textColor = .customWhtie
            $0.font = .body1R
        }
    }
    
    private let containerView = UIView(frame: .zero)
    private let textField = UITextField(frame: .zero)
    
}
