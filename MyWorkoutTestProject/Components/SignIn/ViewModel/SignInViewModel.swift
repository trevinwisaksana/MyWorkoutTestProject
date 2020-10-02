//
//  SignInViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class SignInViewModel {
    
    private let loginAPIService = LoginAPIService()
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func configure(_ view: SignInView) {
        view.emailTextField.text = email
    }
    
    // MARK: - API
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        loginAPIService.login(email: email, password: password, onSuccess: {
            UserSession.shared.setCurrentUser(email: email)
            onSuccess()
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
