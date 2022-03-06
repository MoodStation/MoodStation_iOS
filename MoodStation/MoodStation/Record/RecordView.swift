//
//  RecordView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then

typealias RecordViewDelegate = UITableViewDelegate
typealias RecordViewDataSource = UITableViewDataSource

final class RecordView: UIView {
    
    weak var delegate: RecordViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: RecordViewDataSource? {
        didSet { self.tableView.dataSource = self.dataSource }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.backgroundColor = .customBlack
        
        self.tableView.do {
            $0.backgroundColor = .customBlack
            $0.separatorStyle = .none
            $0.register(TextOnlyTableViewCell.self)
            $0.register(RecordColorChipsCell.self)
            $0.register(RecordKeywordChipCell.self)
            $0.register(RecordImageViewCell.self)
            $0.register(RecordSingleRecordingCell.self)
            // TODO: - Register CalendarCell
        }
    }
    
    private let tableView = UITableView(frame: .zero)
    
}

