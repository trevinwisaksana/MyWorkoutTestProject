//
//  DummyDatabase.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class DummyDatabase {
    
    func retrieveUserRegistered() -> [String: String]? {
        return UserDefaults.standard.object(forKey: UserDefaultKey.userData.value) as? [String : String]
    }
    
    func registerUser(data: [String : String]) {
        UserDefaults.standard.set(data, forKey: UserDefaultKey.userData.value)
    }
    
}
