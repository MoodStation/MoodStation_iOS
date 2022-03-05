//
//  SignInView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit
import SnapKit
import Then

protocol SignInViewDelegate: UITableViewDelegate {
    
    func signInViewSignInButtonDidClick(_ view: SignInView)
    func signInViewfindButtonDidClick(_ view: SignInView)
}

typealias SignInViewDataSource = UITableViewDataSource

final class SignInView: UIView {
    
    weak var delegate: SignInViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: SignInViewDataSource? {
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
        self.addSubview(self.findButton)
        self.findButton.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(self.signInButton)
        self.signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.bottom.equalTo(self.findButton.snp.top).offset(-11)
        }
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.signInButton.snp.top)//.offset(-20)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.tableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .customBlack
            $0.register(TextOnlyTableViewCell.self)
            $0.register(TextFieldOnlyTableViewCell.self)
        }
        
        self.signInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.font = .button1SB
            $0.backgroundColor = .main
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(signInButtonClicked(_:)), for: .touchUpInside)
        }
        
        self.findButton.do {
            $0.setTitle("이메일/비밀번호 찾기", for: .normal)
            $0.titleLabel?.font = .caption2R
            $0.setTitleColor(.gray02, for: .normal)
            $0.addTarget(self, action: #selector(findButtonClicked(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func signInButtonClicked(_ sender: UIButton) {
        self.delegate?.signInViewSignInButtonDidClick(self)
    }
    
    @objc private func findButtonClicked(_ sender: UIButton) {
        self.delegate?.signInViewfindButtonDidClick(self)
    }
    
    private let tableView = UITableView(frame: .zero)
    private let signInButton = UIButton(frame: .zero)
    private let findButton = UIButton(frame: .zero)
    
}
