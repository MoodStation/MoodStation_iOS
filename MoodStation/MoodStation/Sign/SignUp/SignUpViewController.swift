//
//  SignUpViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit
import SnapKit
import Then

final class SignUpViewController: UIViewController {
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    private func setupLayout() {
        self.view.addSubview(self.signUpView)
        
        self.signUpView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    private func setupAttributes() {
        self.view.do {
            $0.backgroundColor = .customBlack
        }
        
    }
    
    
    private let viewModel: SignUpViewModel
    
    private let signUpView = SignUpView()
    
}
