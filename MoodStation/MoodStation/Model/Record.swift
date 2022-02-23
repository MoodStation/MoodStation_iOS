//
//  Record.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/02/23.
//

import Foundation.NSDate

struct Record: Identifiable, Codable {
    let id: Int
    let date: Date
    let mood: Int
    let keyword: [String]
    let imagePath: String
    let note: String
}
