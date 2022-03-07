//
//  RecordListCell.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/02.
//

import UIKit.UITableViewCell

final class RecordListCell: UITableViewCell {

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
        
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.routeLine.do {
            $0.backgroundColor = .gray01
            $0.isHidden = false // 말 일 true
        }
        
        self.moodRectangle.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10.5
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            
            let layer = CAGradientLayer().then {
                $0.colors = [] // Color 추가 필요
                $0.locations = [0, 1]
            }
            
            $0.layer.addSublayer(layer)
        }
        
        self.dateLabel.do {
            $0.textColor = .gray01
            $0.font = .body0M
        }
        
        self.recordImage.do {
            $0.contentMode = .scaleAspectFill
        }
        
        self.keywordCollection.do {
            $0.isScrollEnabled = false
            let leftAlignedFlowLayout = LeftAlignedCollectionViewFlowLayout(
                minimumLineSpacing: 6,
                minimumInteritemSpacing: 6,
                estimatedItemSize: CGSize(width: 24.0, height: 50.0))
            $0.setCollectionViewLayout(leftAlignedFlowLayout, animated: false)
            $0.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
            $0.dataSource = self
        }
    }
    
    private let routeLine = UIView(frame: .zero)
    private let moodRectangle = UIView(frame: .zero)

    private var dateLabel = UILabel(frame: .zero)
    private var recordImage = UIImageView(frame: .zero)
    private var keywords: [String] = []
    private let keywordCollection = UICollectionView(frame: .zero,
                                                     collectionViewLayout: UICollectionViewLayout())
}

extension RecordListCell: Configurable {
    func configure<T>(data: T) {
        if let record = data as? Record {
//            moodRectangle  // Color 추가 필요
            dateLabel.text = record.date.description // formmater 필요
            keywords = record.keyword
            DispatchQueue.main.async {
                self.keywordCollection.reloadData()
            }
            
            // 이미지 불러오기 비동기
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
