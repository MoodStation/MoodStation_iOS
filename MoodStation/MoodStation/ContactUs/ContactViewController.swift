//
//  ContactViewController.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/14.
//

import UIKit

final class ContactViewController: UIViewController {
    
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
        
        self.view.addSubview(self.contactView)
        self.contactView.snp.makeConstraints { make in
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
    }
    
    private let navigationView = NavigationView(frame: .zero)
    private let contactView = ContactView(frame: .zero)
}

extension ContactViewController: NavigationViewDelegate {
    
    func navigationViewDeleagteDidClickLeftButton(_ view: NavigationView) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - ContactView
final class ContactView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(136)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(208)
        }
        
        self.addSubview(self.guideLabel)
        self.guideLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.logoImageView.do {
            $0.backgroundColor = .gray
        }
        
        self.guideLabel.do {
            $0.font = .body1R
            $0.textColor = .gray01
            $0.text = "무드스테이션을 이용하며\n문의하고 싶은 점들을 이메일로 보내주세요!"
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        
        self.emailLabel.do {
            $0.font = .body1R
            $0.textColor = .gray02
            $0.text = "moodstation@gmail.com"
        }
    }
    
    private let logoImageView = UIImageView(frame: .zero)
    private let guideLabel = UILabel(frame: .zero)
    private let emailLabel = UILabel(frame: .zero)
}

