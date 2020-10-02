//
//  UserAPIService.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class UserAPIService {
    
    private let dummyDatabase = DummyDatabase()
    
    func getUserProfile(onSuccess: @escaping ([String : String]) -> Void, onError: (String) -> Void) {
        guard let userData = dummyDatabase.retrieveUserRegistered() else {
            onError("Failed to retrieve user data")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onSuccess(userData)
        }
    }
    
    func logout(onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onSuccess()
        }
    }
    
}
