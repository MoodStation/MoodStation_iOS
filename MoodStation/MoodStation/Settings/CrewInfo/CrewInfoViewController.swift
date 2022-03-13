//
//  CrewInfoViewController.swift
//  TestProject
//
//  Created by Yongwoo Marco on 2022/03/12.
//

import UIKit

final class CrewInfoViewController: UIViewController {
    
    init(viewModel: CrewInfoViewModel) {
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
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        
    }

    private let viewModel: CrewInfoViewModel
    private let tableView = UITableView(frame: .zero, style: .plain)
}
