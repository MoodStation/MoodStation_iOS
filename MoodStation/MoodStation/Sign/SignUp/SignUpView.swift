//
//  SignUpView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit
import SnapKit
import Then

typealias SignUpViewDelegate = UITableViewDelegate
typealias SignUpViewDataSource = UITableViewDataSource

final class SignUpView: UIView {
    
    weak var delegate: SignUpViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: SignUpViewDataSource? {
        didSet { self.tableView.dataSource = self.dataSource }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.signUpButton)
        self.signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.signUpButton.snp.top)//.offset(-20)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.tableView.do {
            $0.backgroundColor = .customBlack
            $0.separatorStyle = .none
            $0.register(TextOnlyTableViewCell.self)
            $0.register(TextFieldOnlyTableViewCell.self)
        }
        
        self.signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.customWhtie, for: .normal)
            $0.titleLabel?.font = .button1SB
            $0.backgroundColor = .main
            $0.layer.cornerRadius = 10
        }
        
    }
    
    private let tableView = UITableView(frame: .zero)
    private let signUpButton = UIButton(frame: .zero)
    
}
