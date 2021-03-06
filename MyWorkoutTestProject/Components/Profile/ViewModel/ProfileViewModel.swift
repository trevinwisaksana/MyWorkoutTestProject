//
//  ProfileViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

final class ProfileViewModel {
    
    private let userAPIService = UserAPIService()
    
    private var userProfile: UserProfile?
    
    // MARK: -
    
    func configure(_ view: ProfileView) {
        view.emailLabel.text = emailText
        view.genderLabel.text = genderText
    }
    
    var emailText: String? {
        return userProfile?.email
    }
    
    var genderText: String? {
        return userProfile?.gender.title
    }
    
    // MARK: - API
    
    func getUserProfile(onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        guard let currentUserEmail = UserSession.shared.currentUserEmail else {
            return
        }
        
        userAPIService.getUserProfile(email: currentUserEmail, onSuccess: { (response) in
            self.userProfile = UserProfile(data: response)
            
            onSuccess()
            
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
    func logout(onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        userAPIService.logout(onSuccess: {
            UserSession.shared.logOut()
            
            onSuccess()
            
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
