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
    
    func setCurrentUser(email: String) {
        UserDefaults.standard.setValue(email, forKey: UserDefaultKey.currentUserEmail.value)
    }
    
    var currentUserEmail: String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.currentUserEmail.value)
    }
    
    func setUserHasLoggedIn() {
        UserDefaults.standard.setValue(true, forKey: UserDefaultKey.isUserLoggedIn.value)
    }
    
    func logOut() {
        UserDefaults.standard.setValue(false, forKey: UserDefaultKey.isUserLoggedIn.value)
        UserDefaults.standard.setValue(nil, forKey: UserDefaultKey.currentUserEmail.value)
    }
    
    func appHasBeenLaunchedOnce() {
        UserDefaults.standard.setValue(true, forKey: UserDefaultKey.appHasBeenLaunchedOnce.value)
    }
    
    var hasAppBeenLaunchedOnce: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.appHasBeenLaunchedOnce.value)
    }
    
}
