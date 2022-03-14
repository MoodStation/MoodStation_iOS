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
    }
    
    private let viewModel: SettingsViewModel
    private let settingsView = SettingsView(frame: .zero)
}
