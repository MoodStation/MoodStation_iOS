//
//  RecordViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then

final class RecordViewController: UIViewController {
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.view.addSubview(self.recordView)
        self.recordView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        self.view.backgroundColor = .customBlack
        
        self.navigationView.do {
            $0.delegate = self
            $0.configure(type: .back)
        }
        
        self.recordView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private let navigationView = NavigationView(frame: .zero)
    private let recordView = RecordView(frame: .zero)
    private let viewModel: RecordViewModel
    
}

extension RecordViewController: RecordViewDelegate {
    
    
}

extension RecordViewController: RecordViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = self.viewModel.cellType(at: indexPath) else {
            return UITableViewCell()
        }
        
        switch type {
        case .title(let model):
            guard let cell = tableView.dequeueReusableCell(TextOnlyTableViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: model)
            return cell
            
        case .singleRecording(let model):
            guard let cell = tableView.dequeueReusableCell(RecordSingleRecordingCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: model)
            return cell
            
        case .image(let model):
            guard let cell = tableView.dequeueReusableCell(RecordImageViewCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: model)
            return cell
            
        case .colorChip(let model):
            guard let cell = tableView.dequeueReusableCell(RecordColorChipsCell.self, at: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(model: model)
            return cell
            
        case .keyword(let model):
            guard let cell = tableView.dequeueReusableCell(RecordKeywordChipCell.self, at: indexPath) else {
                return UITableViewCell()
            }
//            cell.configure(model: model)
            return cell
        }
    }
    
    
}

extension RecordViewController: NavigationViewDelegate {
    
    func navigationViewDeleagteDidClickLeftButton(_ view: NavigationView) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
