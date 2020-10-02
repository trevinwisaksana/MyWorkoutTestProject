//
//  SignUpViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

final class SignUpViewModel {
    
    private let registrationAPIService = RegistrationAPIService()
    
    /// Used to prevent the done button in keyboard to transition to next screen.
    var viewControllerIsExiting: Bool = false
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func configure(_ view: SignUpView) {
        view.emailTextField.text = email
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - API
    
    func signUp(email: String?, password: String?, gender: Gender?, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        guard let email = email, isValidEmail(email) else {
            onError("Please enter a valid email.")
            return
        }
        
        guard let password = password else {
            onError("Please enter your password.")
            return
        }
        
        guard let genderSelected = gender else {
            onError("Please select a gender.")
            return
        }
        
        registrationAPIService.register(email: email, password: password, gender: genderSelected, onSuccess: {
            
            self.viewControllerIsExiting = false
            
            UserSession.shared.setUserHasLoggedIn()
            UserSession.shared.setCurrentUser(email: email)
            
            onSuccess()
            
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
