//
//  UserDetailViewController.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/23.
//

import UIKit

final class UserDetailViewController: UIViewController {
    
    init(viewModel: UserDetailViewModel) {
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
        
        self.view.addSubview(self.userDetailView)
        self.userDetailView.snp.makeConstraints { make in
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
            $0.configure(type: .back)
        }
        
        self.userDetailView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private let navigationView = NavigationView(frame: .zero)
    private let userDetailView = UserDetailView(frame: .zero)
    private let viewModel: UserDetailViewModel
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailUserImageViewDidClick(_ view: UserDetailView) {
        print("이미지 클릭")
    }

    func userDetailSaveButtonDidClick(_ view: UserDetailView) {
        print("저장")
    }
    
    func userDetailEditButtonDidClick(_ view: UserDetailView) {
        print("수정")
    }

}

extension UserDetailViewController: UserDetailViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel.cellModel(at: indexPath) else {
            return UITableViewCell()
        }
        
        switch model {
        case .text(let textOnlyTableViewCellModel):
            guard let cell = tableView.dequeueReusableCell(TextOnlyTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: textOnlyTableViewCellModel)
            return cell
            
        case .textField(let textFieldOnlyTableViewCellModel):
            guard let cell = tableView.dequeueReusableCell(TextFieldOnlyTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: textFieldOnlyTableViewCellModel)
            return cell
        }
    }
    
}

extension UserDetailViewController: NavigationViewDelegate {
    
    func navigationViewDeleagteDidClickLeftButton(_ view: NavigationView) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

