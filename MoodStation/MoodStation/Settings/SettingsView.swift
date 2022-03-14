//
//  SettingsView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/14.
//

import UIKit

typealias SettingsViewDataSource = UITableViewDataSource
typealias SettingsViewDelegate = UITableViewDelegate

final class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: SettingsViewDataSource? {
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
            $0.separatorStyle = .singleLine
            $0.backgroundColor = .customBlack
        }
    }
    
    private let tableView = UITableView(frame: .zero, style: .plain)
}
