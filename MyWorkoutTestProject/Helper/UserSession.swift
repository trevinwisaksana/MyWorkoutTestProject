//
//  UserSession.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class UserSession {
    static let shared = UserSession()
    
    var isUserLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.isUserLoggedIn.value)
    }
    
    func setUserIsLoggedIn() {
        UserDefaults.standard.setValue(true, forKey: UserDefaultKey.isUserLoggedIn.value)
    }
    
}
