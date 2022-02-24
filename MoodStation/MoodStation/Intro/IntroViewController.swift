//
//  IntroViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/24.
//

import UIKit
import SnapKit
import Then

final class IntroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    private func setupLayout() {
        self.view.addSubview(self.skipButton)
        self.skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.skipButton.snp.bottom).offset(69)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(26)
        }
        
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(327)
            make.height.equalTo(293)
        }
        
        self.view.addSubview(self.signInButton)
        self.signInButton.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        self.view.addSubview(self.signUpButton)
        self.signUpButton.snp.makeConstraints { make in
            make.top.equalTo(self.signInButton.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    private func setupAttributes() {
        self.skipButton.do {
            $0.setTitle("건너뛰기", for: .normal)
            $0.setTitleColor(.gray01, for: .normal)
            $0.titleLabel?.font = .button2M
            $0.addTarget(self, action: #selector(skipButtonDidTap(_:)), for: .touchUpInside)
        }
        
        self.titleLabel.do {
            $0.text = "오늘은 어떤 역을 지나치셨나요?"
            $0.textColor = .customWhtie
            $0.textAlignment = .center
            $0.font = .h2SB
        }
        
        self.descriptionLabel.do {
            $0.text = "당신의 하루를 기록해 보세요."
            $0.textColor = .customWhtie
            $0.textAlignment = .center
            $0.font = .body1R
        }
        
        self.imageView.do {
            // TODO: - 디자인 확정되면 변경
            $0.backgroundColor = .gray02
        }
        
        self.signInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.gray06, for: .normal)
            $0.backgroundColor = .gray01
            $0.titleLabel?.font = .button1SB
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(signInButtonDidTap(_:)), for: .touchUpInside)
        }
        
        self.signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.customWhtie, for: .normal)
            $0.backgroundColor = .main
            $0.titleLabel?.font = .button1SB
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(signUpButtonDidTap(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc private func skipButtonDidTap(_ sender: UIButton) {
        // TODO: - 로그인 안하고 GO TO Main View
    }
    
    @objc private func signInButtonDidTap(_ sender: UIButton) {
        // TODO: - GO TO SignIn View
    }
    
    @objc private func signUpButtonDidTap(_ sender: UIButton) {
        // TODO: - GO TO SignUp View
    }
    
    private let skipButton = UIButton(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let descriptionLabel = UILabel(frame: .zero)
    
    private let imageView = UIImageView(frame: .zero)
    
    private let signInButton = UIButton(frame: .zero)
    private let signUpButton = UIButton(frame: .zero)
}
