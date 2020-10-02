//
//  ProfileAPIService.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class ProfileAPIService {
    
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
