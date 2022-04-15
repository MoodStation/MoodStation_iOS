//
//  DefaultTableView.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/04/15.
//

import Foundation

protocol DefaultTableViewModel {
    associatedtype CellModel
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModel(at indexPath: IndexPath) -> CellModel?
}
