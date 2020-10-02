//
//  LoginAPIService.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import Foundation

final class LoginAPIService {
    
    private let dummyDatabase = DummyDatabase()
    
    func verify(email: String, onSuccess: @escaping (Bool) -> Void, onError: (String) -> Void) {
        if email == "registered@email.com" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onSuccess(true)
            }
            
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onSuccess(false)
        }
    }
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        if dummyDatabase.isUserVerified(email: email, password: password) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onSuccess()
            }
            
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
        }
    }
    
}
