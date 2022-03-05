//
//  NavigationView.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/05.
//

import UIKit
import SnapKit
import Then

enum NavigationType {
    
    case main
    case back
    case share
    
}


protocol NavigationViewDelegate: AnyObject {
    
    func navigationViewDeleagteDidClickLeftButton(_ view: NavigationView)
    func navigationViewDelegateDidClickCenterButton(_ view: NavigationView)
    func navigationViewDelegateDidClickRightButton(_ view: NavigationView)
    
}

extension NavigationViewDelegate {
    
    func navigationViewDeleagteDidClickLeftButton(_ view: NavigationView) {}
    func navigationViewDelegateDidClickCenterButton(_ view: NavigationView) {}
    func navigationViewDelegateDidClickRightButton(_ view: NavigationView) {}
    
}

final class NavigationView: UIView {
    
    weak var delegate: NavigationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: NavigationType) {
        switch type {
        case .main:
            return
        case .back:
            self.leftButton.setImage(UIImage(named: "icn-arrow_left_big")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.centerButton.setImage(nil, for: .normal)
            self.rightButton.setImage(nil, for: .normal)
        case .share:
            return
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        
        self.addSubview(self.centerButton)
        self.centerButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setupAttributes() {
        self.backgroundColor = .clear
        
        self.leftButton.do {
            $0.tintColor = .customWhtie
            $0.contentMode = .center
            $0.addTarget(self, action: #selector(leftButtonDidClick(_:)), for: .touchUpInside)
        }
        
        self.centerButton.do {
            $0.tintColor = .customWhtie
            $0.contentMode = .center
            $0.addTarget(self, action: #selector(centerButtonDidClick(_:)), for: .touchUpInside)
        }
        
        self.rightButton.do {
            $0.tintColor = .customWhtie
            $0.contentMode = .center
            $0.addTarget(self, action: #selector(rightButtonDidClick(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func leftButtonDidClick(_ sender: UIButton) {
        self.delegate?.navigationViewDeleagteDidClickLeftButton(self)
    }
    
    @objc private func centerButtonDidClick(_ sender: UIButton) {
        self.delegate?.navigationViewDelegateDidClickCenterButton(self)
    }
    
    @objc private func rightButtonDidClick(_ sedner: UIButton) {
        self.delegate?.navigationViewDelegateDidClickRightButton(self)
    }
    
    private let leftButton = UIButton(frame: .zero)
    private let centerButton = UIButton(frame: .zero)
    private let rightButton = UIButton(frame: .zero)
    
}
