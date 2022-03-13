//
//  RecordColorChipsCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then

struct RecordColorChipsCellModel {
    let collectionViewCellModels: [RecordColorChipCollectionViewCellModel]
}

final class RecordColorChipsCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: RecordColorChipsCellModel) {
        self.items = model.collectionViewCellModels
        self.collectionView.reloadData()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.contanierView)
        self.contanierView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
            make.height.equalTo(71)
        }
        self.contanierView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 18, left: 20, bottom: 20, right: 18))
            make.height.equalTo(35)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
            $0.selectionStyle = .none
        }
        
        self.contanierView.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .gray06
        }
        
        self.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(self.cellType)
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
    }
    
    private let contanierView = UIView(frame: .zero)
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var items: [RecordColorChipCollectionViewCellModel] = []
    private let cellType = RecordColorChipCollectionViewCell.self
    
    private let cellSize = CGSize(width: 35, height: 35)
}

extension RecordColorChipsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
    
}

extension RecordColorChipsCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.section == 0 else {
            return UICollectionViewCell()
        }
        
        guard let model = self.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(self.cellType, at: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(model: model)
        
        return cell
    }
    
}

