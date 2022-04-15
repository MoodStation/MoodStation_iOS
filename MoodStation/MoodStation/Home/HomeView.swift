//
//  HomeView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/14.
//

import UIKit

typealias HomeViewDelegate = UITableViewDelegate
typealias HomeViewDataSource = UITableViewDataSource

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: HomeViewDataSource? {
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
            make.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func setupAttributes() {
        self.tableView.do {
            $0.backgroundColor = .customBlack
            $0.separatorStyle = .none
            $0.register(RecordListCell.self)
        }
    }
    
    private let tableView = UITableView(frame: .zero, style: .plain)
}
