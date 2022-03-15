//
//  HomeViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.view.addSubview(self.homeView)
        self.homeView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.view.do {
            $0.backgroundColor = .customBlack
        }
        
        self.navigationView.do {
            $0.delegate = self
            $0.configure(type: .main)
        }
        
        self.homeView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    private let navigationView = NavigationView(frame: .zero)
    private let homeView = HomeView(frame: .zero)
    private let viewModel: HomeViewModel
}

extension HomeViewController: HomeViewDelegate {
    
}

extension HomeViewController: HomeViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = viewModel.headerModel(at: section) else {
            return UITableViewHeaderFooterView()
        }
        switch model {
        case .date(let date):
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecordListHeaderView.className) as? RecordListHeaderView else {
                return UITableViewHeaderFooterView()
            }
            headerView.configure(data: date)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.cellModel(at: indexPath) else {
            return UITableViewCell()
        }
        
        switch model {
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

extension HomeViewController: NavigationViewDelegate {
    
}
