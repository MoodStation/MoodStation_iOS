//
//  AlertView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/15.
//

import UIKit

final class AlertView: UIView {
    typealias ConfirmAction = () -> ()
    
    enum AlertStyle {
        case confirm
    }
    
    convenience init(title: String, detail: String, imageName: String, confirm: String = "확인", style: AlertStyle, confirmAction: @escaping () -> Void) {
        self.init(frame: UIScreen.main.bounds)
        
        self.titleLabel.text = title
        self.detailLabel.text = detail
        self.logoImageView.image = UIImage(named: imageName)
        self.confirmButton.setTitle(confirm, for: .normal)
        self.confirmAction = confirmAction
    }
    
    convenience init(title: String, detail: String, imageName: String, confirm: String = "확인", style: AlertStyle) {
        self.init(frame: UIScreen.main.bounds)
        
        self.titleLabel.text = title
        self.detailLabel.text = detail
        self.logoImageView.image = UIImage(named: imageName)
        self.confirmButton.setTitle(confirm, for: .normal)
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
        self.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(88)
            make.trailing.equalToSuperview().offset(-88)
            make.height.equalTo(142)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(self.detailLabel)
        self.detailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.detailLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(139)
            make.height.equalTo(48)
        }
        
        self.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { make in
            make.top.equalTo(self.detailLabel.snp.bottom).offset(24)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(139)
            make.height.equalTo(48)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.frame.origin = CGPoint(x: self.center.x, y: self.center.y)
            $0.frame.size = CGSize(width: 327, height: 320)
            $0.backgroundColor = .gray06
        }
    }
    
    func show(from rootViewController: UIViewController) {
        rootViewController.view.addSubview(self)
        self.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(320)
        }
        
        rootViewController.view.subviews.forEach {
            if $0 != self {
                $0.alpha = 0.6
            }
        }
    }
    
    func delegateConfirmAction(completed: @escaping () -> Void) {
        self.confirmAction = completed
    }
    
    @objc private func cancelButtonDidTap(_ sender: UIButton) {
        self.removeAlert()
    }
    
    @objc private func confirmButtonDidTap(_ sender: UIButton) {
        self.removeAlert()
        self.confirmAction?()
    }
    
    private func removeAlert() {
        self.superview?.subviews.forEach { $0.alpha = 1 }
        self.removeFromSuperview()
    }
    
    private let logoImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero).then {
        $0.font = .h4SB
        $0.textColor = .white
        $0.textAlignment = .center
    }
    private let detailLabel = UILabel(frame: .zero).then {
        $0.font = .body1R
        $0.textColor = .white
        $0.textAlignment = .center
    }
    private let cancelButton = UIButton(frame: .zero).then {
        $0.titleLabel?.font = .button1SB
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.gray06, for: .normal)
        $0.backgroundColor = .gray01
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(cancelButtonDidTap(_:)), for: .touchUpInside)
    }
    private let confirmButton = UIButton(frame: .zero).then {
        $0.titleLabel?.font = .button1SB
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(confirmButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var confirmAction: ConfirmAction?
}
