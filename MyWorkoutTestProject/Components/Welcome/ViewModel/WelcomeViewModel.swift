//
//  WelcomeViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import Foundation

final class WelcomeViewModel {
    
    private let loginAPIService = LoginAPIService()
    
    func verify(email: String, onSuccess: @escaping (Bool) -> Void, onError: (String) -> Void) {
        loginAPIService.verify(email: email, onSuccess: { (isVerified) in
            onSuccess(isVerified)
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
