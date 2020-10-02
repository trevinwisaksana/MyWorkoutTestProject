//
//  DummyDatabase.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class DummyDatabase {
    
    func isUserVerified(email: String, password: String) -> Bool {
        if email == "registered@email.com" && password == "password" {
            return true
        }
        
        return false
    }
    
    func retrieveUserData(withEmail email: String) -> [String : String]? {
        guard let usersRegisteredData = UserDefaults.standard.object(forKey: UserDefaultKey.userData.value) as? [String : [String : String]] else {
            return nil
        }
      
        return usersRegisteredData[email]
    }
    
    func retrieveUsersRegistered() -> [String : [String : String]] {
        guard let usersRegisteredData = UserDefaults.standard.object(forKey: UserDefaultKey.userData.value) as? [String : [String : String]] else {
            return [:]
        }
        
        return usersRegisteredData
    }
    
    func registerUser(data: [String : String], onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        guard let email = data["email"] else {
            return
        }
        
        guard retrieveUserData(withEmail: email) == nil else {
            onError("Email has already been registered")
            return
        }
        
        var usersRegistered = retrieveUsersRegistered()
        usersRegistered[email] = data
        
        UserDefaults.standard.set(usersRegistered, forKey: UserDefaultKey.userData.value)
        
        onSuccess()
    }
    
}
