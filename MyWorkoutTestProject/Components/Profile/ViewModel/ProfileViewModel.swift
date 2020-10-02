//
//  ProfileViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

final class ProfileViewModel {
    
    private let userAPIService = UserAPIService()
    
    func getUserProfile(onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        userAPIService.getUserProfile(onSuccess: { (response) in
            
        }, onError: { (errorMessage) in
            
        })
    }
    
    func logout(onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        userAPIService.logout(onSuccess: {
            
        }, onError: { (errorMessage) in
            
        })
    }
    
}
