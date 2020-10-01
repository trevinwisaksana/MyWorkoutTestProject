//
//  LoginAPIService.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import Foundation

final class LoginAPIService {
    
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
    
    func signUp(email: String, password: String, gender: Gender, onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        if email != "registered@email.com" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onSuccess()
            }
            
            return
        }
        
        onError("Email has already been registered.")
    }
    
}
