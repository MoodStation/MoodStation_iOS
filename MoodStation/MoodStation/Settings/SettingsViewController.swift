//
//  SettingsViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    init(viewModel: SettingsViewModel) {
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
        self.view.addSubview(self.settingsView)
        self.settingsView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setupAttributes() {
        self.view.do {
            $0.backgroundColor = .customBlack
        }
        
        self.settingsView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    private let viewModel: SettingsViewModel
    private let settingsView = SettingsView(frame: .zero)
}
extension SettingsViewController: SettingsViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRowAt(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = self.viewModel.didSelectRowAt(at: indexPath) else {
            return
        }
        switch item {
        case .text(_): break
        case .user(let user):
            self.setUserCellPushViewController(by: user)
        case .cell(let settings):
            switch settings {
            case .alert(let info):
                self.setAlertCell(by: info)
            case .navigation(let move):
                self.setNavigationCellPushViewController(by: move)
            }
        }
    }
    
    private func setUserCellPushViewController(by user: User?) {
        if let user = user {
            let userDetailViewModel = UserDetailViewModelImpl(user: user)
            let viewController = UserDetailViewController(viewModel: userDetailViewModel).then {
                $0.hidesBottomBarWhenPushed = true
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("비 로그인 상태")
        }
    }
    
    private func setNavigationCellPushViewController(by move: SettingsViewModelImpl.Settings.Navigation) {
        switch move {
        case .contact:
            self.pushContactViewController()
        case .crewInfo:
            self.pushCrewInfoViewController()
        }
    }
    
    private func pushCrewInfoViewController() {
        let viewModel = CrewInfoViewModelImpl()
        let viewController = CrewInfoViewController(viewModel: viewModel).then {
            $0.hidesBottomBarWhenPushed = true
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func pushContactViewController() {
        let viewController = ContactViewController().then {
            $0.hidesBottomBarWhenPushed = true
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setAlertCell(by info: SettingsViewModelImpl.Settings.Alert) {
        guard let alert = self.viewModel.makeAlert(info) else { return }
        switch info {
        case .logIn:
            alert.delegateConfirmAction {
                self.pushLogInViewController()
            }
        case .logOut:
            alert.delegateConfirmAction {
                self.logOut()
            }
        case .deleteAcount:
            alert.delegateConfirmAction {
                self.deleteAcount()
            }
        }
        alert.show(from: self)
    }
    
    private func pushLogInViewController() {
        print(#function)
    }
    
    private func logOut() {
        print(#function)
    }
    
    private func deleteAcount() {
        print(#function)
    }
}

extension SettingsViewController: SettingsViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel.cellModel(at: indexPath) else {
            return UITableViewCell()
        }
        
        
        switch model {
        case .text(let textOnlyTableViewCellModel):
            guard let cell = tableView.dequeueReusableCell(TextOnlyTableViewCell.self, at: indexPath) else { return UITableViewCell() }
            cell.configure(model: textOnlyTableViewCellModel)
            return cell
        case .user(let userTableViewCellModel):
            guard let cell = tableView.dequeueReusableCell(UserTableViewCell.self, at: indexPath) else { return UITableViewCell() }
            cell.configure(model: userTableViewCellModel)
            cell.setAccessary(isHidden: false)
            return cell
        case .cell(let settingsListViewCellModel):
            guard let cell = tableView.dequeueReusableCell(SettingsListViewCell.self, at: indexPath) else { return UITableViewCell()
            }
            cell.configure(model: settingsListViewCellModel)
            cell.setAccessary(isHidden: false)
            return cell
        }
    }
}
