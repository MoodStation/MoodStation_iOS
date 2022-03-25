//
//  SettingsViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    enum Settings: CustomStringConvertible {
        case contact
        case crewInfo
        case logout
        case deleteAcount
        
        var description: String {
            switch self {
            case .contact:      return "문의하기"
            case .crewInfo:     return "무드스테이션 팀원들"
            case .logout:       return "로그아웃"
            case .deleteAcount: return "탈퇴하기"
            }
        }
    }
    
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
        case .user(let userInfo):
            if let user = userInfo {
                let userInfoViewModel = UserInfoViewModel(userInfo: user)
                let viewController = UserInfoViewController(viewModel: userInfoViewModel).then {
                    $0.hidesBottomBarWhenPushed = true
                }
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                print("로그아웃")
            }
        case .cell(let setting):
            switch setting {
            case .contact:      self.pushContactViewController()
            case .crewInfo:     self.pushCrewInfoViewController()
            case .logout:       print(setting.description)
            case .deleteAcount: print(setting.description)
            }
        }
    }
    
    private func pushCrewInfoViewController() {
        let viewModel = CrewInfoViewModel()
        let viewController = CrewInfoViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func pushContactViewController() {
        let viewController = ContactViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
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
            guard let cell = tableView.dequeueReusableCell(TextOnlyTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: textOnlyTableViewCellModel)
            return cell
        case .user(let userInfo):
            guard let cell = tableView.dequeueReusableCell(UserTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.setAccessary(isHidden: false)
            cell.configure(data: userInfo)
            return cell
        case .cell(let type):
            guard let cell = tableView.dequeueReusableCell(SettingsListViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.setAccessary(isHidden: false)
            cell.configure(data: type.description)
            return cell
        }
    }
}
