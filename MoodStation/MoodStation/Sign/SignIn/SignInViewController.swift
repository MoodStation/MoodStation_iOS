//
//  SignInViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/01.
//

import UIKit
import SnapKit
import Then

final class SignInViewController: UIViewController {
    
    init(viewModel: SignInViewModel) {
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
        self.view.addSubview(self.signInView)
        self.signInView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.view.do {
            $0.backgroundColor = .customBlack
        }
        
        self.signInView.do {
            $0.delegate = self
        }
    }
    
    private let viewModel: SignInViewModel
    private let signInView = SignInView()
    
}

extension SignInViewController: SignInViewDelegate {
    func signInViewDidChangeEmailText(_ view: SignInView) {
        print("Email")
    }
    
    func signInViewDidChangePasswordText(_ view: SignInView) {
        print("Password")
    }
    
    func signInViewDidTapSignIn(_ view: SignInView) {
        print("Login")
    }
    
    
}
