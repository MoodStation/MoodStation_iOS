//
//  User.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/03/23.
//

struct User: Codable {
    let name: String
    let email: String
    let password: String?
    let userImagePath: String?
    
    init(name: String, email: String, password: String? = nil, userImagePath: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.userImagePath = userImagePath
    }
}
