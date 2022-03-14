//
//  CrewInfoView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/14.
//

import UIKit

typealias CrewInfoViewDelegate = UITableViewDelegate
typealias CrewInfoViewDataSource = UITableViewDataSource

final class CrewInfoView: UIView {
    
    weak var delegate: CrewInfoViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: CrewInfoViewDataSource? {
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
        self.tableView.do {
            $0.backgroundColor = .customBlack
            $0.selectionFollowsFocus = false
            $0.register(TextOnlyTableViewCell.self)
            $0.register(UserTableViewCell.self)
        }
    }
    
    private let tableView = UITableView(frame: .zero, style: .plain)
}

