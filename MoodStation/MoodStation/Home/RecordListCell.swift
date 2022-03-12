//
//  RecordListCell.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/02.
//

import UIKit.UITableViewCell
import Foundation.NSDate
import Kingfisher

final class RecordListCell: UITableViewCell {
    
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
        self.routeLine.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.leading.equalTo(self.contentView.snp.leading).offset(37)
            make.top.equalTo(self.contentView.snp.top).offset(30)
            make.bottom.equalToSuperview()
        }
        
        self.addSubview(self.moodRectangle)
        self.moodRectangle.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(30)
            make.top.equalToSuperview()
        }
        
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(6)
            make.leading.equalTo(self.contentView).offset(69)
        }
        
        self.addSubview(self.recordImage)
        self.recordImage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(14)
            make.leading.equalTo(self.contentView).offset(69)
            make.width.height.equalTo(85)
        }
        
        self.addSubview(self.keywordCollection)
        self.keywordCollection.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(14)
            make.leading.equalTo(recordImage.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-35)
            make.bottom.equalTo(recordImage)
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
            $0.layer.cornerRadius = 6
            $0.clipsToBounds = true
        }
        
        self.dateLabel.do {
            $0.textColor = .gray01
            $0.font = .body0M
        }
        
        self.recordImage.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 6
            $0.clipsToBounds = true
        }
        
        self.keywordCollection.do {
            $0.backgroundColor = .customBlack
            $0.register(KeywordCollectionViewCell.self)
            $0.dataSource = self
            $0.isScrollEnabled = false
            $0.setCollectionViewLayout(LeftAlignedCollectionViewFlowLayout(
                minimumLineSpacing: 6,
                minimumInteritemSpacing: 6,
                estimatedItemSize: CGSize(width: 50.0, height: 24.0)), animated: false)
        }
    }
    
    private let routeLine = UIView(frame: .zero)
    private let moodRectangle = UIView(frame: .zero)
    private var dateLabel = UILabel(frame: .zero)
    private var recordImage = UIImageView(frame: .zero)
    private var keywords: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.keywordCollection.reloadData()
            }
        }
    }
    private let keywordCollection = UICollectionView(frame: .zero,
                                                     collectionViewLayout: UICollectionViewLayout())
}

extension RecordListCell: Configurable {
    func configure<T>(data: T) {
        if let record = data as? Record {
            self.routeLine.isHidden = record.date.isLastDay
            self.moodRectangle.drawMoodRectangle(mood: record.mood)
            self.dateLabel.text = Self.recordDateFormatter.string(from: record.date)
            self.keywords = record.keyword
            if let url = URL(string: record.imagePath) {
                recordImage.kf.setImage(with: url)
            }
        }
    }
}

extension RecordListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(data: keywords[indexPath.item])
        return cell
    }
}
