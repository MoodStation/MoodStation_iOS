//
//  LogInSession.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/04/15.
//

import Foundation

protocol LogInSession where Self: AnyObject {
    var appController: AppController { get set }
    var logInUser: User? { get set }
}

extension LogInSession {
    func logOut() {
        self.appController.logOut()
        self.logInUser = nil
    }
    
    func logIn(userInput: (String, String)) {
        self.appController.logIn(userInput) { result in
            switch result {
            case .success(let user):
                self.logInUser = user
            case .failure(let error):
                print(error) // 수정 필요
            }
        }
    }
}
