//
//  RecordViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/06.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class RecordViewController: UIViewController {
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.render(viewModel: self.calendarViewModel)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(viewModel: RecordCalendarViewModel) {
        viewModel.sectionDidUpdate
            .subscribe(onNext: { [weak self] in
                self?.calendarView.reloadData()
            })
            .disposed(by: disposeBag)
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
        
        self.calendarView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private let navigationView = NavigationView(frame: .zero)
    private let recordView = RecordView(frame: .zero)
    private let viewModel: RecordViewModel
    
    private let calendarView = RecordCalendarView()
    private let calendarViewModel = RecordCalendarViewModel()
    
    private let disposeBag = DisposeBag()
    
}

extension RecordViewController: RecordViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
    }
    
}

extension RecordViewController: RecordViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // TODO: - ViewModel 에서 shouldShowFooter 로 받기
        if section == 0 {
            return self.calendarView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            // TODO: - Calendar 의 높이가 -40 만큼 줄을 수 있음 -> ViewModel 에서 Height 판별하도록 하기
            return 307
        }
        
        return .zero
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

extension RecordViewController: RecordCalendarViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.calendarViewModel.selectItem(at: indexPath)
    }
    
    func recordCalendarViewLeftButtonDidClick(_ view: RecordCalendarView) {
        // TODO: - 날짜 왼쪽 변경
        print("LEFT")
    }
    
    func recordCalendarViewRightButtonDidClick(_ view: RecordCalendarView) {
        // TODO: - 날짜 오른쪽 변경
        print("RIGHT")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
}

extension RecordViewController: RecordCalendarViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.calendarViewModel.numberOfItmesInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.calendarViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.calendarViewModel.cellItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        switch item {
        case .week(let text):
            guard let cell = collectionView.dequeueReusableCell(RecordCalendarWeeklyCollectionCell.self, at: indexPath) else {
                return UICollectionViewCell()
            }
            
            cell.configure(text: text)
            return cell
            
        case .day(let model):
            guard let cell = collectionView.dequeueReusableCell(RecordCalendarDayCollectionViewCell.self, at: indexPath) else {
                return UICollectionViewCell()
            }
            
            cell.configure(model: model)
            return cell
        }
    }
    
}
