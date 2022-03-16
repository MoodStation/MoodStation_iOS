//
//  EmptyRecordListCell.swift
//  TestProject
//
//  Created by Yongwoo Marco on 2022/03/08.
//

import UIKit.UITableViewCell

struct RecordListEmptyCellModel {
    let date: Date
    let style: RecordListEmptyCell.EmptyStyle
}

final class RecordListEmptyCell: UITableViewCell {
    
    enum EmptyStyle {
        case notRecord
        case today
        case tomorrow
    }
    
    static let recordDateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "en_KR")
        $0.dateFormat = "d, MMMM"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.routeLine)
        routeLine.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.leading.equalTo(self.contentView.snp.leading).offset(37)
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalToSuperview()
        }
        
        self.addSubview(self.moodRectangle)
        moodRectangle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.contentView).offset(29)
            make.width.equalTo(21)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(6)
            make.leading.equalTo(self.contentView).offset(69)
        }
        
        self.addSubview(self.emptyImageView)
        self.emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(14)
            make.leading.equalTo(self.contentView).offset(69)
            make.width.height.equalTo(85)
        }
        
        self.emptyImageView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(emptyImageView)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.routeLine.do {
            $0.backgroundColor = .gray01
        }
        
        self.moodRectangle.do {
            $0.backgroundColor = .gray05
            $0.layer.cornerRadius = 10.5
            $0.clipsToBounds = true
        }
        
        self.dateLabel.do {
            $0.font = .body0M
        }
        
        self.emptyImageView.do {
            $0.backgroundColor = .none
        }
        
        self.stateLabel.do {
            $0.font = .body1R
        }
    }
    
    private var routeLine = UIView(frame: .zero)
    private var moodRectangle = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 30))
    private var dateLabel = UILabel(frame: .zero)
    private var emptyImageView = UIView(frame: .zero)
    private var stateLabel = UILabel(frame: .zero)
}

extension RecordListEmptyCell: Configurable {
    func configure<T>(data: T) {
        if let model = data as? RecordListEmptyCellModel {
            dateLabel.text = Self.recordDateFormatter.string(from: model.date)
            switch model.style {
            case .notRecord:
                self.routeLine.isHidden = false
                self.routeLine.backgroundColor = .gray01
                self.moodRectangle.backgroundColor = .gray01
                self.dateLabel.textColor = .gray01
                self.stateLabel.text = "Empty"
                self.stateLabel.textColor = .gray01
                self.emptyImageView.drawEmptyImageView(color: .gray01)
            case .today:
                self.routeLine.isHidden = true
                self.routeLine.backgroundColor = .gray01
                self.moodRectangle.backgroundColor = .gray01
                self.dateLabel.textColor = .gray01
                self.stateLabel.text = "Today"
                self.stateLabel.textColor = .gray01
                self.emptyImageView.drawEmptyImageView(color: .gray01)
            case .tomorrow:
                self.routeLine.isHidden = false
                self.routeLine.backgroundColor = .gray05
                self.moodRectangle.backgroundColor = .gray05
                self.dateLabel.textColor = .gray05
                self.stateLabel.text = "Empty - Tomorrow" // - Tomorrow는 표시용 삭제 예정
                self.stateLabel.textColor = .gray05
                self.emptyImageView.drawEmptyImageView(color: .gray05)
            }
        }
    }
}
