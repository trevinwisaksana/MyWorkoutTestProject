//
//  WelcomePresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import Foundation

final class WelcomePresenter {
    
    var presenter: WelcomeViewController
    
    init(_ presenter: WelcomeViewController) {
        self.presenter = presenter
    }
    
    func presentWelcomeBackScreen(withEmail email: String) {
        presenter.navigationController?.pushViewController(SignInViewController(email: email), animated: true)
    }
    
    func presentSignUpScreen(withEmail email: String) {
        presenter.navigationController?.pushViewController(SignUpViewController(email: email), animated: true)
    }
    
}
