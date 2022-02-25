//
//  HomeViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    init(viewModel: HomeViewModel) {
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
        
    }
    
    private func setupAttributes() {
        
    }
    
    private let viewModel: HomeViewModel
}
