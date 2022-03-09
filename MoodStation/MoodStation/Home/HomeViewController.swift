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
