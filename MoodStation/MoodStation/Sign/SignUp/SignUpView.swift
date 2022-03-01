//
//  SignUpView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit
import SnapKit
import Then

final class SignUpView: UIView {
    
    
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
        
        self.addSubview(self.nickNameLabel)
        self.nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.subTitleLabel.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        self.addSubview(self.nickNameTextField)
        self.nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.nickNameLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        
        self.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nickNameTextField.snp.bottom).offset(36)
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
        
        self.addSubview(self.confirmPasswordTextField)
        self.confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.confirmPasswordTextField.snp.bottom).offset(14)
            make.leading.trailing.equalTo(24)
            make.height.equalTo(16)
        }
        
        self.addSubview(self.signUpButton)
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(self.confirmPasswordTextField.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.titleLabel.do {
            $0.text = "회원가입"
            $0.font = .h1B
            $0.textColor = .customWhtie
        }
        
        self.subTitleLabel.do {
            $0.text = "~에 회원가입하고\n간편하게 하루를 기록해 보세요."
            $0.numberOfLines = 2
            $0.font = .body1R
            $0.textColor = .customWhtie
        }
        
        self.nickNameLabel.do {
            $0.text = "닉네임"
            $0.font = .body0M
            $0.textColor = .customWhtie
        }
        
        self.nickNameTextField.do {
            $0.placeholder = "닉네임을 입력해 주세요."
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
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
        }
        
        self.confirmPasswordTextField.do {
            $0.placeholder = "비밀번호를 확인해 주세요."
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
        }
        
        self.descriptionLabel.do {
            $0.text = "비밀번호 조건 어쩌구 저쩌구" // TODO
            $0.font = .caption1M
            $0.textColor = .gray02
        }
        
        self.signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.customWhtie, for: .normal)
            $0.backgroundColor = .main
            $0.layer.cornerRadius = 10
        }
        
    }
    
    private let titleLabel = UILabel(frame: .zero)
    private let subTitleLabel = UILabel(frame: .zero)
    
    private let nickNameLabel = UILabel(frame: .zero)
    private let nickNameTextField = UITextField(frame: .zero)
    
    private let emailLabel = UILabel(frame: .zero)
    private let emailTextField = UITextField(frame: .zero)
    
    private let passwordLabel = UILabel(frame: .zero)
    private let passwordTextField = UITextField(frame: .zero)
    private let confirmPasswordTextField = UITextField(frame: .zero)
    
    private let descriptionLabel = UILabel(frame: .zero)
    
    private let signUpButton = UIButton(frame: .zero)
    
}
