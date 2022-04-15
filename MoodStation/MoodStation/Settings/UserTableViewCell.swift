//
//  UserTableVIewCell.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/12.
//

import UIKit.UITableViewCell

final class UserTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.gradientView)
        self.gradientView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(85)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.gradientView.addSubview(self.userImageView)
        self.userImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(self.nickNameLabel)
        self.nickNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.userImageView.snp.trailing).offset(16)
            make.bottom.equalTo(self.contentView.snp.centerY).offset(-2)
        }
        
        self.contentView.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.userImageView.snp.trailing).offset(16)
            make.top.equalTo(self.contentView.snp.centerY).offset(2)
        }
        
        self.contentView.addSubview(self.disclosureIndicator)
        self.disclosureIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-33.5)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.selectionStyle = .none
            $0.backgroundColor = .clear
        }
        
        self.contentView.do {
            $0.backgroundColor = .customBlack
        }
        
        self.userImageView.do {
            $0.backgroundColor = .gray
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
        
        self.disclosureIndicator.do {
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
            $0.image = UIImage(named: "icn-arrow_right")
        }
    }
    
    private let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 85, height: 85)).then { view in
        view.clipsToBounds = true
        let gradient = CAGradientLayer().then {
            $0.colors = UIColor.crewInfo.compactMap { $0?.cgColor }
            $0.type = .radial
            $0.startPoint = CGPoint(x: 0.5, y: 0.5)
            $0.endPoint = CGPoint(x: 1.0, y: 1.0)
            $0.frame = view.bounds
            $0.cornerRadius = 42.5
        }
        view.layer.addSublayer(gradient)
    }
    private let userImageView = UIImageView(frame: .zero)
    private let nickNameLabel = UILabel(frame: .zero)
    private let emailLabel = UILabel(frame: .zero)
    private let disclosureIndicator = UIImageView(frame: .zero)
}

extension UserTableViewCell: Configurable {
    func configure<T>(data: T) {
        if let user = data as? User {
            self.nickNameLabel.text = user.name
            self.emailLabel.text = user.email
            guard let imagePath = user.userImagePath else {
                return
            }
            if let url = URL(string: imagePath) {
                userImageView.kf.setImage(with: url)
            } else if let assetImage = UIImage(named: imagePath) {
                userImageView.image = assetImage
            }
        } else {
            self.nickNameLabel.text = "로그인·회원가입"
            self.emailLabel.text = "로그인 후 더 많은 기능을 사용해보세요."
        }
    }
    
    func setAccessary(isHidden: Bool) {
        disclosureIndicator.isHidden = isHidden
    }
}


