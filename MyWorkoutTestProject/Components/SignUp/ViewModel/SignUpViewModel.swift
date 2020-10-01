//
//  SignUpViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

final class SignUpViewModel {
    
    private let loginAPIService = LoginAPIService()
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func configure(_ view: SignUpView) {
        view.emailTextField.text = email
    }
    
    // MARK: -
    
    func signUp(email: String, password: String, gender: Gender, onSuccess: @escaping () -> Void, onError: (String) -> Void) {
        loginAPIService.signUp(email: email, password: password, gender: gender, onSuccess: {
            onSuccess()
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
