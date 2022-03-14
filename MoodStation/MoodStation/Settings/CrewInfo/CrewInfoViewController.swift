//
//  CrewInfoViewController.swift
//  MoodStation
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
        self.view.addSubview(self.crewInfoView)
        crewInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.crewInfoView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }

    private let viewModel: CrewInfoViewModel
    private let crewInfoView = CrewInfoView(frame: .zero)
}

extension CrewInfoViewController: CrewInfoViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellHeight(at: indexPath)
    }
}

extension CrewInfoViewController: CrewInfoViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.viewModel.cellModel(at: indexPath)
        
        switch model {
        case .text(let textOnlyTableViewCellModel):
            guard let cell = tableView.dequeueReusableCell(TextOnlyTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: textOnlyTableViewCellModel)
            return cell
        case .cell(let userInfoModel):
            guard let cell = tableView.dequeueReusableCell(UserTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(data: userInfoModel)
            return cell
        }
    }
}
