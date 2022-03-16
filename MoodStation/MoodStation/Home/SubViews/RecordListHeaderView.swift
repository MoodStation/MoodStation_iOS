//
//  RecordListHeaderView.swift
//  TestProject
//
//  Created by Yongwoo Marco on 2022/03/08.
//

import UIKit.UIView

struct RecordListHeaderViewModel {
    let date: String
}

final class RecordListHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(5)
        }
    }

    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.dateLabel.do {
            $0.textColor = .gray01
            $0.font = .h4SB
        }
    }
    
    private let dateLabel = UILabel(frame: .zero)
}

extension RecordListHeaderView: Configurable {
    func configure<T>(data: T) {
        if let model = data as? RecordListHeaderViewModel {
            self.dateLabel.text = model.date
        }
    }
}

