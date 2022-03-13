//
//  UserTableVIewCell.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/12.
//

import UIKit.UITableViewCell

struct UserInfo {
    let name: String
    let email: String
    let userImagePath: String?
}

final class UserTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    private func setupLayout() {
        self.addSubview(self.gradientView)
        self.gradientView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(85)
            make.leading.equalToSuperview().offset(24)
        }
        
        gradientView.addSubview(self.userImageView)
        self.userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(self.nickNameLabel)
        self.nickNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.userImageView.snp.trailing).offset(16)
            make.bottom.equalTo(self.contentView.snp.centerY).offset(-2)
        }
        
        self.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.userImageView.snp.trailing).offset(16)
            make.top.equalTo(self.contentView.snp.centerY).offset(2)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .customBlack
        }
        
        self.gradientView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 42.5
            $0.drawGradientUserInfo()
        }
        
        self.userImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 42.5
            $0.backgroundColor = .clear
            $0.contentMode = .scaleAspectFit
        }
        
        self.nickNameLabel.do {
            $0.textColor = .gray01
            $0.font = .h5SB
        }
        
        self.emailLabel.do {
            $0.textColor = .gray03
            $0.font = .body3R
        }
    }
    
    private let gradientView = UIView(frame: .zero)
    private let userImageView = UIImageView(frame: .zero)
    private let nickNameLabel = UILabel(frame: .zero)
    private let emailLabel = UILabel(frame: .zero)
}

extension UserTableViewCell: Configurable {
    func configure<T>(data: T) {
        if let user = data as? UserInfo {
            nickNameLabel.text = user.name
            emailLabel.text = user.email
            guard let imagePath = user.userImagePath else { return }
            if let url = URL(string: imagePath) {
                userImageView.kf.setImage(with: url)
            } else if let assetImage = UIImage(named: imagePath) {
                userImageView.image = assetImage
            }
        }
    }
}


