//
//  HomeViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

typealias HomeViewDelegate = UITableViewDelegate
typealias HomeViewDataSource = UITableViewDataSource

final class HomeViewController: UIViewController {
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.recordListView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    
    private func setupLayout() {
        self.view.addSubview(self.recordListView)
        recordListView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func setupAttributes() {
        recordListView.do {
            $0.backgroundColor = .customBlack
            $0.separatorStyle = .none
            $0.register(RecordListCell.self, forCellReuseIdentifier: RecordListCell.className)
        }
    }
    
    private let viewModel: HomeViewModel
    private let recordListView: UITableView
}

extension HomeViewController: HomeViewDelegate {
    
}

extension HomeViewController: HomeViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecordListHeaderView.className) as? RecordListHeaderView else {
            return UITableViewHeaderFooterView()
        }
        let headerData = viewModel.headerData(at: section)
        headerView.configure(data: headerData)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.cellModel(at: indexPath)
        
        switch cellModel {
        case .record(let record):
            guard let cell = tableView.dequeueReusableCell(RecordListCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(data: record)
            return cell
        case .empty(let emptyCellModel):
            guard let cell = tableView.dequeueReusableCell(RecordListEmptyCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(data: emptyCellModel)
            return cell
        }
    }
}
