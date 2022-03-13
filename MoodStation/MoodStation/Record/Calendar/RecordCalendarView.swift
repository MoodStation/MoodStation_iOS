//
//  RecordCalendarView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/12.
//

import UIKit
import SnapKit
import Then

protocol RecordCalendarViewDelegate: UICollectionViewDelegateFlowLayout {
    
    func recordCalendarViewLeftButtonDidClick(_ view: RecordCalendarView)
    func recordCalendarViewRightButtonDidClick(_ view: RecordCalendarView)
    
}

typealias RecordCalendarViewDataSource = UICollectionViewDataSource

final class RecordCalendarView: UIView {
    
    weak var delegate: RecordCalendarViewDelegate? {
        didSet { self.collectionView.delegate = self.delegate }
    }
    
    weak var dataSource: RecordCalendarViewDataSource? {
        didSet { self.collectionView.dataSource = self.dataSource }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    private func setupLayout() {
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
        }
        
        self.addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.dateLabel.snp.leading).offset(-36)
            make.centerY.equalTo(self.dateLabel)
        }

        self.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints { make in
            make.leading.equalTo(self.dateLabel.snp.trailing).offset(36)
            make.centerY.equalTo(self.dateLabel)
        }
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(280)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
        }
        
        self.dateLabel.do {
            $0.font = .h5SB
            $0.textColor = .customWhtie
            $0.text = "Feburary 2022"
        }
        
        self.leftButton.do {
            $0.setImage(UIImage(named: "left_vector")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .customWhtie
            $0.addTarget(self, action: #selector(leftButtonClicked(_:)), for: .touchUpInside)
        }
        
        self.rightButton.do {
            $0.setImage(UIImage(named: "right_vector")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .customWhtie
            $0.addTarget(self, action: #selector(rightButtonClicked(_:)), for: .touchUpInside)
        }
        
        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.register(RecordCalendarWeeklyCollectionCell.self)
            $0.register(RecordCalendarDayCollectionViewCell.self)
        }
    }
    
    @objc private func leftButtonClicked(_ sender: UIButton) {
        self.delegate?.recordCalendarViewLeftButtonDidClick(self)
    }
    
    @objc private func rightButtonClicked(_ sender: UIButton) {
        self.delegate?.recordCalendarViewRightButtonDidClick(self)
    }
    
    private let dateLabel = UILabel(frame: .zero)
    private let leftButton = UIButton(frame: .zero)
    private let rightButton = UIButton(frame: .zero)
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
}
