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
    }
    
    private let viewModel: SettingsViewModel
    private let settingsView = SettingsView(frame: .zero)
}
