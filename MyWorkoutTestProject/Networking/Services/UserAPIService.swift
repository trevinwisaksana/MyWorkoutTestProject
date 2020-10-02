//
//  UserAPIService.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class UserAPIService {
    
    func getUserProfile(onSuccess: @escaping ([String : Any]) -> Void, onError: (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onSuccess([:])
        }
    }
    
    func logout(onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onSuccess()
        }
    }
    
}
