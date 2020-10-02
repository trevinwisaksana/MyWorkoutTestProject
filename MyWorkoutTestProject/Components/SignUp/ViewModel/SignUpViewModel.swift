//
//  SignUpViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

final class SignUpViewModel {
    
    private let registrationAPIService = RegistrationAPIService()
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func configure(_ view: SignUpView) {
        view.emailTextField.text = email
    }
    
    // MARK: - API
    
    func signUp(email: String, password: String, gender: Gender, onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        registrationAPIService.register(email: email, password: password, gender: gender, onSuccess: {
            UserSession.shared.setUserHasLoggedIn()
            onSuccess()
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
