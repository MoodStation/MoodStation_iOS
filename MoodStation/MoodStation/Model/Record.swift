//
//  Record.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/02/23.
//
import Foundation.NSDate

extension DateFormatter {
    static let recordDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

enum CodableError: Error {
    case dateDecodingFail
    case moodDecodingFail
}

struct Record: Identifiable, Codable {
    let id: Int
    let date: Date
    let mood: GradientStyle
    let keyword: [String]
    let imagePath: String?
    let note: String
    
    private enum CodingKeys: String, CodingKey {
        case id, date, mood, keyword, imagePath, note
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        let stringDate = try container.decode(String.self, forKey: .date)
        guard let date = DateFormatter.recordDate.date(from: stringDate) else {
            throw CodableError.dateDecodingFail
        }
        self.date = date
        self.keyword = try container.decode([String].self, forKey: .keyword)
        let moodNumber = try container.decode(Int.self, forKey: .mood)
        guard let style = GradientStyle(rawValue: moodNumber) else {
            throw CodableError.moodDecodingFail
        }
        self.mood = style
        self.imagePath = try container.decode(String.self, forKey: .imagePath)
        self.note = try container.decode(String.self, forKey: .note)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        let stringDate = DateFormatter.recordDate.string(from: self.date)
        try container.encode(stringDate, forKey: .date)
        try container.encode(self.mood.rawValue, forKey: .mood)
        try container.encode(self.keyword, forKey: .keyword)
        try container.encode(self.imagePath, forKey: .imagePath)
        try container.encode(self.note, forKey: .note)
    }
}

