//
//  ServerRepository.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/02/23.
//
import Foundation

struct ServerRepository: Repository {
    func create(item: Record, completed: @escaping (Bool) -> Void) {

    }

    func read(id: Int, completed: @escaping (Result<Record, Error>) -> Void) {

    }

    func update(item: Record, completed: @escaping (Bool) -> Void) {

    }

    func delete(item: Record, completed: @escaping (Bool) -> Void) {

    }

    func fetchItems(completed: @escaping (Result<[Record], Error>) -> Void) {

    }
}
