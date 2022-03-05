//
//  TextOnlyTableViewCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/05.
//

import UIKit
import SnapKit
import Then

struct TextOnlyTableViewCellModel {
    let inset: UIEdgeInsets?
    let font: UIFont?
    let text: String?
    let textColor: UIColor?
    let numberOfLines: Int
}

final class TextOnlyTableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TextOnlyTableViewCellModel) {
        self.label.text = model.text
        self.label.font = model.font
        self.label.textColor = model.textColor
        self.label.numberOfLines = model.numberOfLines
        
        self.label.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(model.inset ?? .zero)
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.selectionStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    private let label = UILabel(frame: .zero)
    
}
