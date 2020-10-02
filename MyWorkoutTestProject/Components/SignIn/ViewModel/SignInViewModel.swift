//
//  SignInViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class SignInViewModel {
    
    private let loginAPIService = LoginAPIService()
    
    /// Used to prevent the done button in keyboard to transition to next screen.
    var viewControllerIsExiting: Bool = false
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func configure(_ view: SignInView) {
        view.emailTextField.text = email
    }
    
    // MARK: - API
    
    func login(email: String?, password: String?, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        guard let email = email else {
            onError("Please enter your email.")
            return
        }
        
        guard let password = password else {
            onError("Please enter your password.")
            return
        }
        
        loginAPIService.login(email: email, password: password, onSuccess: {
            
            self.viewControllerIsExiting = true
            
            UserSession.shared.setUserHasLoggedIn()
            UserSession.shared.setCurrentUser(email: email)
            
            onSuccess()
            
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
