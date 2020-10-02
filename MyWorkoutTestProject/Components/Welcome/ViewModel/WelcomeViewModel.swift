//
//  WelcomeViewModel.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import Foundation

final class WelcomeViewModel {
    
    private let loginAPIService = LoginAPIService()
    
    /// Used to prevent the done button in keyboard to transition to next screen.
    var viewControllerIsExiting: Bool = false
    
    func isValidEmail(_ email: String) -> Bool {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        
        return emailPredicate.evaluate(with: email)
    }
    
    func verify(email: String, onSuccess: @escaping (Bool) -> Void, onError: (String) -> Void) {
        guard isValidEmail(email) else {
            onError("Please enter a valid email.")
            return
        }
        
        loginAPIService.verify(email: email, onSuccess: { (isVerified) in
            self.viewControllerIsExiting = false
            onSuccess(isVerified)
        }, onError: { (errorMessage) in
            onError(errorMessage)
        })
    }
    
}
