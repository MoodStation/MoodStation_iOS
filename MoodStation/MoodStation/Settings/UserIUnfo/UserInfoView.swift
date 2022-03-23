//
//  UserInfoView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/23.
//

import UIKit

protocol UserInfoViewDelegate: UITableViewDelegate {
    
    func userInfoViewUserImageViewDidClick(_ view: UserInfoView)
    func userInfoViewSaveButtonDidClick(_ view: UserInfoView)
    func userInfoViewEditButtonDidClick(_ view: UserInfoView)
    
}

typealias UserInfoViewDataSource = UITableViewDataSource

final class UserInfoView: UIView {
    
    weak var delegate: UserInfoViewDelegate? {
        didSet { self.tableView.delegate = self.delegate }
    }
    
    weak var dataSource: UserInfoViewDataSource? {
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
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        self.addSubview(self.editButton)
        self.editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        self.addSubview(self.userImageView)
        self.userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(117)
        }
        
        self.userImageView.addSubview(self.pencilImageView)
        self.pencilImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        self.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.userImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.emailLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.saveButton.snp.top)
        }
    }
    
    private func setupAttributes() {
        self.saveButton.do {
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .button1SB
            $0.setTitle("저장", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .main
            $0.isHidden = true
            $0.isEnabled = false
            $0.addTarget(self, action: #selector(saveButtonClicked(_:)), for: .touchUpInside)
        }
        
        self.editButton.do {
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .button1SB
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.gray06, for: .normal)
            $0.backgroundColor = .gray01
            $0.addTarget(self, action: #selector(editButtonClicked(_:)), for: .touchUpInside)
        }
        
        self.userImageView.do {
            $0.backgroundColor = .darkGray
            $0.layer.cornerRadius = 50
        }
        
        self.pencilImageView.do {
            $0.backgroundColor = .main
            $0.image = UIImage(named: "icn-pencil")
            $0.layer.cornerRadius = 50
            $0.isHidden = true
        }
        
        self.tableView.do {
            $0.backgroundColor = .customBlack
            $0.selectionFollowsFocus = false
            $0.register(TextOnlyTableViewCell.self)
            $0.register(TextFieldOnlyTableViewCell.self)
        }
    }
    
    @objc private func saveButtonClicked(_ sender: UIButton) {
        self.delegate?.userInfoViewSaveButtonDidClick(self)
        self.pencilImageView.isHidden = true
        
        self.saveButton.isHidden = true
        self.saveButton.isEnabled = false
        
        self.editButton.isHidden = false
        self.editButton.isEnabled = true
    }
    
    @objc private func editButtonClicked(_ sender: UIButton) {
        self.delegate?.userInfoViewEditButtonDidClick(self)
        self.pencilImageView.isHidden = false
        
        self.editButton.isHidden = true
        self.editButton.isEnabled = false
        
        self.saveButton.isHidden = false
        self.saveButton.isEnabled = true
    }
    
    private let userImageView = UIImageView(frame: .zero)
    private let pencilImageView = UIImageView(frame: .zero)
    private let emailLabel = UILabel(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let editButton = UIButton(frame: .zero)
    private let saveButton = UIButton(frame: .zero)
}

