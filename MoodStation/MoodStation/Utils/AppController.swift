//
//  AppController.swift
//  MoodStation
//
//  Created by Yongwoo Marco on 2022/04/15.
//

import Foundation
import SwiftUI

extension Notification.Name {
    static let authStateDidChange = NSNotification.Name("authStateDidChange")
}

enum AppControllerError: Error {
    case logInFail
}

final class AppController {
    static let shared = AppController()
    
    private var _signInUser: User?
    
    private init() {
        registerAuthStateDidChangeEvent()
    }
    
    private func registerAuthStateDidChangeEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkLogIn),
                                               name: .authStateDidChange,
                                               object: nil)
    }
    
    @objc private func checkLogIn() {
        if let user = UserDefaults.standard.getObject(forKey: "user", castTo: User.self) {
            self._signInUser = user
        } else {
            
        }
    }
}

extension AppController {
    var user: User? {
        self._signInUser
    }
    
    func logOut() {
        self._signInUser = nil
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    func logIn(_ userInput: (id: String, password: String), completed: @escaping (Result<User, AppControllerError>) -> Void) {
        // 네트워크 통신 checkLog
        if let user = User(name: "통신된 이름", email: userInput.id, password: userInput.password, userImagePath: nil) as? User {
            UserDefaults.standard.setObject(user, forKey: "user")
            self._signInUser = user
            completed(.success(user))
        } else {
            
            completed(.failure(.logInFail))
        }
    }
}
