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
            make.centerY.equalTo(self.moodRectangle)
            make.leading.equalTo(self.moodRectangle.snp.trailing).offset(20)
        }
        
        self.addSubview(self.recordImage)
        self.recordImage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(14)
            make.leading.equalTo(self.contentView).offset(69)
            make.width.height.equalTo(85)
        }
        
        self.keywordCollection.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(14)
            make.leading.equalTo(recordImage.snp.trailing).offset(14)
            make.bottom.equalTo(recordImage)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.routeLine.do {
            $0.backgroundColor = .gray01
            $0.isHidden = false
        }
        
        self.moodRectangle.do {
            $0.contentMode = .scaleToFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 6
        }
        
        self.dateLabel.do {
            $0.textColor = .gray01
            $0.font = .body0M
        }
        
        self.recordImage.do {
            $0.contentMode = .scaleAspectFill
        }
        
        self.keywordCollection.do {
            $0.backgroundColor = .customBlack
            $0.isScrollEnabled = false
            let leftAlignedFlowLayout = LeftAlignedCollectionViewFlowLayout(
                minimumLineSpacing: 6,
                minimumInteritemSpacing: 6,
                estimatedItemSize: CGSize(width: 50.0, height: 24.0))
            $0.setCollectionViewLayout(leftAlignedFlowLayout, animated: false)
            $0.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
            $0.dataSource = self
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
    private func configureMoodRect(mood: Int) {
        let moodColors = UIColor.selectGradientColors(by: mood).compactMap{ $0 }
        self.moodRectangle.do { view in
            let gradient = CAGradientLayer()
            gradient.do {
                $0.colors = moodColors.map { $0.cgColor }.compactMap { $0 }
                $0.locations = [0.0, 1.0]
                $0.startPoint = CGPoint(x: 0.0, y: 0.0)
                $0.endPoint = CGPoint(x: 0.0, y: 1.0)
                $0.frame = view.bounds
                $0.cornerRadius = 10.5
            }
            view.layer.addSublayer(gradient)
        }
    }
    
    private func configureRouteLine(isHidden: Bool) {
        routeLine.isHidden = isHidden
    }
    
    func configure<T>(data: T) {
        if let record = data as? Record {
            configureRouteLine(isHidden: record.date.isLastDay)
            configureMoodRect(mood: record.mood)
            
            dateLabel.text = Self.recordDateFormatter.string(from: record.date)
            keywords = record.keyword
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
