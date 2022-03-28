//
//  SettingsListViewCell.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/14.
//

import UIKit

final class SettingsListViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(24)
        }
        
        self.contentView.addSubview(self.settingLabel)
        self.settingLabel.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.equalTo(self.logoImageView.snp.trailing).offset(15)
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
        
        self.settingLabel.do {
            $0.font = .body1R
            $0.textColor = .gray01
        }
        
        self.disclosureIndicator.do {
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
            $0.image = UIImage(named: "icn-arrow_right")
        }
    }
    
    private let logoImageView = UIImageView(frame: .zero)
    private let settingLabel = UILabel(frame: .zero)
    private let disclosureIndicator = UIImageView(frame: .zero)
}

extension SettingsListViewCell: Configurable {
    func configure<T>(data: T) {
        if let setting = data as? SettingsViewController.Settings {
            self.settingLabel.text = setting.description
            self.logoImageView.image = UIImage(named: setting.imageName)
        }
    }
    
    func setAccessary(isHidden: Bool) {
        disclosureIndicator.isHidden = isHidden
    }
}
