//
//  SignInView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit
import SnapKit
import Then

protocol SignInViewDelegate: AnyObject {
    
    func signInViewDidChangeEmailText(_ view: SignInView)
    func signInViewDidChangePasswordText(_ view: SignInView)
    func signInViewDidTapSignIn(_ view: SignInView)
    
}

final class SignInView: UIView {
    
    #warning("Custom TextField 생성해서 TextField 에 적용")
    
    weak var delegate: SignInViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(47)
        }
        
        self.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(42)
        }
        
        self.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.subTitleLabel.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        self.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        
        self.addSubview(self.passwordLabel)
        self.passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        self.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(16)
        }
        
        self.addSubview(self.signInButton)
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        self.addSubview(self.findButton)
        self.findButton.snp.makeConstraints { make in
            make.top.equalTo(self.signInButton.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.titleLabel.do {
            $0.text = "로그인"
            $0.font = .h1B
            $0.textColor = .customWhtie
        }
        
        self.subTitleLabel.do {
            $0.text = "~에 로그인하고\n기록을 이어나가 보세요."
            $0.numberOfLines = 2
            $0.font = .body1R
            $0.textColor = .customWhtie
        }
        
        self.emailLabel.do {
            $0.text = "이메일"
            $0.font = .body0M
            $0.textColor = .customWhtie
        }
        
        self.emailTextField.do {
            $0.placeholder = "이메일을 입력해 주세요."
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(emailTextFieldDidChangeText(_:)), for: .editingChanged)
        }
        
        self.passwordLabel.do {
            $0.text = "비밀번호"
            $0.font = .body0M
            $0.textColor = .customWhtie
        }
        
        self.passwordTextField.do {
            $0.placeholder = "비밀번호를 입력해 주세요."
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(passwordTextFieldDidChangeText(_:)), for: .editingChanged)
        }
        
        self.descriptionLabel.do {
            $0.text = "이메일 또는 비밀번호를 확인해 주세요." // 나중에 변경될 수 있을 듯
            $0.font = .caption1M
            $0.textColor = .error
        }
        
        self.signInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.customWhtie, for: .normal)
            $0.backgroundColor = .main
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(signInButtonDidTap(_:)), for: .touchUpInside)
        }
        
        self.findButton.do {
            $0.setTitle("이메일/비밀번호 찾기", for: .normal)
            $0.setTitleColor(.gray02, for: .normal)
            $0.titleLabel?.font = .caption2R
        }
    }
    
    @objc private func emailTextFieldDidChangeText(_ sender: UITextField) {
        self.delegate?.signInViewDidChangeEmailText(self)
    }
    
    @objc private func passwordTextFieldDidChangeText(_ sender: UITextField) {
        self.delegate?.signInViewDidChangePasswordText(self)
    }
    
    @objc private func signInButtonDidTap(_ sender: UIButton) {
        self.delegate?.signInViewDidTapSignIn(self)
    }
    
    private let titleLabel = UILabel(frame: .zero)
    private let subTitleLabel = UILabel(frame: .zero)
    
    private let emailLabel = UILabel(frame: .zero)
    private let emailTextField = UITextField(frame: .zero)
    
    private let passwordLabel = UILabel(frame: .zero)
    private let passwordTextField = UITextField(frame: .zero)
    
    private let descriptionLabel = UILabel(frame: .zero)
    
    private let signInButton = UIButton(frame: .zero)
    
    private let findButton = UIButton(frame: .zero)
    
}
